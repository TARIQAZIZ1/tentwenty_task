import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/movie_repository.dart';
import 'trailer_state.dart';

class TrailerCubit extends Cubit<TrailerState> {
  final MoviesRepository repository;

  TrailerCubit(this.repository) : super(TrailerInitial());

  Future<void> fetchTrailer(int movieId) async {
    emit(TrailerLoading());
    try {
      final trailerKey = await repository.fetchTrailerUrl(movieId);
      if (trailerKey != null) {
        emit(TrailerLoaded(trailerKey));
      } else {
        emit(TrailerError("Trailer not available."));
      }
    } catch (e) {
      debugPrint("Error fetching trailer: $e");
      emit(TrailerError("Failed to load trailer. Please try again."));
    }
  }
}
