Language :: enum
{
    French;
    English;
}

LocalizedString :: [2]string;

LS :: LocalizedString;

Text_Student : LS : .[
    "Étudiant en Informatique",
    "Computer Science Student",
];

Text_Presentation : LS : .[
    "Étudiant passionné de 21 ans à l'école 42 Lyon, je cherche un stage de 6 mois pour mettre à profit mon parcours d’autodidacte depuis 10 ans dans la programmation, en particulier dans le développement de jeux vidéo. Des bases solides dans la programmation ainsi que mon intérêt pour la résolution de problème alimentent mon ambition de contribuer à des projets complexes tout en continuant à grandir en tant que développeur.",
    ""
];

Text_Contact_Info_Header : LS : .[
    "Contacts et Liens",
    "Links"
];

Text_Contact_Info :: "Lyon, France\n06 95 64 26 91\noumansour.stefan@gmail.com";

Text_Languages_Header : LS : .[
    "Langues",
    "Languages"
];

Text_Languages : LS : .[
    "Français\nAnglais",
    "English\nFrench"
];

Text_Soft_Skills : LS : .[
    "Résolution de problèmes\nSociable\nOrganisation\nEsprit créatif",
    "Problem solving\nSociability\nOrganization\nCreativity",
];

Text_Interests_Header : LS : .[
    "Centres d'Intérêt",
    "Interests"
];

Text_Interests : LS : .[
    "Programmation\nDessin\nEscalade\nJeux Vidéos",
    "Programming\nDrawing\nBouldering\nVideo Games"
];

Text_Projects_Header : LS : .[
    "Projets et Expériences",
    "Projects and Experiences"
];

Project :: struct
{
    dates : LS;
    name : LS;
    description : LS;
}

Projects :: Project.[
    .{
        .["2023 - présent","2023 - present"],
        .["Cubed","Cubed"],
        .[
"Recréation du jeu vidéo Minecraft de A à Z avec OpenGL. Ce projet toujours en développement fut l’opportunité d’en apprendre plus sur la génération procédurale. J’ai aussi pu pousser plus loin mes compétences en programmation dans le domaine de l’animation 3d, la programmation graphique et la programmation d’outils et d’interfaces via la librairie ImGui",

"TODO"
        ],
    },
    .{
        .["2022","2022"],
        .["Logiciel d'animation 3d","Skeletal animation demo"],
        .[
"Développement d’un logiciel de demo pour le langage de programmation Jai. Ce programme permet de charger un modèle 3d ainsi que des animations et de les jouer à l’écran. Le code source est fourni publiquement avec le langage.",

"TODO"
        ]
    },
    .{
        .["2020 - présent","2020 - present"],
        .["Beta testeur du langage de programmation Jai","Jai programming language beta tester"],
        .[
"Beta testeur d’un langage de programmation développé par le créateur des jeux vidéos Braid et The Witness. Le Jai est un langage actuellement en beta fermée pensé pour le jeu vidéo. Cette expérience fut l’opportunité de contribuer à un projet d’ampleur et de m’intégrer à une communauté de développeurs naissante, venant du monde entier et de domaines hétérogènes.",

"TODO"
        ]
    },
    .{
        .["2022","2022"],
        .["ft_irc","ft_irc"],
        .[
"Projet de serveur de chat IRC de l’école 42. Ce projet de groupe m’a appris les bases de la programmation de sockets en C++.",

"TODO"
        ]
    },
    .{
        .["2023","2023"],
        .["ft_transcendance","ft_transcendance"],
        .[
"Ce projet de groupe de l’école 42 vise à développer un jeu de pong et un chat en ligne en Javascript. J’ai pu apprendre un nouveau langage et de nouvelles technologies du web comme VueJS et Socket.io.",

"TODO"
        ]
    },
];

DatedEntry :: struct
{
    dates : LS;
    text : LS;
}

Text_Education_Header : LS : .[
    "Formation", "Education"
];

Education :: DatedEntry.[
    .{
        .["2021 - présent","2021 - present"],
        .["École 42 - Lyon","42 School - Lyon"]
    },
    .{
        .["2020 - 2021","2020 - 2021"],
        .["DUT informatique - IUT A de Lille","DUT informatique - IUT A de Lille"]
    },
    .{
        .["2020","2020"],
        .["Bac S option Sciences de l'Ingénieur mention très bien","Bac S option Sciences de l'Ingénieur mention très bien"]
    },
];

Text_Technical_Skills_Header : LS : .[
    "Compétences Techniques", "Technical Skills"
];

Text_Technical_Skills_General : LS : .[
    "Programmation bas niveau\nProgrammation graphique\nProgrammation d'outils\nAnimation 3d\nDéveloppement web",
    "Low level programming\nGraphics programming\nTools programming\n3d animation\nWeb development"
];

Text_Technical_Skills_Languages : LS : .[
    "C/C++\nC#\nAssembleur x86\nGLSL\nPython\nHTML/CSS\nJavascript/Typescript",
    "C/C++\nC#\nx86 Assembly\nGLSL\nPython\nHTML/CSS\nJavascript/Typescript"
];

Text_Technical_Skills_Other :: "OpenGL\nImGui\nUnity\nUnreal Engine\nBlender\nNestJS\nVueJS";
