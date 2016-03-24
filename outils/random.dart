part of jeu;

int randomInt(int max) => new Random().nextInt(max);

randomListElement(List list) => list[randomInt(list.length)];

String randomColor() => randomListElement(listeDeCouleurs);

Cellule randomCellule(Cellules cellules) => randomListElement(cellules.list);