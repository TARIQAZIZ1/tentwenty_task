part of 'movie_details_cubit.dart';

sealed class MovieDetailsState extends Equatable {
  const MovieDetailsState();
}

final class MovieDetailsInitial extends MovieDetailsState {
  @override
  List<Object> get props => [];
}
final class MovieDetailsLoading extends MovieDetailsState {
  @override
  List<Object> get props => [];
}
final class MovieDetailsSuccess extends MovieDetailsState {
  final Movie movie;

  const MovieDetailsSuccess({required this.movie});
  @override
  List<Object> get props => [];
}
final class MovieDetailsException extends MovieDetailsState {
  final String message;

  const MovieDetailsException({required this.message});
  @override
  List<Object> get props => [];
}