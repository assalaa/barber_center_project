import 'package:barber_center/screens/admin/add_service/add_service_provider.dart';
import 'package:barber_center/widgets/image_file_selected.dart';
import 'package:barber_center/widgets/large_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddServicePage extends StatelessWidget {
  const AddServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddServiceProvider>(
      create: (context) => AddServiceProvider(),
      child: Consumer<AddServiceProvider>(
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
                      image(
                        provider.xFile,
                        () => provider.selectImage(context),
                      ),

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

  Widget image(XFile? xFile, Function selectImage) {
    const double size = 145;
    if (xFile == null) {
      return SizedBox(
          height: size,
          width: size,
          child: Container(
            alignment: Alignment.bottomRight,
            height: 130,
            width: 130,
            child: Material(
              borderRadius: const BorderRadius.all(Radius.circular(size)),
              color: Colors.black38,
              child: InkWell(
                onTap: () => selectImage(),
                borderRadius: const BorderRadius.all(Radius.circular(size)),
                child: const SizedBox(
                  height: 130,
                  width: 130,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ),
            ),
          ));
    } else {
      return SizedBox(
        height: size,
        width: size,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(size)),
                child: ImageFile(
                  imageSize: 130,
                  path: xFile.path,
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: 48,
                width: 48,
                child: Material(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  color: const Color(0xff1d1b1b),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => selectImage(),
                    icon: const Icon(
                      Icons.photo_filter_sharp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
