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
    "Étudiant passionné de 21 ans poursuivant un diplôme en informatique, je cherche à mettre à profit mon parcours d’autodidacte depuis 10 ans dans la programmation, en particulier dans le développement de jeux vidéo. Des bases solides dans la programmation ainsi que mon intérêt pour la résolution de problème alimentent mon ambition de contribuer à des projets complexes tout en continuant à grandir en tant que développeur.",
    ""
];

Text_Contact_Info :: #string END
06 95 64 26 91
oumansour.stefan@gmail.com
https://github.com/ostef
https://www.linkedin.com/in/stefan-oumansour/
END

Text_Address : LS : .[

#string END
28/03/2002 - 21 ans
69 rue Sébastien Gryphe, 69007 Lyon
END,

#string END
03/28/2002 - 21 years old
69 rue Sébastien Gryphe, 69007 Lyon
END,

];

Project :: struct
{
    name : LS;
    description : LS;
    subtitle : LS;
}

Projects :: Project.[
    .{
        .["Cubed","Cubed"],
        .["Recréation du jeu vidéo Minecraft","Minecraft recreation"],
        .["Generation procedurale, moteur graphique, OpenGL, ImGui, collisions, animation",""],
    }
];
