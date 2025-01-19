<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\HttpFoundation\BinaryFileResponse;


final class EportfolioController extends AbstractController{
    #[Route('/eportfolio', name: 'app_eportfolio')]
    public function index(): Response
    {
        return $this->render('eportfolio/index.html.twig', [
            'controller_name' => 'EportfolioController',
        ]);
    }
    #[Route('/eportfolio/accueil', name: 'app_eportfolio_accueil')]
    public function accueil(): Response
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
        return $this->render('eportfolio/accueil.html.twig', [
            'infos' => $infos
        ]);
    }
    #[Route('/eportfolio/cv', name: 'app_eportfolio_cv')]
    public function cv(): Response
    {
        return $this->render('eportfolio/cv.html.twig', [
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
    
    #[Route('/eportfolio/portfolio', name: 'app_eportfolio_portfolio')]
    public function portfolio(): Response
    {       
        $competences = [
            'AC111' => [
                'title' => 'Électricité fondamentale',
                'description' => 'Maîtrise des lois et mesures électriques',
                'level' => 65,
                'acquisition' => 2, // niveau 2/4 d'après l'image
                'icon' => 'fa-bolt',
                'quote' => "Bonne compréhension théorique des lois fondamentales",
                'skills' => ['Lois électriques', 'Mesures', 'Oscilloscope'],
                'strengths' => [
                    'Compréhension des lois fondamentales',
                    'Réalisation de mesures simples',
                    'Respect des procédures de sécurité'
                ],
                'preuve_path' => 'documents_de_preuve/AC0111.pdf',
                'analyse_path' => 'analyse_reflexives/AC0111.pdf'
            ],
            'AC113' => [
                'title' => 'Configuration Réseaux',
                'description' => 'Configuration de switchs et VLANs',
                'level' => 85,
                'acquisition' => 4, // niveau 4/4 validé
                'icon' => 'fa-network-wired',
                'quote' => "J'ai très vite compris comment configurer un switch à partir des TP",
                'skills' => ['CISCO', 'VLAN', 'Configuration Réseau'],
                'strengths' => [
                    'Configuration rapide des switchs',
                    'Maîtrise des VLANs',
                    'Tests de connectivité réussis'
                ],
                'preuve_path' => 'documents_de_preuve/AC0113.pdf',
                'analyse_path' => 'analyse_reflexives/AC0113.pdf'
            ],
            'AC114' => [
                'title' => 'Administration Système',
                'description' => 'Gestion des systèmes d\'exploitation',
                'level' => 70,
                'acquisition' => 4, // niveau 4/4 validé
                'icon' => 'fa-server',
                'quote' => "La pratique régulière sur machine a été essentielle pour la compréhension",
                'skills' => ['Linux', 'Windows', 'Administration'],
                'strengths' => [
                    'Maîtrise des commandes de base',
                    'Configuration système efficace',
                    'Documentation des procédures'
                ],
                'preuve_path' => 'documents_de_preuve/AC0114.pdf',
                'analyse_path' => 'analyse_reflexives/AC0114.pdf'
            ],
            'AC115' => [
                'title' => 'Diagnostic Réseau',
                'description' => 'Analyse et résolution de problèmes',
                'level' => 75,
                'acquisition' => 4, // niveau 4/4 validé
                'icon' => 'fa-search',
                'quote' => "J'ai réussi à maîtriser les outils de base comme Wireshark",
                'skills' => ['Wireshark', 'IOS', 'Analyse'],
                'strengths' => [
                    'Analyse approfondie des trames',
                    'Méthodologie de diagnostic',
                    'Résolution efficace des problèmes'
                ],
                'preuve_path' => 'documents_de_preuve/AC0115.pdf',
                'analyse_path' => 'analyse_reflexives/AC0115.pdf'
            ],
            'AC116' => [
                'title' => 'Installation Client',
                'description' => 'Installation et configuration de postes',
                'level' => 80,
                'acquisition' => 4, // niveau 4/4 validé
                'icon' => 'fa-desktop',
                'quote' => "Configuration réussie de postes dans des environnements simples",
                'skills' => ['Configuration', 'Virtualisation', 'Support'],
                'strengths' => [
                    'Installation système rapide',
                    'Configuration réseau complète',
                    'Support utilisateur efficace'
                ],
                'preuve_path' => 'documents_de_preuve/AC0116.pdf',
                'analyse_path' => 'analyse_reflexives/AC0116.pdf'
            ]
        ];
    
        $milestones = [
            [
                'title' => 'Premier Semestre',
                'description' => 'Maîtrise de la configuration des switchs Cisco et des VLANs',
                'skills' => ['CISCO', 'VLAN', 'Network Basics']
            ],
            [
                'title' => 'Certification CCNA en cours',
                'description' => 'Préparation de la certification "Présentation des réseaux"',
                'skills' => ['CCNA', 'Networking', 'Professional Development']
            ],
            [
                'title' => 'Projets Académiques',
                'description' => 'Configuration réussie de réseaux complexes lors des SAÉs',
                'skills' => ['Project Management', 'Network Configuration', 'Problem Solving']
            ]
        ];
    
        $objectives = [
            [
                'title' => 'CCNA',
                'progress' => 15,
                'description' => 'Début de la formation "Présentation des réseaux"'
            ],
            [
                'title' => 'Compétences Linux',
                'progress' => 70,
                'description' => 'Apprentissage des commandes de base'
            ]
        ];
    
        return $this->render('eportfolio/portfolio.html.twig', [
            'competences' => $competences,
            'milestones' => $milestones,
            'objectives' => $objectives
        ]);
    }

    // Routes pour télécharger les analyses réflexives

    #[Route('/eportfolio/portfolio/analyse/{code}', name: 'app_download_analyse')]
    public function downloadAnalyse(string $code): BinaryFileResponse
    {
        // Ajout de '0' après 'AC'
        $filePath = $this->getParameter('kernel.project_dir') . '/public/portfolio/analyses_reflexives/AC0' . $code . '.pdf';
        return new BinaryFileResponse($filePath);
    }

    #[Route('/eportfolio/portfolio/preuve/{code}', name: 'app_download_preuve')]
    public function downloadPreuve(string $code): BinaryFileResponse
    {
        // Ajout de '0' après 'AC'
        $filePath = $this->getParameter('kernel.project_dir') . '/public/portfolio/documents_de_preuves/AC0' . $code . '.pdf';
        return new BinaryFileResponse($filePath);
    }
}
