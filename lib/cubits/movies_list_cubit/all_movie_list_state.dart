import '../../../data/models/movie_model.dart';

abstract class AllMovieListState {}

class AllMovieListInitial extends AllMovieListState {}

class AllMovieListLoading extends AllMovieListState {}

class AllMovieListLoaded extends AllMovieListState {
  final List<Movie> movies;

  AllMovieListLoaded(this.movies);
}

class AllMovieListException extends AllMovieListState {
  final String errorMessage;

  AllMovieListException(this.errorMessage);
}

