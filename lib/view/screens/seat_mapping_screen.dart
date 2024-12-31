import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tentwenty_task/core/utils/size_utils.dart';
import 'package:tentwenty_task/view/screens/ticket_selection_screen.dart';

import '../../core/utils/app_colors.dart';

class SeatMappingScreen extends StatefulWidget {
  final String movieName;
  final String releaseDate;

  const SeatMappingScreen(
      {super.key, required this.movieName, required this.releaseDate});

  @override
  SeatMappingScreenState createState() => SeatMappingScreenState();
}

class SeatMappingScreenState extends State<SeatMappingScreen> {
  String? _selectedDate;

  @override
  Widget build(BuildContext context) {
    String formattedReleaseDate = _formatReleaseDate(widget.releaseDate);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: 36.w),
            child: Column(
              children: [
                Text(
                  widget.movieName,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'In Theaters $formattedReleaseDate',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColors.inputBorderColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                SizedBox(height: 90.h,),
                Text(
                  "Date",
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(7, (index) {
                      DateTime date =
                          DateTime.now().add(Duration(days: index));
                      String formattedDate = DateFormat('d MMM').format(date);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDate = formattedDate;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            color: _selectedDate == formattedDate
                                ? AppColors.inputBorderColor
                                : CupertinoColors.systemGrey5,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            formattedDate,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: _selectedDate == formattedDate
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 62.h),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(7, (index) {
                      return Container(
                        margin: EdgeInsets.only(
                          right: 10.w,
                        ),
                        height: 145.h,
                        width: 249.w,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: AppColors.inputBorderColor,),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 36,
            ),
            child: ElevatedButton(
              onPressed: () {
                if (_selectedDate != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  TicketSelectScreen(
                        releaseDate: widget.releaseDate,
                        movieName: widget.movieName,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select a date."),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                  padding:
                  EdgeInsets.symmetric(horizontal: 100.w, vertical: 15.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 1,
                  backgroundColor: AppColors.inputBorderColor),
              child: Text("Select Seats",
                  style: GoogleFonts.poppins(
                      fontSize: 18, color: AppColors.onPrimaryColor)),
            ),
          ),
        ],
      ),
    );
  }

  String _formatReleaseDate(String releaseDate) {
    try {
      final DateFormat inputFormat = DateFormat('yyyy-MM-dd');
      final DateFormat outputFormat = DateFormat('MMMM dd, yyyy');
      final date = inputFormat.parse(releaseDate);
      return outputFormat.format(date);
    } catch (e) {
      return 'Release Date: $releaseDate';
    }
  }
}
