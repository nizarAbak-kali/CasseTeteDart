Le but de ce casse-t�te est de positionner les cases de la grille de jeu dans la m�me configuration que sur la grille mod�le.

Le jeu comporte diff�rents niveaux de difficult�.


Programmation :

- Il aurait pu �tre int�ressant de faire h�riter les classes GrilleJeu et GrilleModele d'une classe m�re Grille, car ces deux classes comportent 
plusieurs m�thodes semblables. Je n'ai pas r�ussi � le faire car les constructeurs de ces deux classes re�oivent des param�tres
diff�rents.

- Les niveaux de difficult� proviennent du fichier niveau.dart pour faciliter les modifications.


Conception :

- La grilleJeu est g�n�r�e � partir de la grilleModele, qu'on copie avant d'effectuer un certain nombre de permutations 
sur cette grille originale. 
La raison pour laquelle on effectue des permutations � partir de la grille d'origine plut�t que de placer les cellules � des 
emplacements al�atoires est que je ne crois pas que toutes les combinaisons al�atoires de cellules permettraient de revenir 
� la grille originale.

- Le calcul des points obtenus � chaque partie d�pend du niveau (la taille de la grille, le nombre de permutations initialement
effectu�es sur cette grille, ainsi que la dur�e raisonnable pour compl�ter une grille de ce niveau), du nombre de permutations 
effectu�es par le joueur, et du temps �coul� depuis le d�but de la partie.