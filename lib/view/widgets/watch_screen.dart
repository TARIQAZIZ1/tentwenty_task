import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tentwenty_task/core/utils/size_utils.dart';
import 'package:tentwenty_task/view/screens/movie_detail_screen.dart';
import 'package:tentwenty_task/view/widgets/shared_widgets/text_widget.dart';
import '../../core/cubits/movies_list_cubit/all_movie_list_cubit.dart';
import '../../core/cubits/movies_list_cubit/all_movie_list_state.dart';
import '../../core/utils/app_colors.dart';
import '../screens/movie_search_screen.dart';

class WatchScreen extends StatefulWidget {
  const WatchScreen({
    super.key,
  });

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  late AllMovieListCubit movieListCubit;
  @override
  void initState() {
    super.initState();
    initCubit();
  }
  initCubit() async{
    movieListCubit = context.read<AllMovieListCubit>();
    await movieListCubit.fetchAllMovies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          'Watch',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: AppColors.onPrimaryColor,
        elevation: 4,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search,
            size: 36,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: MovieSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<AllMovieListCubit, AllMovieListState>(
        builder: (context, state) {
          if (state is AllMovieListLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (state is AllMovieListLoaded) {
            final movies = context.read<AllMovieListCubit>().currentMovies;
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>MovieDetailScreen(id: movie.id),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      elevation: 5,
                      clipBehavior: Clip.hardEdge,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.r),
                            child: Image.network(
                              "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                              width: double.infinity,
                              height: 200.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: CustomText(
                              movie.title,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: AppColors.onPrimaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          else if (state is AllMovieListException) {
            return Center(
              child: CustomText(
                state.errorMessage,
                style: GoogleFonts.poppins(
                  color: AppColors.errorColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          else {
            return Center(
              child: Text(
                "Something went wrong.",
                style: GoogleFonts.poppins(
                  color: AppColors.errorColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
