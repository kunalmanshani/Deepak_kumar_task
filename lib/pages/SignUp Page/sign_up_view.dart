import 'package:deepak_kumar_task/services/auth_functions.dart';
import 'package:deepak_kumar_task/widgets/back_button.dart';
import 'package:deepak_kumar_task/widgets/common_rich_text.dart';
import 'package:deepak_kumar_task/widgets/common_theme_scaffold.dart';
import 'package:flutter/material.dart';

import 'package:deepak_kumar_task/widgets/common-text_field.dart';
import 'package:deepak_kumar_task/widgets/common_glass_effect_container.dart';
import 'package:deepak_kumar_task/widgets/common_text.dart';
import 'package:deepak_kumar_task/widgets/text_button.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool showPassword = false;
  @override
  void dispose() {
    passController.clear();
    nameController.clear();
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
                      text: 'Sign up',
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
                    height: 350,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonRichText(
                            letterSpacing: 0.75,
                            text:
                                'Looks like you don\'t have an account.\nLet\'s create a new account for\n',
                            fontWeight2: FontWeight.w600,
                            clickableText: '${args['email'] ?? ''}'),
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
                          suffixIcon: showPassword
                              ? const CommonText(
                                  text: 'View',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
                                )
                              : const CommonText(
                                  text: 'Hide',
                                  fontSize: 14,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w500,
                                ),
                          isPasswordButtonVisible: true,
                          obscureText: showPassword,
                          onShowHideTap: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          hintText: 'Password',
                          label: 'Password',
                          textEditingController: passController,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CommonRichText(
                            onTap: () {},
                            text:
                                'By selecting Agree and continnue below,\nI agree to ',
                            fontWeight2: FontWeight.w600,
                            clickableText:
                                'Terms of Service and Privacy Policy'),
                        const SizedBox(
                          height: 15,
                        ),
                        CommonTextButton(
                          buttonText: 'Agree and Continue',
                          onTap: () {
                            try {
                              AuthServices.signUpUser(
                                  '${args['email']}',
                                  passController.text,
                                  nameController.text,
                                  context);
                            } catch (e) {}
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
