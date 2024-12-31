class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String releaseDate;
  final String overview; // New field for the overview

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    required this.overview, // Initialize the overview
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      overview: json['overview'] ??
          'No overview available', // Handle missing overview
    );
  }
}
