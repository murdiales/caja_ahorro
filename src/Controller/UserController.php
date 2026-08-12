<?php

namespace App\Controller;

use App\Entity\Account;
use App\Entity\User;
use App\Repository\UserRepository;
use App\Service\EmailService;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Attribute\Route;

#[Route('/user')]
final class UserController extends AbstractController
{
    #[Route('/', name: 'app_user_index', methods: ['GET'])]
    public function index(UserRepository $userRepository): Response
    {
        if (!$this->getUser()) {
            return $this->redirectToRoute('app_login');
        }

        return $this->render('user/index.html.twig', [
            'users' => $userRepository->findAll(),
        ]);
    }

    #[Route('/new', name: 'app_user_new', methods: ['GET', 'POST'])]
    public function new(
        Request $request,
        EntityManagerInterface $em,
        UserPasswordHasherInterface $passwordHasher,
        EmailService $emailService
    ): Response {
        if (!$this->getUser()) {
            return $this->redirectToRoute('app_login');
        }

        if ($request->isMethod('POST')) {
            $email = trim($request->request->get('email'));
            $firstName = trim($request->request->get('firstName'));
            $lastName = trim($request->request->get('lastName'));
            $identificationNumber = trim($request->request->get('identificationNumber'));
            $role = $request->request->get('role', 'ROLE_USER');
            
            // Capturar la fecha de ingreso (para socios nuevos o antiguos)
            $joinedAtInput = $request->request->get('joinedAt');
            $joinedDate = !empty($joinedAtInput) ? new \DateTime($joinedAtInput) : new \DateTime();

            $tempPassword = bin2hex(random_bytes(4));

            $user = new User();
            $user->setEmail($email);
            $user->setFirstName($firstName);
            $user->setLastName($lastName);
            $user->setIdentificationNumber($identificationNumber);
            $user->setRoles([$role]);

            $hashedPassword = $passwordHasher->hashPassword($user, $tempPassword);
            $user->setPassword($hashedPassword);

            $em->persist($user);

            // Generar número de cuenta: [Año (2 dígitos)] + [Mes (2 dígitos)] + [Cédula (últimos 4 dígitos)]
            $yearSuffix = $joinedDate->format('y');   // Ej: "26"
            $monthSuffix = $joinedDate->format('m');  // Ej: "08"
            $cedulaSuffix = substr($identificationNumber, -4); // Ej: "2949"
            
            $accountNumber = 'CTA-' . $yearSuffix . $monthSuffix . $cedulaSuffix; // Ej: "CTA-26082949"

            $account = new Account();
            $account->setUser($user);
            $account->setAccountNumber($accountNumber);
            $account->setCurrentBalance('0.00');
            $account->setOpenedAt($joinedDate);

            $em->persist($account);
            $em->flush();

            $resetUrl = $request->getSchemeAndHttpHost() . $this->generateUrl('app_login');
            $htmlContent = $this->renderView('email/welcome_user.html.twig', [
                'user' => $user,
                'accountNumber' => $accountNumber,
                'resetUrl' => $resetUrl,
            ]);

            if ($emailService->send($email, 'Bienvenido a la Caja de Ahorro - Activación de Cuenta', $htmlContent)) {
                $this->addFlash('success', sprintf('¡Usuario y cuenta %s creados con éxito! Correo enviado a %s.', $accountNumber, $email));
            } else {
                $this->addFlash('warning', sprintf('Usuario registrado con cuenta %s, pero el correo falló. Revise la consola de logs de email.', $accountNumber));
            }

            return $this->redirectToRoute('app_user_index');
        }

        return $this->render('user/new.html.twig');
    }

    #[Route('/{id}/resend-email', name: 'app_user_resend_email', methods: ['POST'])]
    public function resendEmail(
        User $user,
        Request $request,
        EmailService $emailService
    ): Response {
        if (!$this->getUser()) {
            return $this->redirectToRoute('app_login');
        }

        $accounts = $user->getAccounts();
        $accountNumber = count($accounts) > 0 ? $accounts->first()->getAccountNumber() : 'N/A';
        $resetUrl = $request->getSchemeAndHttpHost() . $this->generateUrl('app_login');

        $htmlContent = $this->renderView('email/welcome_user.html.twig', [
            'user' => $user,
            'accountNumber' => $accountNumber,
            'resetUrl' => $resetUrl,
        ]);

        if ($emailService->send($user->getEmail(), 'Caja de Ahorro - Notificación de Accesos', $htmlContent)) {
            $this->addFlash('success', sprintf('¡Correo de activación reenviado a %s!', $user->getEmail()));
        } else {
            $this->addFlash('danger', 'Error al procesar el envío del correo saliente.');
        }

        return $this->redirectToRoute('app_user_index');
    }

    #[Route('/{id}/edit', name: 'app_user_edit', methods: ['GET', 'POST'])]
    public function edit(
        User $user,
        Request $request,
        EntityManagerInterface $em,
        UserPasswordHasherInterface $passwordHasher
    ): Response {
        if (!$this->getUser()) {
            return $this->redirectToRoute('app_login');
        }

        if ($request->isMethod('POST')) {
            $user->setEmail($request->request->get('email'));
            $user->setFirstName($request->request->get('firstName'));
            $user->setLastName($request->request->get('lastName'));
            $user->setIdentificationNumber($request->request->get('identificationNumber'));
            $user->setRoles([$request->request->get('role')]);

            $newPassword = $request->request->get('password');
            if (!empty($newPassword)) {
                $user->setPassword($passwordHasher->hashPassword($user, $newPassword));
            }

            $em->flush();
            $this->addFlash('success', 'Usuario actualizado correctamente.');
            return $this->redirectToRoute('app_user_index');
        }

        return $this->render('user/edit.html.twig', ['user' => $user]);
    }

    #[Route('/{id}/delete', name: 'app_user_delete', methods: ['POST'])]
    public function delete(User $user, EntityManagerInterface $em): Response
    {
        if (!$this->getUser()) {
            return $this->redirectToRoute('app_login');
        }

        try {
            $em->remove($user);
            $em->flush();
            $this->addFlash('info', 'Usuario eliminado.');
        } catch (\Exception $e) {
            $this->addFlash('danger', 'No se puede eliminar un usuario con cuentas activas.');
        }

        return $this->redirectToRoute('app_user_index');
    }
}