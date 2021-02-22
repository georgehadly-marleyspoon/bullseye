class GameModel {
  static const int SLIDER_START = 50;
  static const int SCORE_START = 0;
  static const int ROUND_START = 1;

  GameModel(this.target,
      [
        this.totalScore = SCORE_START,
        this.round = ROUND_START,
        this.current = SLIDER_START]);

  int target;
  int current;
  int totalScore;
  int round;
}