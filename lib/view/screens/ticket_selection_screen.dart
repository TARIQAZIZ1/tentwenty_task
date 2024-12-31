import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tentwenty_task/core/utils/size_utils.dart';
import 'package:tentwenty_task/view/screens/seat_booking_module/curved_screen.dart';
import 'package:tentwenty_task/view/screens/seat_booking_module/seat_color.dart';
import 'package:tentwenty_task/view/screens/seat_booking_module/seat_widget.dart';
import '../../core/utils/app_colors.dart';
import '../../data/models/seats_model.dart';
import '../widgets/shared_widgets/text_widget.dart';

class TicketSelectScreen extends StatefulWidget {
  const TicketSelectScreen({super.key, required this.movieName, required this.releaseDate});
  final String movieName;
  final String releaseDate;
  @override
  TicketSelectScreenState createState() => TicketSelectScreenState();
}

class TicketSelectScreenState extends State<TicketSelectScreen> {
  final ScrollController _screenScrollController = ScrollController();
  final double _screenWidth = 400.w;

  List<SeatModel> seats = [];

  @override
  void initState() {
    super.initState();
    makeTableOfSeats(10, 10);
  }

  // Initialize the seats list
  void makeTableOfSeats(int rows, int columns) {
    List<SeatModel> seatList = [];
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        seatList.add(SeatModel(row: i + 1, number: j + 1, isSelected: false));
      }
    }
    //setState(() {
      seats = seatList;
    //});
  }

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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Stack(
              children: [
                CurvedLine(
                  screenScrollController: _screenScrollController,
                  screenWidth: _screenWidth,
                ),
                Positioned(
                    bottom: 20.h,
                    left: 0,
                    right: 0,
                    child: const Center(child: CustomText('Screen'))),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Column(
                  children: List.generate(10, (index) {
                    return Text(
                      '${index + 1}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    );
                  }),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: seats.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 20,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (ctx, index) {
                      final seat = seats[index];
                      return SeatWidget(
                        seat: seat,
                        onSeatSelected: (seat) {
                          setState(() {
                            seat.isSelected = !seat.isSelected;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            const SeatColorIndicators(),
            const SizedBox(height: 20),
            PurchaseSeatsButton(seats: seats),
          ],
        ),
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

class PurchaseSeatsButton extends StatelessWidget {
  final List<SeatModel> seats;

  const PurchaseSeatsButton({super.key, required this.seats});

  @override
  Widget build(BuildContext context) {
    final selectedSeats = seats.where((seat) => seat.isSelected).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: selectedSeats.isNotEmpty ? () {} : null,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 1,
                  backgroundColor: CupertinoColors.systemGrey5),
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  'Total price \n\$ ${selectedSeats.length * 50}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w,),
          Expanded(
          flex: 3,
            child: ElevatedButton(
              onPressed: selectedSeats.isNotEmpty ? () {} : null,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 1,
                  backgroundColor: AppColors.inputBorderColor),
              child: const Center(
                child: Text(
                  'Proceed to pay',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
