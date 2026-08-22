<?php

namespace App\Controller;

use App\Repository\SystemConfigRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class PublicPortalController extends AbstractController
{
    #[Route('/', name: 'app_public_portal')]
    #[Route('/portal', name: 'app_public_portal_legacy')]
    public function index(SystemConfigRepository $repo): Response
    {
        $configs = [];
        foreach ($repo->findAll() as $c) {
            $configs[$c->getConfigKey()] = $c->getConfigValue();
        }

        return $this->render('public_portal/index.html.twig', [
            'configs' => $configs,
        ]);
    }
}
