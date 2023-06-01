import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_barber.dart';
import 'package:barber_center/database/db_invitation.dart';
import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/database/db_salon.dart';
import 'package:barber_center/main.dart';
import 'package:barber_center/models/barber_model.dart';
import 'package:barber_center/models/invitation_model.dart';
import 'package:barber_center/models/salon_information_model.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/utils.dart';
import 'package:barber_center/widgets/popup.dart';
import 'package:flutter/material.dart';

class NotificationsProvider with ChangeNotifier {
  final DatabaseAuth _dbAuth = DatabaseAuth();
  final DatabaseUser _dbUser = DatabaseUser();
  final DatabaseBarber _dbBarber = DatabaseBarber();
  final DatabaseSalon _dbSalon = DatabaseSalon();
  final DatabaseInvitation _dbInvitation = DatabaseInvitation();

  List<dynamic> searchResultList = [];
  List<InvitationModel> invitations = [];

  late String userId;
  UserModel? userModel;
  bool loading = true;

  NotificationsProvider() {
    _init();
  }

  bool get isSalon => userModel?.kindOfUser == KindOfUser.SALON;

  Future<void> _init() async {
    final String userId = _dbAuth.getCurrentUser()!.uid;

    await Future.wait([
      _getUser(userId),
      _getInvitations(userId),
    ]);

    loading = false;
    notifyListeners();
  }

  Future<void> _getUser(String userId) async {
    userModel = (await _dbUser.getUserByUid(userId))!;
  }

  Future<void> _getInvitations(String userId) async {
    invitations = await _dbInvitation.getInvitations(userId);
  }

  Future<void> acceptInvitation(String userId) async {
    final String salonId = isSalon ? userModel!.uid : userId;
    final String barberId = isSalon ? userId : userModel!.uid;

    loading = true;
    notifyListeners();

    final BarberModel? barberModel = await _dbBarber.getBarber(barberId);

    final SalonInformationModel? salonModel =
        await _dbSalon.getSalonInformation(salonId);

    if (barberModel != null && salonModel != null) {
      final String username =
          isSalon ? barberModel.barberName : salonModel.salonName;

      if ((await Popup.acceptInvitation(username, isSalon))) {
        barberModel.salonId = salonId;

        await _dbBarber.updateBarber(barberModel);
        await removeInvitation(userId);

        Routes.back();
        showMessageSuccessful('Operation successful');

        notifyListeners();
      }

      loading = false;
      notifyListeners();
    }
  }

  Future<void> removeInvitation(String userId) async {
    final String invitationId =
        invitations.firstWhere((element) => element.inviterId == userId).id;

    await _dbInvitation.deleteInvitation(invitationId.trim());

    invitations.removeWhere((element) => element.inviterId == userId);
    notifyListeners();
  }
}
