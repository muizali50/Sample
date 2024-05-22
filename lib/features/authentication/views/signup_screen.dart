import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/authentication/bloc/authentication_bloc.dart';
import 'package:mind_labify/features/user/views/age_screen.dart';
import 'package:mind_labify/features/authentication/views/login_screen.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:mind_labify/widgets/app_primary_button.dart';
import 'package:mind_labify/widgets/app_text_fields.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authenticationBloc = context.watch<AuthenticationBloc>();
    return Scaffold(
      backgroundColor: const Color(
        0xFFFFFFFF,
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          icon: const ImageIcon(
            AssetImage(
              'assets/icons/back.png',
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.hGap10,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 29,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Join MindLabify Today',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Begin your journey to a happy brain',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 27,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 43,
                ),
                child: Column(
                  children: [
                    AppTextField(
                      controller: _nameController,
                      hintText: 'Enter your name',
                    ),
                    Gaps.hGap25,
                    AppTextField(
                      controller: _emailController,
                      hintText: 'Enter your email',
                    ),
                    Gaps.hGap25,
                    AppTextField(
                      controller: _phoneNumberController,
                      hintText: 'Enter your phone number',
                    ),
                    Gaps.hGap25,
                    AppTextField(
                      controller: _passwordController,
                      isPassword: true,
                      hintText: 'Enter Password',
                    ),
                    Gaps.hGap25,
                    AppTextField(
                      controller: _confirmPasswordController,
                      isPassword: true,
                      hintText: 'Confirm Password',
                    ),
                  ],
                ),
              ),
              Gaps.hGap45,
              BlocConsumer<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is Registered) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AgeScreen(),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is Registering) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is RegisteredFailure) {
                    SchedulerBinding.instance.addPostFrameCallback(
                      (timeStamp) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              state.message,
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: 43,
                      left: 25,
                    ),
                    child: AppPrimaryButton(
                      text: 'Sign up',
                      onTap: () {
                        if (_nameController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please enter your name',
                              ),
                            ),
                          );
                          return;
                        }
                        if (_emailController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please enter your email',
                              ),
                            ),
                          );
                          return;
                        }
                        if (_phoneNumberController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please enter your phone number',
                              ),
                            ),
                          );
                          return;
                        }
                        if (_passwordController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please enter your password',
                              ),
                            ),
                          );
                          return;
                        }
                        if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Passwords do not match',
                              ),
                            ),
                          );
                          return;
                        }
                        authenticationBloc.add(
                          RegisterEvent(
                            name: _nameController.text,
                            email: _emailController.text,
                            phoneNumber: _phoneNumberController.text,
                            password: _passwordController.text,
                            confirmPassword: _confirmPasswordController.text,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              Gaps.hGap15,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(
                        0xFF000000,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor:
                            Theme.of(context).colorScheme.secondary,
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
