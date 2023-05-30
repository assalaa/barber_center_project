import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_barber.dart';
import 'package:barber_center/database/db_booking.dart';
import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/models/barber_model.dart';
import 'package:barber_center/models/booking_model.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class HomeBarberProvider with ChangeNotifier {
  final DatabaseUser _dbUsers = DatabaseUser();
  final DatabaseAuth _dbAuth = DatabaseAuth();
  final DatabaseBarber _dbBarber = DatabaseBarber();
  final DatabaseBooking _dbBooking = DatabaseBooking();
  bool loading = true;
  late Locale myLocale;
  late User user;
  late UserModel userModel;
  late BarberModel? barberModel;
  List<BookingModel> barberBookings = [];

  bool get isProfileCompleted => barberModel != null;

  bool get userHasPhoto => barberModel?.image != null;

  final GlobalKey cardContainerKey = GlobalKey();
  late Size cardSize;

  HomeBarberProvider() {
    init();
  }

  // Size getCardSize(GlobalKey key) {
  //   final RenderBox cardBox =
  //       key.currentContext?.findRenderObject()!;
  //   cardSize = cardBox.size;
  //   return cardBox.size;
  // }

  Future<void> init() async {
    user = _dbAuth.getCurrentUser()!;
    await Future.wait([
      getUserModel(),
      getBarberModel(),
      getBarberBookings(),
    ]);
    myLocale = Localizations.localeOf(Routes.navigator.currentContext!);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) => getCardSize());
    loading = false;
    notifyListeners();
  }

  Future<void> getUserModel() async {
    userModel = (await _dbUsers.getUserByUid(user.uid))!;
  }

  Future<void> getBarberModel() async {
    barberModel = (await _dbBarber.getBarber(user.uid))!;
  }

  Future<void> getBarberBookings() async {
    barberBookings = await _dbBooking.getBookingFromBarberId(user.uid);
  }
}
