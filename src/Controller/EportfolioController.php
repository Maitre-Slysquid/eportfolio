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
            'prenom' => 'Yessine',
            'nom' => 'Kouada',
            'groupe_tp' => 'TPA1',
            'presentation' => 'Passionate Networks & Telecommunications student aiming to specialize in cybersecurity, currently preparing for CISCO CCNA certification.',
            'autres_infos' => [
                'email' => 'kouadayessine@gmail.com',
                'ville' => 'Roanne',
                'formation' => 'BUT Networks & Telecommunications',
            ],
            'objectifs' => [
                'short_term' => 'Complete CCNA Certification',
                'mid_term' => 'Specialize in Cybersecurity',
                'long_term' => 'Engineering School specializing in Network Security',
            ]
        ];
        return $this->render('eportfolio/page1.html.twig', [
            'infos' => $infos
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
        $infos = [
            'hobbies' => [
                [
                    'title' => 'Video Editing',
                    'description' => 'Creation of artistic videos using DaVinci Resolve and iPhone',
                    'icon' => 'fas fa-video'
                ],
                [
                    'title' => 'Writing',
                    'description' => 'Author of "Marcheur de la nuit"',
                    'icon' => 'fas fa-pen-fancy',
                    'book' => [
                        'title' => 'Marcheur de la nuit',
                        'excerpt' => "- T'es sur que c'est sans danger ?
    - Bien sur ! Tant que je suis la tu n'as rien à craindre.
    - C'est très rassurant effectivement.
    Les deux amis regardèrent l'écran devant eux.
    - Comment tu te trouves ?
    - C'est bluffant !
    Un souvenir se déroulait sous leurs yeux, ils s'apprêtaient à revoir une partie de leur vie.
    - Pourquoi tu voulais revenir ici déjà ?
    - Pour me souvenir une dernière fois de la joie que j'avais ressenti. Ce bonheur serait le plus beau cadeau de départ.
    - Je suis d'accord, c'est vraiment un sacré festival d'adieu.
    - Bon commençons !
    - Tu es sur de ne pas le regretter ?
    - Ne t'en fais pas, si elle m'a donné l'opportunité de la rejoindre ce n'est pas pour que je l'oublie.
    - Elle et les souvenirs que tu as d'elle je suppose.
    - On ne peut rien te cacher, ha ha ha.
    Le film commença."
                    ]
                ],
                [
                    'title' => 'Gaming',
                    'description' => 'Passionate about solo gaming experiences',
                    'icon' => 'fas fa-gamepad'
                ],
                [
                    'title' => 'Manga & Anime',
                    'description' => 'Enthusiast of various manga genres and romance anime',
                    'icon' => 'fas fa-book-open'
                ]
            ],
            'personal_info' => [
                'prenom' => 'Yessine',
                'nom' => 'Kouada',
                'groupe_tp' => 'TPA1',
                'location' => 'Roanne',
                'interests' => 'Cybersecurity enthusiast'
            ]
        ];
        
        return $this->render('eportfolio/aboutme.html.twig', [
            'infos' => $infos
        ]);
    }
}
