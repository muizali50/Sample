import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/user/user_bloc/user_bloc.dart';
import 'package:mind_labify/features/user/views/gender_screen.dart';
import 'package:mind_labify/widgets/app_primary_button.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  int selectedAge = 25;
  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserBloc>();
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
                  'How old are you?',
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
                  'Please provide your age in years',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: 550,
                      child: CupertinoPicker(
                        selectionOverlay:
                            const CupertinoPickerDefaultSelectionOverlay(
                          background: Colors.transparent,
                        ),
                        scrollController: FixedExtentScrollController(
                          initialItem: selectedAge - 1,
                        ),
                        itemExtent: 77,
                        onSelectedItemChanged: (int index) {
                          setState(
                            () {
                              selectedAge = index + 1;
                            },
                          );
                        },
                        children: List<Widget>.generate(
                          100,
                          (int index) {
                            final bool isSelected = selectedAge == (index + 1);

                            return Center(
                              child: Text(
                                (index + 1).toString(),
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 64,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.secondary
                                      : const Color(0xFF000000).withOpacity(
                                          0.2,
                                        ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: IgnorePointer(
                          child: Container(
                            width: 137,
                            height: 77,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  width: 2,
                                ),
                                bottom: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                BlocConsumer<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state is AgeSelected) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GenderScreen(),
                        ),
                      );
                    } else if (state is AgeSelectedFailed) {
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
                    if (state is AgeSelecting) {
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
                            AgeSelect(
                              age: selectedAge.toString(),
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
