import 'dart:convert';

import 'package:eid_moo/features/auth/login_screen.dart';
import 'package:eid_moo/shared/components/em_bottomnavbar.dart';
import 'package:eid_moo/shared/components/em_button.dart';
import 'package:eid_moo/shared/components/em_fetch.dart';
import 'package:eid_moo/shared/utils/firebase/em_auth_instance.dart';
import 'package:eid_moo/shared/utils/theme/em_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ionicons/ionicons.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  AuthResponse? authResponse;

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();

  final signUpFormKey = GlobalKey<FormState>();

  bool isLoading = false;

  Future<void> _signUp() async {
    if (signUpFormKey.currentState!.validate()) {
      if (_passwordController.text == _confirmPasswordController.text) {
        authResponse = await EMAuthInstance.signUpWithEmail(
          email: _emailController.text,
          password: _passwordController.text,
        );

        print(authResponse?.status);

        if (authResponse?.status ?? false) {
          final response = await EMFetch(
            '/auth/user-signup',
            method: EMFetchMethod.POST,
            body: {
              'idToken': authResponse?.userCredential?.user?.getIdToken() ?? '',
              'name': _nameController.text,
            },
          ).request();

          if (response['success']) {
            const storage = FlutterSecureStorage();

            await storage.write(key: 'token', value: response['data']['token']);

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const EMBottomNavbar(),
              ),
              (route) => false,
            );
          }

          // Navigator.pushAndRemoveUntil(
          //   navigatorKey.currentContext!,
          //   MaterialPageRoute(
          //     builder: (_) => const HomeScreen(),
          //   ),
          //   (route) => false,
          // );
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(authResponse?.message ?? 'An error occurred'),
              ),
            );
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match'),
          ),
        );
      }

      signUpFormKey.currentState!.reset();
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        emailFocusNode.unfocus();
        passwordFocusNode.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Center(
              child: Form(
                key: signUpFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/eidmoo_logo.png',
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      focusNode: nameFocusNode,
                      controller: _nameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Ionicons.person,
                          color: Colors.black,
                          size: 26,
                        ),
                        labelText: 'Name',
                        hintText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      focusNode: emailFocusNode,
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Ionicons.mail,
                          color: Colors.black,
                          size: 26,
                        ),
                        labelText: 'Email',
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      focusNode: passwordFocusNode,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Ionicons.lock_closed,
                          color: Colors.black,
                          size: 26,
                        ),
                        labelText: 'Password',
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      focusNode: confirmPasswordFocusNode,
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.black,
                          size: 26,
                        ),
                        labelText: 'Confirm Password',
                        hintText: 'Confirm Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: EMButton(
                        isLoading: isLoading,
                        backgroundColor: EidMooTheme.primaryVariant,
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await _signUp();

                          print('Is loading: $isLoading');
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: EidMooTheme.primaryVariant,
                          decoration: TextDecoration.underline,
                          decorationColor: EidMooTheme.primaryVariant,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'Use Social Login',
                              style: TextStyle(
                                color: EidMooTheme.grey,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () async {
                              authResponse =
                                  await EMAuthInstance.signInWithGoogle();

                              if ((authResponse?.status ?? false) && mounted) {
                                final userItem = authResponse?.userCredential;

                                final userCandidate = userItem?.user;

                                if (userCandidate != null) {
                                  final idToken =
                                      await userCandidate.getIdToken();

                                  try {
                                    final response = await EMFetch(
                                      '/auth/user-login',
                                      method: EMFetchMethod.POST,
                                      body: {
                                        'uid': userCandidate.uid,
                                        'email': userCandidate.email,
                                        'displayName':
                                            userCandidate.displayName ?? '',
                                        'idToken': idToken,
                                      },
                                    ).request();

                                    if (response['success']) {
                                      const storage = FlutterSecureStorage();

                                      print(jsonEncode(response));

                                      storage.write(
                                          key: 'token',
                                          value: response['data']['token'] ?? '');

                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const EMBottomNavbar(),
                                        ),
                                        (route) => false,
                                      );
                                    } else {
                                      if (mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(response['message'] ??
                                                'An error occurred'),
                                          ),
                                        );
                                      }
                                    }
                                  } catch (e) {
                                    if (mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            e.toString(),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                }

                              }
                            },
                            icon: const Icon(
                              Ionicons.logo_google,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
