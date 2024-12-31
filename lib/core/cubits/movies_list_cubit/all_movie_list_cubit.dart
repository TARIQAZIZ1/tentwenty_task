import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/movie_model.dart';
import '../../../data/repo/movie_repository.dart';
import 'all_movie_list_state.dart';

class AllMovieListCubit extends Cubit<AllMovieListState> {
  final MoviesRepository repository;
  List<Movie> allMovies = [];
  List<Movie>? filteredList;

  AllMovieListCubit(this.repository) : super(AllMovieListInitial());

  Future<void> fetchAllMovies() async {
    emit(AllMovieListLoading());
    try {
      final movies = await repository.fetchComingMovies();
      allMovies = movies;
      filteredList = null;
      emit(AllMovieListLoaded(allMovies));
    } catch (e) {
      emit(AllMovieListException("Failed to load movies. Please try again."));
    }
  }

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      filteredList = null;
      emit(AllMovieListLoaded(allMovies));
    } else {
      final filteredData = allMovies.where((movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
      filteredList = filteredData;
      emit(AllMovieListLoaded(filteredData));
    }
  }

  List<Movie> get currentMovies => filteredList ?? allMovies;
}
