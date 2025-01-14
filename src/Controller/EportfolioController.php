<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class EportfolioController extends AbstractController{
    #[Route('/eportfolio', name: 'app_eportfolio')]
    public function index(): Response
    {
        return $this->render('eportfolio/index.html.twig', [
            'controller_name' => 'EportfolioController',
        ]);
    }
    #[Route('/eportfolio/page1', name: 'app_eportfolio_page1')]
    public function page1(): Response
    {
        $infos = [
            'prenom' => 'Votre Prénom',
            'nom' => 'Votre Nom',
            'groupe_tp' => 'Votre Groupe',
            'presentation' => 'Your presentation text in English',
            'autres_infos' => [
            'email' => 'votre@email.com',
            'age' => '20',
            'ville' => 'Votre Ville',
            'formation' => 'BUT Réseaux et Télécommunications'
            ]
        ];
        return $this->render('eportfolio/page1.html.twig', [
            'controller_name' => 'EportfolioController',
            'infos' => $infos,
        ]);
    }
    #[Route('/eportfolio/page2', name: 'app_eportfolio_page2')]
    public function page2(): Response
    {
        return $this->render('eportfolio/page2.html.twig', [
            'controller_name' => 'EportfolioController',
        ]);
    }
    #[Route('/eportfolio/aboutme', name: 'app_eportfolio_aboutme')]
    public function aboutme(): Response
    {
        
        return $this->render('eportfolio/aboutme.html.twig', [
            'controller_name' => 'EportfolioController',
        ]);
    }
}
