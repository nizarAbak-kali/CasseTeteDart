Le but de ce casse-tête est de positionner les cases de la grille de jeu dans la même configuration que sur la grille modèle.

Le jeu comporte différents niveaux de difficulté.


Programmation :

- Il aurait pu être intéressant de faire hériter les classes GrilleJeu et GrilleModele d'une classe mère Grille, car ces deux classes comportent 
plusieurs méthodes semblables. Je n'ai pas réussi à le faire car les constructeurs de ces deux classes reçoivent des paramètres
différents.

- Les niveaux de difficulté proviennent du fichier niveau.dart pour faciliter les modifications.


Conception :

- La grilleJeu est générée à partir de la grilleModele, qu'on copie avant d'effectuer un certain nombre de permutations 
sur cette grille originale. 
La raison pour laquelle on effectue des permutations à partir de la grille d'origine plutôt que de placer les cellules à des 
emplacements aléatoires est que je ne crois pas que toutes les combinaisons aléatoires de cellules permettraient de revenir 
à la grille originale.

- Le calcul des points obtenus à chaque partie dépend du niveau (la taille de la grille, le nombre de permutations initialement
effectuées sur cette grille, ainsi que la durée raisonnable pour compléter une grille de ce niveau), du nombre de permutations 
effectuées par le joueur, et du temps écoulé depuis le début de la partie.