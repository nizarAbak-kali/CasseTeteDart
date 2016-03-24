part of jeu;

class Partie {
  
  GrilleModele grilleModele;
  GrilleJeu grilleJeu;
  
  //ce paramètre est utilisé pour le calcul du nombre de points obtenus pour la partie
  //correspond à un temps raisonnable (en secondes) que le joueur devrait mettre pour compléter une grille du niveau choisi
  int tempsNormal; 
  
  bool gagne = false;
  
  Partie(this.grilleModele, this.grilleJeu){
    tempsNormal = tempsNormalMap[niveauSelected];
    grilleJeu.associerAPartie(this);
    init();
  }
  
  bool init(){
    gagne = false;
    chrono.demarrer();
    query("#resultat").innerHtml = "&nbsp;";
    query("#scorePartie").innerHtml = "&nbsp;";
  }
  
  bool verifierSiGagne(){
    Cellule celluleModele;
    int incr = 0;
    for(Cellule cellule in grilleJeu.cellules){
      celluleModele = grilleModele.getCellule(cellule.i, cellule.j);
      if(celluleModele.couleur != cellule.couleur){
        return false;
      }
    }
    gagnerLaPartie();
    return true;
  }
  
  void gagnerLaPartie(){
    if(!gagne){
      gagne = true;
      chrono.stop();
      query("#resultat").innerHtml = "BRAVO !";
      afficherPoints();
    }
  }
  
  void afficherPoints(){    
    int pointsPartie = calculerPointsPartie();
    query("#scorePartie").innerHtml = "Vous venez de gagner $pointsPartie points !";
    
    int pointsTotal = parseInt((query("#points").innerHtml).split(':')[1]);
    pointsTotal += pointsPartie;
    query("#points").innerHtml = 'Points accumulés : ${pointsTotal.toString()}';
  }
  
  int calculerPointsPartie(){
    int chronoSecondes = chrono.getTempsEcoule();
    int pointsPartie = sqrt(sqrt((pow(nombreCasesCote,3) * pow(nombreDeDeplacementsSurGrilleModele,4) / grilleJeu.nombreDeCoups / chronoSecondes * pow(tempsNormal, 2)))).toInt();
    return pointsPartie;
  }
  
  void delete() {
    grilleModele.clear();
    grilleJeu.clear();
    chrono.stop();
    chrono.remettreAZero();
    gagne = false;
  }
  
  bool estGagnee(){
    return gagne;
  }
}