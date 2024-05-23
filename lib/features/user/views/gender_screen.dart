import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/user/user_bloc/user_bloc.dart';
import 'package:mind_labify/features/user/views/sub_features/select_mood/views/select_mood.dart';
import 'package:mind_labify/widgets/app_primary_button.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String selectedGender = '';
  void updateGender(
    String gender,
  ) {
    setState(
      () {
        selectedGender = gender;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = context.watch<UserBloc>();
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
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'What’s Your Gender?',
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
                  'Tell us about your gender',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(
                  height: 56,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(
                    75,
                  ),
                  onTap: () {
                    updateGender(
                      'male',
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: selectedGender == 'male'
                        ? const Color(
                            0xFFB9BF88,
                          )
                        : const Color(
                            0xFFB7C094,
                          ),
                    radius: 70,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.male,
                          size: 38,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Male',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(
                              0xFFFFFFFF,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(
                    75,
                  ),
                  onTap: () {
                    updateGender(
                      'female',
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: selectedGender == 'female'
                        ? const Color(
                            0xFFB9BF88,
                          )
                        : const Color(
                            0xFFB7C094,
                          ),
                    radius: 70,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.female,
                          size: 38,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Female',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(
                              0xFFFFFFFF,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 139,
                ),
                BlocConsumer<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state is GenderSuccess) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SelectMoodScreen(),
                        ),
                      );
                    } else if (state is GenderFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is GenderLoading) {
                      return const CircularProgressIndicator();
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 34.0,
                      ),
                      child: AppPrimaryButton(
                        text: 'Continue',
                        onTap: () {
                          userBloc.add(
                            GenderEvent(
                              gender: selectedGender,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
