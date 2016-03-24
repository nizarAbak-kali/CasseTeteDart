part of jeu;

class Chrono {
  
  Timer timer;
  const int intervalle1s = 1000;
  int tempsEcoule = 0;  
  
  Chrono(){}
  
  void demarrer(){
    remettreAZero();
    timer = new Timer.repeating(intervalle1s, (t) => avancer());
  }
  
  void remettreAZero(){
    tempsEcoule = 0;
    query("#chrono").innerHtml = "00:00:00";
  }

  void avancer(){
    tempsEcoule++;
    query("#chrono").innerHtml = getAffichageChronoHHMMSS();
  }
  
  String getAffichageChronoHHMMSS(){
    int heures = (tempsEcoule ~/ 3600).toInt();
    String h = heures.toString();
    
    int minutes = ((tempsEcoule - 3600*heures) ~/ 60).toInt();
    String m = minutes.toString();
    
    int secondes = (tempsEcoule - 3600*heures - 60*minutes).toInt();
    String s = secondes.toString();
    
    String hh = heures<10?'0${h}':'${h}';
    String mm = minutes<10?'0${m}':'${m}';
    String ss = secondes<10?'0${s}':'${s}';
    
    String affichage = '${hh}:${mm}:${ss}';
    return affichage;
  }
  
  void stop(){
    timer.cancel();
  }
  
  int getTempsEcoule(){
    return tempsEcoule;
  }
}
