import 'package:barber_center/screens/admin/add_service/create_service_provider.dart';
import 'package:barber_center/widgets/large_rounded_button.dart';
import 'package:barber_center/widgets/upload_and_show_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateServicePage extends StatelessWidget {
  const CreateServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateServiceProvider>(
      create: (context) => CreateServiceProvider(),
      child: Consumer<CreateServiceProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add Service'),
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
                          provider.saveService();
                        },
                        decoration: const InputDecoration(
                          hintText: 'Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      LargeRoundedButton(
                        loading: provider.loading,
                        buttonName: 'Save',
                        onTap: () async {
                          await provider.saveService();
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
