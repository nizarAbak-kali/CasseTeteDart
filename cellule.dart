part of jeu;

//ce fichier correspond aux cases... Il était plus facile ici de parler de cellules car 'case' est un mot réservé du langage...

class Cellule {
  int i;
  int j;
  String couleur;
  var grille;
  
  Cellule(this.grille, this.i, this.j);
  
  bool estSitueeEnPosition(int i, int j) {
    if (this.i == i && this.j == j) {
      return true;
    }
    return false;
  }
  
  bool estVoisineDe(Cellule voisine) {
    if ((this.i == voisine.i && (this.j == voisine.j-1 || this.j == voisine.j+1)) || ((this.i == voisine.i-1 || this.i == voisine.i+1) && (this.j == voisine.j))) {
      return true;
    }
    return false;
  }
  
  void swap(Cellule autreCellule){
    String couleurTemp = this.couleur;
    this.couleur = autreCellule.couleur;
    autreCellule.couleur = couleurTemp;
  }
}

class Cellules {
  List list;

  Cellules() {
    list = new List();
  }

  void add(Cellule cellule) {
    list.add(cellule);
  }
  
  void remove(Cellule celluleASupprimer){
    list.removeAt(list.indexOf(celluleASupprimer));
  }

  Iterator iterator() {
    return list.iterator();
  }
}
