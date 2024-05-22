import 'package:flutter/material.dart';
import 'package:mind_labify/features/authentication/views/login_screen.dart';
import 'package:mind_labify/widgets/app_primary_button.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 57,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(
                0XFFBEBB65,
              ).withOpacity(
                0.76,
              ),
              const Color(
                0XFFB9BF88,
              ).withOpacity(
                0.76,
              ),
              const Color(
                0XFFB7C094,
              ).withOpacity(
                0.76,
              ),
              const Color(
                0XFFB4C2AB,
              ).withOpacity(
                0.76,
              ),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Image(
                color: Color(
                  0xFFffffff,
                ),
                height: 38.65,
                image: AssetImage(
                  'assets/images/name.png',
                ),
              ),
              const Image(
                image: AssetImage(
                  'assets/images/get_started.png',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 35,
                  right: 35,
                  bottom: 167,
                ),
                child: AppPrimaryButton(
                  text: 'Let’s Get Started!',
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
