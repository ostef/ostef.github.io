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

    "I am a 21 year old computer science student at 42 Lyon looking for a 6 months internship. Although I study computer science at school, I have been a self taught programmer for 10 years, particularily in the field of video games. My self taught education made me develop problem solving and programming skills as well as autonomy, which I believe to be very important in the field. I am eager to work with other people and contribute to complex projects."
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
    "Résolution de problèmes\nSociable\nOrganisation\nEsprit créatif\nCurieux",
    "Problem solving\nSociability\nOrganization\nCreativity\nCurious",
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
"Recréation du jeu vidéo Minecraft de A à Z avec OpenGL. Durant ce projet toujours en développement j'ai pu en apprendre plus sur la génération procédurale, et pousser plus loin mes compétences en programmation d'animation 3d, la programmation graphique et la programmation d’outils via la librairie ImGui.",

"Minecraft recreation from scratch using OpenGL. This project is still in development and allowed me to learn more on the subject of procedural world generation. I also did a lot of 3d animation programming, graphics programming and tools programming using the ImGui library."
        ],
    },
    .{
        .["2022","2022"],
        .["Logiciel d'animation 3d","3d skeletal animation demo"],
        .[
"Développement d’un logiciel de demo pour le langage de programmation Jai. Ce programme permet de charger un modèle 3d ainsi que des animations et de les jouer à l’écran. Le code source est fourni publiquement avec le langage.",

"This is a demo program for the Jai programming language. It loads 3d models as well as 3d animations and plays them on the screen. The source code will be shipped with the Jai compiler when it will be publicly available."
        ]
    },
    .{
        .["2020 - présent","2020 - present"],
        .["Beta testeur du langage de programmation Jai","Jai programming language beta tester"],
        .[
"Beta testeur d’un langage de programmation développé par le créateur des jeux vidéos Braid et The Witness. Le Jai est un langage actuellement en beta fermée pensé pour le jeu vidéo. Cette expérience fut l’opportunité de contribuer à un projet d’ampleur et de m’intégrer à une communauté de développeurs naissante, venant du monde entier et de domaines hétérogènes.",

"Beta tester for a programming language made by the creator of the video games Braid and The Witness. Jai is a programming language in closed beta that is made for video game development. By taking part in the beta, I have been able to meet people from different programming fields in a new community."
        ]
    },
    .{
        .["2022","2022"],
        .["ft_irc","ft_irc"],
        .[
"Projet de serveur de chat IRC de l’école 42. Ce projet de groupe m’a appris les bases de la programmation de sockets en C++.",

"Implementation of the IRC protocol. During this 42 school group project, I learned how to use sockets for networking in C++."
        ]
    },
    .{
        .["2023","2023"],
        .["ft_transcendance","ft_transcendance"],
        .[
"Ce projet de groupe de l’école 42 vise à développer un jeu de pong et un chat en ligne en Javascript. J’ai pu apprendre un nouveau langage et de nouvelles technologies du web comme VueJS et Socket.io.",

"This is a 42 school web development project. We had to make a website in Typescript to play Pong and chat with friends. For this project I have used different frameworks and libraries such as VueJS and Socket.io."
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
        .["Bac S option Sciences de l'Ingénieur mention très bien","Bac S Engineering"]
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
