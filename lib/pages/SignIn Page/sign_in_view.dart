import 'package:deepak_kumar_task/services/auth_functions.dart';
import 'package:deepak_kumar_task/widgets/back_button.dart';
import 'package:deepak_kumar_task/widgets/common_rich_text.dart';
import 'package:deepak_kumar_task/widgets/common_theme_scaffold.dart';
import 'package:deepak_kumar_task/widgets/snack_bar_widget.dart';
import 'package:flutter/material.dart';

import 'package:deepak_kumar_task/widgets/common-text_field.dart';
import 'package:deepak_kumar_task/widgets/common_glass_effect_container.dart';
import 'package:deepak_kumar_task/widgets/common_text.dart';
import 'package:deepak_kumar_task/widgets/text_button.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;
  @override
  void dispose() {
    passwordController.clear();
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: CommonText(
                      text: 'Log in',
                      textColor: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonGlassEffectContainer(
                    height: 260,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          leading: CircleAvatar(
                            radius: 40,
                            child: args['imageUrl'].isNotEmpty
                                ? Image.network(
                                    '${args['imageUrl']}',
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/profilePlaceholder.png',
                                    fit: BoxFit.cover,
                                    height: 40,
                                    width: 40,
                                  ),
                          ),
                          title: CommonText(
                            text: '${args['name']}',
                            textColor: Colors.white,
                          ),
                          subtitle: CommonText(
                            text: '${args['email']}',
                            textColor: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
                          textEditingController: passwordController,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CommonTextButton(
                          buttonText: 'Continue',
                          onTap: () {
                            try {
                              if (passwordController.text.isEmpty) {
                                snackBarWidget(
                                    context, 'please enter password.');
                                return;
                              }
                              AuthServices.signInUser('${args['email']}',
                                  passwordController.text, context, args);
                              // Navigator.pushNamed(context, '/profile',
                              //     arguments: {
                              //       'email': '${args['email']}',
                              //       'imageUrl': '${args['imageUrl']}',
                              //       'name': '${args['name']}'
                              //     });
                            } catch (e) {
                              snackBarWidget(context, e.toString());
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CommonRichText(
                            text: '',
                            onTap: () {},
                            clickableText: 'Forgot your password?')
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
