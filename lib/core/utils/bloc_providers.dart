import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwenty_task/core/cubits/movie_details_cubit/movie_details_cubit.dart';
import '../../data/repo/movie_repository.dart';
import '../cubits/bottom_nav/bottom_nav_cubit.dart';
import '../cubits/movies_list_cubit/all_movie_list_cubit.dart';

class BlocProviders {
  static final List<BlocProvider> providers = [
    BlocProvider<AllMovieListCubit>(create: (context) => AllMovieListCubit(MoviesRepository()),),
    BlocProvider<MovieDetailsCubit>(create: (context) => MovieDetailsCubit(MoviesRepository()),),
    BlocProvider<BottomNavBarCubit>(create: (context) => BottomNavBarCubit(),),
  ];
}