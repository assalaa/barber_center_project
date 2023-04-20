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
              title: const Text('All Salons'),
              actions: const [],
            ),
            body: GridView.builder(
              itemCount: 1,
              itemBuilder: (context, index) => ListTile(
                  onTap: () {},
                  title: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FeaturedBarber(
                      barberName: '',
                      barberImage: '',
                      barberLocation: '',
                    ),
                  )),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
            ),
          );
        }));
  }
}
