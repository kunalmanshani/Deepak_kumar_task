// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deepak_kumar_task/widgets/common-text_field.dart';
import 'package:deepak_kumar_task/widgets/common_glass_effect_container.dart';
import 'package:deepak_kumar_task/widgets/common_rich_text.dart';
import 'package:deepak_kumar_task/widgets/common_text.dart';
import 'package:deepak_kumar_task/widgets/common_theme_scaffold.dart';
import 'package:deepak_kumar_task/widgets/snack_bar_widget.dart';
import 'package:deepak_kumar_task/widgets/text_button.dart';
import 'package:deepak_kumar_task/widgets/text_button_with_icon.dart';
import 'package:flutter/material.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  TextEditingController emailController = TextEditingController();

  bool validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    emailController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonThemeScafold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: CommonText(
                  text: 'Hi!',
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
                height: 450,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextField(
                      hintText: 'Email',
                      label: 'Email',
                      textEditingController: emailController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CommonTextButton(
                      buttonText: 'Continue',
                      onTap: () async {
                        try {
                          if (emailController.text.isEmpty ||
                              validateEmail(emailController.text)) {
                            snackBarWidget(
                                context, 'Please enter a valid email.');
                          } else {
                            QuerySnapshot<Map<String, dynamic>> querySnapshot =
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .where('email',
                                        isEqualTo: emailController.text)
                                    .get();
                            if (querySnapshot.docs.isNotEmpty) {
                              DocumentSnapshot userSnapshot =
                                  querySnapshot.docs.first;
                              Map<String, dynamic> userData =
                                  userSnapshot.data() as Map<String, dynamic>;
                              print('here');
                              print(userData);
                              Navigator.pushNamed(context, '/signIn',
                                  arguments: userData);
                            } else {
                              Navigator.pushNamed(context, '/signUp',
                                  arguments: {'email': emailController.text});
                            }
                            // setState(() {});
                          }
                        } catch (e) {
                          snackBarWidget(context, e.toString());
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                      child: CommonText(
                        textColor: Colors.white,
                        text: 'or',
                        fontSize: 16,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButtonWithIcon(
                      iconUrl: 'assets/icons/facebookIcon.png',
                      onTap: () {},
                      title: 'Continue with Facebook',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButtonWithIcon(
                      iconUrl: 'assets/icons/googleIcon.png',
                      onTap: () {},
                      title: 'Continue with Google',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButtonWithIcon(
                      iconUrl: 'assets/icons/appleIcon.png',
                      onTap: () {},
                      title: 'Continue with Apple',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonRichText(
                      text: 'Don\'t have an account? ',
                      clickableText: 'Sign up',
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CommonRichText(
                        text: '',
                        onTap: () {},
                        clickableText: 'Forgot your password?'),
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
    );
  }
}
