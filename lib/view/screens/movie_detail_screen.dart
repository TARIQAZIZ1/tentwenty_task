import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tentwenty_task/utils/size_utils.dart';
import 'package:tentwenty_task/view/screens/seat_mapping_screen.dart';
import 'package:tentwenty_task/view/screens/trailer_player_screen.dart';
import '../../cubits/movie_details_cubit/movie_details_cubit.dart';
import '../../data/models/movie_model.dart';
import '../../utils/app_colors.dart';
import '../widgets/shared_widgets/text_widget.dart';

class MovieDetailScreen extends StatefulWidget {
  final int id;

  const MovieDetailScreen({super.key, required this.id});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late MovieDetailsCubit movieDetailsCubit;
  @override
  void initState() {
    super.initState();
    initCubit();
  }
  initCubit() async{
    movieDetailsCubit = context.read<MovieDetailsCubit>();
    await movieDetailsCubit.fetchMovieDetails(id: widget.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
  builder: (context, state) {
    if (state is MovieDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieDetailsException) {
            return Center(child: Text(state.message.toString()));
          } else if (state is MovieDetailsSuccess) {
            final movie = state.movie;
            return SingleChildScrollView(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _MoviePosterSection(movie: movie),
                  _GenresAndOverviewSection(movie: movie),
                ],
              ),
            );
          }
          else{
            return Center(child: CustomText('Something went wrong',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),);
          }
  },
),
    );
  }
}

class _MoviePosterSection extends StatelessWidget {
  final Movie movie;

  const _MoviePosterSection({required this.movie});

  String _formatReleaseDate(String releaseDate) {
    try {
      final DateFormat inputFormat = DateFormat('yyyy-MM-dd');
      final DateFormat outputFormat = DateFormat('MMMM dd, yyyy');
      final date = inputFormat.parse(releaseDate);
      return 'In theaters ${outputFormat.format(date)}';
    } catch (e) {
      return 'Release Date: $releaseDate';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 460.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://image.tmdb.org/t/p/w500${movie.posterPath}"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Text(
                  _formatReleaseDate(movie.releaseDate),
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: AppColors.onPrimaryColor,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  width: 240.w,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeatMappingScreen(
                            movieName: movie.title,
                            releaseDate: movie.releaseDate,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      backgroundColor: AppColors.inputBorderColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "Get Tickets",
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 240.w,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TrailerPlayerScreen(id: movie.id),
                        ),
                      );
                    },
                    icon: const Icon(Icons.play_arrow, size: 30),
                    label: Text("Watch Trailer",
                        style: GoogleFonts.poppins(
                            fontSize: 16, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      backgroundColor: Colors.transparent,
                      iconColor: AppColors.onPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: AppColors.inputBorderColor,
                          width: 2.w,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GenresAndOverviewSection extends StatelessWidget {
  final Movie movie;

  const _GenresAndOverviewSection({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          CustomText(
            "Genres",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10.h),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _GenreButton(label: "Action", color: AppColors.greenColor),
              _GenreButton(label: "Thriller", color: AppColors.pinkColor),
              _GenreButton(label: "Science", color: AppColors.purpleColor),
              _GenreButton(label: "Fiction", color: AppColors.yellowColor),
            ],
          ),
          SizedBox(height: 20.h),
          const Divider(
            thickness: .5,
          ),
          SizedBox(height: 15.h),
          Text(
            "Overview",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            movie.overview,
            style: GoogleFonts.poppins(
                fontSize: 12, height: 1.5, color: AppColors.secondaryColor),
          ),
        ],
      ),
    );
  }
}

class _GenreButton extends StatelessWidget {
  final String label;
  final Color color;

  const _GenreButton({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: 24.h,
          width: 60.w,
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 2),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            textAlign: TextAlign.center,
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
