library jeu;

import 'dart:html';
import 'dart:isolate';
import 'dart:math' ;

part 'outils/color.dart';
part 'outils/niveau.dart';
part 'outils/random.dart';
part 'cellule.dart';
part 'grilleModele.dart';
part 'grilleJeu.dart';
part 'partie.dart';
part 'outils/chrono.dart';

CssStyleSheet styleSheet;
CanvasElement modelCanvas;
CanvasElement gameCanvas;

//le nombre de cases sur le côté de la grille, par exemple side=3 correspond à une grille de 3x3
int nombreCasesCote = 0; 

//la grille de jeu est générée à partir de la grille modèle, sur laquelle le programme effectue 
//un certain nombre de permutations avant de la présenter au joueur
int nombreDeDeplacementsSurGrilleModele = 0; 

String niveauSelected = '';
String previousNiveauSelected = '';

GrilleModele grilleModele;
GrilleJeu grilleJeu;
Partie partie;
Chrono chrono;

//rule utilisée pour mettre en évidence le bouton du niveau sélectionné
String niveauSelectedRule() {
  String rule = '''
    background-color: coral;
    color: #ffffff;
    ''';
  return rule;
}

//rule utilisée pour que le bouton du niveau précédemment sélectionné revienne à une apparence de bouton non sélectionné
String deselectNiveauRule() {
  String rule = '''
    color: #333333;
    font-size: 14px;
    font-weight: bold;
    background-color: silver;
    width: 120px;     
    ''';
  return rule;
}

void main() {
  styleSheet = document.styleSheets[0];
  chrono = new Chrono();
  genererMenu();
  selectionnerLePremierNiveau();
  nouveauJeu();
  query("#options").on.click.add(commencerNouvellePartie);
  document.query('#gameCanvas').on.mouseDown.add(onMouseDown);
}

//le menu contenant les niveaux et le bouton "Nouvelle partie", est généré automatiquement selon le contenu du fichier niveau.dart
void genererMenu(){
  Element section = document.query('#options');
  Element nav = new Element.tag('nav');
  section.children.add(nav);
  UListElement niveaux = new Element.tag('ul');
  niveaux.id = 'niveaux';
  nav.children.add(niveaux);
  for(String niveau in niveauList) {
    LIElement element = new Element.tag('li');
    element.innerHtml = '<button id="${niveau}">${niveauMap[niveau]}';
    niveaux.children.add(element);   
  }
  LIElement element = new Element.tag('li');
  element.innerHtml = '<button id="rejouer">Nouvelle partie';
  niveaux.children.add(element); 
}

//on appelle cette fonction au début, pour que le niveau le plus facile soit sélectionné par défaut
void selectionnerLePremierNiveau(){
  niveauSelected = niveauList[0];
  styleSheet.addRule(niveauSelector(niveauSelected), niveauSelectedRule());
}

//on calcule les paramètres selon le niveau sélectionné,
//puis on instancie la grille modèle, la grille de jeu et la partie
void nouveauJeu(){
  nombreCasesCote = sideMap[niveauSelected];
  nombreDeDeplacementsSurGrilleModele = nombreDeDeplacementsMap[niveauSelected];
  
  modelCanvas = document.query('#modelCanvas');
  grilleModele = new GrilleModele(modelCanvas, nombreCasesCote);

  gameCanvas = document.query('#gameCanvas');
  grilleJeu = new GrilleJeu(gameCanvas, nombreCasesCote, grilleModele, nombreDeDeplacementsSurGrilleModele);
  
  partie = new Partie(grilleModele, grilleJeu);
}

//on efface la partie précédente, et si le niveau sélectionné a changé, 
//on met en évidence le bouton du niveau sélectionné puis on lance une nouvelle partie
void commencerNouvellePartie(Event event){
  partie.delete();
  String bouton = event.target.id;
  if(niveauList.contains(bouton)){
    previousNiveauSelected = niveauSelected;
    niveauSelected = bouton;
    changerStyleBoutonNiveauSelectionne(niveauSelected);
  }
  nouveauJeu();
}

//fonction gérant l'affichage spécial du bouton du niveau sélectionné pour la partie
void changerStyleBoutonNiveauSelectionne(String niveau){
  styleSheet.addRule(niveauSelector(previousNiveauSelected), deselectNiveauRule());
  styleSheet.addRule(niveauSelector(niveauSelected), niveauSelectedRule());
}

//retourne le selector correspondant au bouton d'un niveau
String niveauSelector(String niveau){
  return '#${niveau}';
}

void onMouseDown(MouseEvent e) {
  grilleJeu.onMouseDown(e);
}