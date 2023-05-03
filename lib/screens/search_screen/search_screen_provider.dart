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

class SearchScreenProvider with ChangeNotifier {
  final DatabaseAuth _dbAuth = DatabaseAuth();
  final DatabaseUser _dbUser = DatabaseUser();
  final DatabaseBarber _dbBarber = DatabaseBarber();
  final DatabaseSalon _dbSalon = DatabaseSalon();
  final DatabaseInvitation _dbInvitation = DatabaseInvitation();

  List<dynamic> searchResultList = [];
  List<InvitationModel> involvedInvitations = [];

  UserModel? userModel;
  bool loading = true;

  final TextEditingController tcSearch = TextEditingController();

  SearchScreenProvider() {
    _init();
  }

  Future<void> _init() async {
    final String userId = _dbAuth.getCurrentUser()!.uid;

    await Future.wait([
      _getUser(userId),
      _getInvolvedInvitations(userId),
    ]);

    loading = false;
    notifyListeners();
  }

  Future<void> _getUser(String userId) async {
    userModel = (await _dbUser.getUserByUid(userId))!;
  }

  bool get isSalon => userModel?.kindOfUser == KindOfUser.SALON;

  Future<void> _getInvolvedInvitations(String userId) async {
    involvedInvitations = await _dbInvitation.getInvolvedInvitations(userId);
  }

  Future<void> search() async {
    if (tcSearch.text.isNotEmpty) {
      if (isSalon) {
        await _searchBarbers();
      } else {
        await _searchSalons();
      }

      notifyListeners();
      debugPrint(searchResultList.length.toString());
    }
  }

  Future<void> _searchBarbers() async {
    searchResultList = await _dbBarber.searchUnemployedBarbers(tcSearch.text);
  }

  Future<void> _searchSalons() async {
    searchResultList = await _dbSalon.searchSalons(tcSearch.text);
  }

  Future<void> inviteUser(String userId) async {
    final DateTime now = DateTime.now();
    final InvitationModel invitationModel = InvitationModel(
      id: dateToId(now),
      createAt: now,
      inviter: userModel!.uid,
      invited: userId,
    );

    involvedInvitations.add(invitationModel);
    notifyListeners();

    await _dbInvitation.createInvitation(invitationModel);
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
    final String invitationId = involvedInvitations
        .firstWhere((element) => element.inviter == userId)
        .id;

    await _dbInvitation.deleteInvitation(invitationId.trim());

    involvedInvitations.removeWhere((element) => element.inviter == userId);
    notifyListeners();
  }

  String get getTitle => userModel == null
      ? 'Search'
      : 'Search for ${isSalon ? 'Barbers' : userModel!.kindOfUser == KindOfUser.BARBER ? 'Salons' : 'Barbers & Salons'}';
}
