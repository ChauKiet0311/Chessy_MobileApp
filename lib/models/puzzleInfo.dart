class PuzzleInfo {
  String id;
  String FEN;
  String Moves;
  int Popularity;
  String PuzzleId;
  int rating;

  PuzzleInfo(
      {this.id = "",
      this.FEN = "",
      this.Moves = "",
      this.Popularity = 0,
      this.PuzzleId = "",
      this.rating = 0});
}
