<?php

namespace App\Controller;

use App\Entity\InterestRateConfig;
use App\Repository\InterestRateConfigRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/configuracion/tasas")
 */
#[Route('/configuracion/tasas')]
class InterestRateConfigController extends AbstractController
{
    /**
     * @Route("/", name="app_interest_rate_index")
     */
    #[Route('/', name: 'app_interest_rate_index')]
    public function index(InterestRateConfigRepository $repo): Response
    {
        return $this->render('interest_rate_config/index.html.twig', [
            'rates' => $repo->findBy([], ['startDate' => 'DESC']),
        ]);
    }

    /**
     * @Route("/nueva", name="app_interest_rate_new", methods={"POST"})
     */
    #[Route('/nueva', name: 'app_interest_rate_new', methods: ['POST'])]
    public function new(Request $request, EntityManagerInterface $em, InterestRateConfigRepository $repo): Response
    {
        $rateValue = $request->request->get('rate');
        $startDateStr = $request->request->get('start_date');

        if ($rateValue && $startDateStr) {
            // Usamos DateTimeImmutable para coincidir con la entidad
            $startDate = new \DateTimeImmutable($startDateStr);

            // Cerrar la tasa anterior si está activa
            $lastRate = $repo->findOneBy(['endDate' => null]);
            if ($lastRate) {
                $lastRate->setEndDate($startDate->modify('-1 day'));
            }

            $newRate = new InterestRateConfig();
            $newRate->setRate($rateValue);
            $newRate->setStartDate($startDate);

            $em->persist($newRate);
            $em->flush();

            $this->addFlash('success', 'Tasa de interés actualizada exitosamente.');
        }

        return $this->redirectToRoute('app_interest_rate_index');
    }
}