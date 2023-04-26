class BookingTimeModel {
  final String time;
  bool available = true;
  bool durationFits;

  BookingTimeModel({
    required this.time,
    required this.available,
    this.durationFits = true,
  });
}
