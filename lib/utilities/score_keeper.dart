class ScoreKeeper {
  int _playerOneScore = 0;
  int _playerTwoScore = 0;
  bool _playerOneTurn = true;
  bool _playerTwoTurn = false;

  int getPlayerOneScore() {
    return _playerOneScore;
  }

  int getPlayerTwoScore() {
    return _playerTwoScore;
  }

  bool isPlayerOneTurn() {
    return _playerOneTurn;
  }

  bool isPlayerTwoTurn() {
    return _playerTwoTurn;
  }

  void nowPlayerOneTurn() {
    _playerOneTurn = true;
    _playerTwoTurn = false;
  }

  void nowPlayerTwoTurn() {
    _playerTwoTurn = true;
    _playerOneTurn = false;
  }

  void addPlayerOneScore(int gameScore) {
    _playerOneScore += gameScore;
  }

  void addPlayerTwoScore(int gameScore) {
    _playerTwoScore += gameScore;
  }

  void subtractPlayerOneScore(int gameScore) {
    _playerOneScore -= gameScore;
  }

  void subtractPlayerTwoScore(int gameScore) {
    _playerTwoScore -= gameScore;
  }

  void restart() {
    _playerOneScore = 0;
    _playerTwoScore = 0;
    _playerOneTurn = true;
    _playerTwoTurn = false;
  }
}
