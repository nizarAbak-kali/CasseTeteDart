part of jeu;

class GrilleJeu {
  
  CanvasElement canvas;
  CanvasRenderingContext2D context;
  GrilleModele grilleModele;
  Partie partie;

  num longueurCote;
  int nombreCasesCote;
  num tailleCase;

  //nombre de permutations effectuées automatiquement sur la grille avant de la présenter au joueur
  //dépend du niveau de la partie
  int nombreDeDeplacementsSurGrilleModele; 

  Cellules cellules;
  Cellule celluleVide;
  
  int nombreDeCoups = 0; //nombre de permutations effectuées par le joueur depuis le début de la partie
  
  GrilleJeu(this.canvas, this.nombreCasesCote, this.grilleModele, this.nombreDeDeplacementsSurGrilleModele){
    
    if (canvas.width != canvas.height) {
      throw new Exception(
          'Le canvas doit être un carré.');
    }
    
    longueurCote = canvas.width;
    context = canvas.getContext('2d');
    tailleCase = longueurCote / nombreCasesCote;

    copierGrilleModele();
    melangerCellules();
    draw();
  }
  
  void associerAPartie(Partie partie){
    this.partie = partie;
  }
  
  void copierGrilleModele(){
    cellules = new Cellules();
    var cellule;
    for (Cellule celluleModele in grilleModele.cellules) {
      cellule = new Cellule(this, celluleModele.i, celluleModele.j);
      cellule.couleur = celluleModele.couleur;
      cellules.add(cellule);
    }
    Cellule celluleVideModele = grilleModele.celluleVide;
    celluleVide = getCellule(celluleVideModele.i, celluleVideModele.j);
  }
  
  Cellule getCellule(int i, int j) {
    if (i >= nombreCasesCote || j >= nombreCasesCote) {
      throw new Exception(
          'Vous recherchez une cellule en dehors de la grille.');
    }
    for (Cellule cellule in cellules) {
      if (cellule.estSitueeEnPosition(i, j)) {
        return cellule;
      }
    }
  }
  
  void melangerCellules(){
    Cellules possibilitesDeplacement;
    Cellule cellulePrecedente;
    Cellule celluleADeplacer;
    for (int i=0; i<nombreDeDeplacementsSurGrilleModele; i++){
      possibilitesDeplacement = trouverCellulesDeplacementPossible();
      if(cellulePrecedente != null){
        possibilitesDeplacement.remove(cellulePrecedente); //pour ne pas faire la permutation inverse de la permutation précédente
      }
      celluleADeplacer = randomCellule(possibilitesDeplacement);
      cellulePrecedente = celluleVide;
      jouer(celluleADeplacer);
    }
  }
  
  Cellules trouverCellulesDeplacementPossible(){
    Cellules possibilitesDeplacement = new Cellules();
    int i = celluleVide.i;
    int j = celluleVide.j;
    if(i-1>=0){
      possibilitesDeplacement.add(getCellule(i-1,j));
    }
    if(i+1<nombreCasesCote){
      possibilitesDeplacement.add(getCellule(i+1,j));
    }
    if(j-1>=0){
      possibilitesDeplacement.add(getCellule(i,j-1));
    }
    if(j+1<nombreCasesCote){
      possibilitesDeplacement.add(getCellule(i,j+1));
    }
    return possibilitesDeplacement;
  }
  
  void jouer(Cellule cellule){
    cellule.swap(celluleVide);
    celluleVide = cellule;
  }
  
  void draw() {
    clear();
    colorierGrille();
  }
  
  void clear() {
    context.clearRect(0, 0, longueurCote, longueurCote);
  }
  
  void colorierGrille() {
    for (Cellule cellule in cellules) {
      colorierUneCase(cellule);
    }
  }
  
  void colorierUneCase(Cellule cellule) {
    num x = tailleCase * cellule.j;
    num y = tailleCase * cellule.i;
    context.beginPath();
    context.fillStyle = cellule.couleur;
    context.rect(x, y, tailleCase, tailleCase);
    context.fill();
    context.stroke();
    context.closePath();
  }
  
  void onMouseDown(MouseEvent e){
    if(!partie.estGagnee()){
      int j = (e.offsetX ~/ tailleCase).toInt();
      int i = (e.offsetY ~/ tailleCase).toInt();
      Cellule cellule = getCellule(i, j);
      if (cellule.estVoisineDe(celluleVide)){
        nombreDeCoups++;
        jouer(cellule);
      }
      draw();
      partie.verifierSiGagne();
    }
  }
}
