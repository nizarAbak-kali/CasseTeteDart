part of jeu;

var niveauList = [
                  'tres_facile',
                  'facile',
                  'intermediaire',
                  'difficile',
                  'challenge'
                  ];


var niveauMap = {
                  'tres_facile': 'Très facile',
                  'facile': 'Facile',
                  'intermediaire' : 'Intermédiaire',
                  'difficile' : 'Difficile',
                  'challenge' : 'Challenge'
                    };

//nombre de cases sur le côté de la grille, par exemple 3 correspond à une grille de 3x3
var sideMap = {
                'tres_facile': 3,
                'facile': 4,
                'intermediaire' : 5,
                'difficile' : 6,
                'challenge' : 7
                };

//nombre de permutations initialement effectuées sur la grille avant de la présenter au joueur
var nombreDeDeplacementsMap = {
                                'tres_facile': 5,
                                'facile': 12,
                                'intermediaire' : 25,
                                'difficile' : 40,
                                'challenge' : 60
                               };

//temps raisonnable (en secondes) pour compléter une grille de ce niveau
//ce temps est utilisé dans le calcul du score obtenu par le joueur
var tempsNormalMap = {
                      'tres_facile': 3,
                      'facile': 30,
                      'intermediaire' : 120,
                      'difficile' : 400,
                      'challenge' : 1200
                     };