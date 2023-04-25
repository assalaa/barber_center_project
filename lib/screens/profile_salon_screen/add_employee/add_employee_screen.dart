import 'package:barber_center/models/service_model.dart';
import 'package:barber_center/screens/profile_salon_screen/add_employee/add_employee_provider.dart';
import 'package:barber_center/widgets/large_rounded_button.dart';
import 'package:barber_center/widgets/service_element.dart';
import 'package:barber_center/widgets/upload_and_show_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEmployeePage extends StatelessWidget {
  const AddEmployeePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddEmployeeProvider>(
      create: (context) => AddEmployeeProvider(),
      child: Consumer<AddEmployeeProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add Employee'),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: provider.formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      //IMAGE
                      UploadAndShowImage(
                          xFile: provider.xFile,
                          selectImage: () => provider.selectImage(context)),

                      const SizedBox(height: 20),

                      //TEXT FIELD NAME
                      TextFormField(
                        controller: provider.name,
                        textInputAction: TextInputAction.done,
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                          // provider.saveService();
                        },
                        decoration: const InputDecoration(
                          hintText: 'Employee Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: provider.services.length,
                          itemBuilder: (context, index) {
                            final ServiceModel serviceModel =
                                provider.services[index];
                            return ServiceElement(
                              name: serviceModel.name,
                              image: serviceModel.image,
                              isSelected: provider.selectedServices
                                  .contains(serviceModel),
                              onTap: () => provider.selectService(serviceModel),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),

                      LargeRoundedButton(
                        loading: provider.loading,
                        buttonName: 'Save',
                        onTap: () async {
                          await provider.saveEmployee();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
