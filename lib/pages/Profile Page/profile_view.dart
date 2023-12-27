// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:deepak_kumar_task/services/firbase_functions.dart';
import 'package:deepak_kumar_task/widgets/back_button.dart';
import 'package:deepak_kumar_task/widgets/common-text_field.dart';
import 'package:deepak_kumar_task/widgets/common_glass_effect_container.dart';
import 'package:deepak_kumar_task/widgets/common_text.dart';
import 'package:deepak_kumar_task/widgets/common_theme_scaffold.dart';
import 'package:deepak_kumar_task/widgets/snack_bar_widget.dart';
import 'package:deepak_kumar_task/widgets/text_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  File? file;
  String imageUrl = '';
  pickImage() async {
    try {
      final imageFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imageFile != null) {
        setState(() {
          file = File(imageFile.path);
        });
      }
      print(file!.path);
    } catch (e) {
      print(e.toString());
    }
  }

  getUser() {
    final currentUser = FirebaseAuth.instance.currentUser;
    nameController =
        TextEditingController(text: currentUser?.displayName ?? '');
    emailController = TextEditingController(text: currentUser?.email ?? '');
    setState(() {});
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  void dispose() {
    emailController.clear();
    nameController.clear();
    file = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return CommonThemeScafold(
      body: Stack(
        children: [
          const Positioned(
            top: 20,
            child: Row(children: [CommonBackButton()]),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: CommonText(
                      text: 'Profile',
                      textColor: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonGlassEffectContainer(
                    height: 380,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              child: file != null
                                  ? Image.file(
                                      file!,
                                      fit: BoxFit.cover,
                                    )
                                  : '${args['imageUrl']}'.isNotEmpty
                                      ? Image.network(
                                          fit: BoxFit.cover,
                                          '${args['imageUrl']}',
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const SizedBox();
                                          },
                                        )
                                      : Image.asset(
                                          height: 80,
                                          fit: BoxFit.cover,
                                          'assets/images/profilePlaceholder.png'),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: pickImage,
                                  child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Icon(Icons.edit,
                                          color: Colors.green.shade400)),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CommonTextField(
                          hintText: 'Name',
                          label: 'Name',
                          textEditingController: nameController,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CommonTextField(
                          hintText: 'Email',
                          label: 'Email',
                          textEditingController: emailController,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CommonTextButton(
                          buttonText: 'Update',
                          onTap: () async {
                            try {
                              if (nameController.text.isEmpty ||
                                  emailController.text.isEmpty) {
                                snackBarWidget(
                                    context, 'Please fill all fields');
                                return;
                              }
                              final uid =
                                  FirebaseAuth.instance.currentUser?.uid;
                              if (file != null) {
                                String fileName = file!.path.split('/').last;
                                var snapshot = await FirebaseStorage.instance
                                    .ref()
                                    .child(
                                        'imageUrls/${emailController.text}_$fileName')
                                    .putFile(file!);
                                var downloadUrl =
                                    await snapshot.ref.getDownloadURL();
                                setState(() {
                                  imageUrl = downloadUrl;
                                });
                              }
                              FirestoreServices.saveUser(
                                  imageUrl,
                                  nameController.text,
                                  emailController.text,
                                  uid,
                                  context);

                              Navigator.pushNamed(context, '/');
                            } catch (e) {
                              snackBarWidget(context, e.toString());
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
