import 'package:barber_center/models/barber_model.dart';
import 'package:barber_center/models/salon_information_model.dart';
import 'package:barber_center/screens/search_screen/search_screen_provider.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchScreenProvider>(
      create: (context) => SearchScreenProvider(),
      child: Consumer<SearchScreenProvider>(builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: Styles.backgroundColor,
          appBar: AppBar(
            elevation: 2,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            title: Text(provider.getTitle),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    SearchBox(
                      controller: provider.tcSearch,
                      onChanged: (value) => provider.search(),
                    ),
                    const SizedBox(height: 12),
                    ResultList(provider: provider),
                  ],
                ),
              ),
              if (provider.loading) ...[
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.3)),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ]
            ],
          ),
        );
      }),
    );
  }
}

class ResultList extends StatelessWidget {
  const ResultList({
    required this.provider,
    super.key,
  });

  final SearchScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: List.generate(provider.searchResultList.length, (index) {
          final BarberModel? barberModel;
          final SalonInformationModel? salonModel;

          final String userId;
          final String name;
          final String phone;
          final String? image;
          String? bannerText;
          String? inviteButtonText;

          if (provider.isSalon) {
            barberModel = provider.searchResultList[index];
            userId = barberModel!.barberId;
            name = barberModel.barberName;
            phone = barberModel.phone;
            image = barberModel.image;
          } else {
            salonModel = provider.searchResultList[index];
            userId = salonModel!.salonId;
            name = salonModel.salonName;
            phone = salonModel.phone;
            image = null;
          }

          final bool invited = provider.involvedInvitations
              .any((element) => element.invited == userId);

          final bool inviter = provider.involvedInvitations
              .any((element) => element.inviter == userId);

          if (provider.isSalon) {
            inviteButtonText = 'Add as Employee';
            bannerText = '$name added your salon as work';
          } else {
            bannerText = '$name added you as an employee';
            inviteButtonText = 'Add as Employer';
          }

          return UserCard(
            inviter: inviter,
            invited: invited,
            name: name,
            phone: phone,
            image: image,
            bannerText: bannerText,
            inviteButtonText: inviteButtonText,
            onPressedInvite: () => provider.inviteUser(userId),
            onPressedAccept: () => provider.acceptInvitation(userId),
            onPressedReject: () => provider.removeInvitation(userId),
            onPressedProfile: () {},
          );
        }),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({
    required this.name,
    required this.onPressedProfile,
    required this.invited,
    required this.inviter,
    this.onPressedInvite,
    this.onPressedAccept,
    this.onPressedReject,
    this.bannerText,
    this.inviteButtonText,
    this.phone,
    this.image,
    super.key,
  });

  final String name;
  final String? phone;
  final String? image;
  final String? bannerText;
  final String? inviteButtonText;
  final bool invited;
  final bool inviter;
  final Function() onPressedProfile;
  final Function()? onPressedInvite;
  final Function()? onPressedAccept;
  final Function()? onPressedReject;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Styles.primaryColor,
      elevation: 10,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Visibility(
            visible: inviter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber.shade900,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    bannerText ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: onPressedAccept,
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.green),
                        ),
                        child: Row(
                          children: const [
                            Text(
                              'Accept',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: onPressedReject,
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.red),
                        ),
                        child: Row(
                          children: const [
                            Text(
                              'Reject',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 14).copyWith(top: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (image != null) ...[
                  CircleAvatar(
                    radius: 38,
                    backgroundImage: NetworkImage(image!),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        phone != null ? 'Tel: $phone' : '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: onPressedProfile,
                            child: const Text('See Profile'),
                          ),
                          if (invited) ...[
                            const Text(
                              'Invitation Sent',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ] else if (!invited && !inviter) ...[
                            TextButton(
                              onPressed: onPressedInvite,
                              child: Text(inviteButtonText!),
                            ),
                          ]
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({
    required this.controller,
    required this.onChanged,
    super.key,
  });

  final TextEditingController controller;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.search),
      ),
      onChanged: onChanged,
    );
  }
}
