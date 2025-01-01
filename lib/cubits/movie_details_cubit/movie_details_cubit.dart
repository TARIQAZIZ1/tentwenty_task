import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tentwenty_task/data/models/movie_model.dart';

import '../../../data/repo/movie_repository.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MoviesRepository repository;
  MovieDetailsCubit(this.repository) : super(MovieDetailsInitial());
  Future<void> fetchMovieDetails({required int id}) async {
    emit(MovieDetailsLoading());
    try {
      final movie = await repository.fetchMovieDetails(id);
      emit(MovieDetailsSuccess(movie: movie));
    } catch (e) {
      emit(const MovieDetailsException(message: "Failed to load movie details. Please try again."));
    }
  }
}
