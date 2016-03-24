part of jeu;

class GrilleModele {

  CanvasElement canvas;
  CanvasRenderingContext2D context;

  num longueurCote;
  int nombreCasesCote;
  num tailleCase;
    
  Cellules cellules;
  Cellule celluleVide;

  GrilleModele(this.canvas, this.nombreCasesCote) {
    
    if (canvas.width != canvas.height) {
      throw new Exception(
          'Le canvas doit être un carré.');
    }
    
    context = canvas.getContext('2d');
    longueurCote = canvas.width;
    tailleCase = longueurCote / nombreCasesCote;
    
    genererGrilleAleatoire();
    draw();
  }
  
  void genererGrilleAleatoire(){
    cellules = new Cellules();
    var cellule;
    for (var i = 0; i < nombreCasesCote; i++) {
      for (var j = 0; j < nombreCasesCote; j++) {
        cellule = new Cellule(this, i, j);
        cellule.couleur = randomColor();
        cellules.add(cellule);
      }
    }
    celluleVide = getCellule(nombreCasesCote-1, nombreCasesCote-1);
    celluleVide.couleur = couleurCelluleVide;
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
}
