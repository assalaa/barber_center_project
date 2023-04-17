import 'package:barber_center/screens/all_salons/all_salons_provider.dart';
import 'package:barber_center/widgets/cards/featured_barbers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllSalons extends StatelessWidget {
  const AllSalons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AllSalonProvider>(
        create: (context) => AllSalonProvider(),
        child: Consumer<AllSalonProvider>(builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text("All Salons"),
              actions: [],
            ),
            body: GridView.builder(
              itemCount: provider.users.length,
              itemBuilder: (context, index) => ListTile(
                  onTap: () {},
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FeaturedBarber(
                      barberName: provider.users[index].name,
                      barberImage: provider.users[index].image,
                      barberLocation: provider.users[index].city,
                    ),
                  )),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
            ),
          );
        }));
  }
}
