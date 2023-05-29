import 'package:barber_center/models/invitation_model.dart';
import 'package:barber_center/screens/notifications_screen/notifications_provider.dart';
import 'package:barber_center/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotificationsProvider>(
      create: (context) => NotificationsProvider(),
      child: Consumer<NotificationsProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Notifications'),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (provider.loading) ...[
                      const RefreshProgressIndicator()
                    ] else ...[
                      InvitationList(provider: provider),
                    ]
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class InvitationList extends StatelessWidget {
  const InvitationList({
    required this.provider,
    super.key,
  });
  final NotificationsProvider provider;

  @override
  Widget build(BuildContext context) {
    final int itemCount = provider.invitations.length;

    if (itemCount < 1) {
      return const Text('Nothing yet');
    }
    return Expanded(
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final InvitationModel invitationModel = provider.invitations[index];

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 1,
                  color: Colors.grey,
                  offset: Offset(1, 1),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: invitationModel.inviter,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: provider.isSalon
                            ? ' added your salon as their workplace.'
                            : ' added your account as an employee.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SmallButton(
                      onPressed: () =>
                          provider.acceptInvitation(invitationModel.inviterId),
                      text: 'Accept',
                    ),
                    SmallButton(
                      onPressed: () =>
                          provider.removeInvitation(invitationModel.id),
                      text: 'Reject',
                      buttonColor: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
