import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/features/user/user_bloc/user_bloc.dart';
import 'package:mind_labify/features/user/views/navigation_menu.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:mind_labify/widgets/app_primary_button.dart';

class SelectStressors extends StatefulWidget {
  const SelectStressors({super.key});

  @override
  State<SelectStressors> createState() => _SelectStressorsState();
}

class _SelectStressorsState extends State<SelectStressors> {
  late final AdminBloc adminBloc;
  late final UserBloc userBloc;
  final List<String> _stressorsName = [];

  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.activeStressors.isEmpty) {
      adminBloc.add(
        GetStressor(),
      );

      userBloc = context.read<UserBloc>();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = context.watch<UserBloc>();
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            fit: BoxFit.cover,
            'assets/images/str.png',
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Gaps.hGap20,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (
                              context,
                            ) =>
                                const BottomNavBar(),
                          ),
                        );
                      },
                      icon: const Icon(
                        size: 22,
                        CupertinoIcons.xmark,
                      ),
                    ),
                  ),
                  Gaps.hGap25,
                  const Text(
                    'What stressors are affecting you today?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Color(
                        0xFF371B34,
                      ),
                    ),
                  ),
                  Gaps.hGap40,
                  BlocBuilder<AdminBloc, AdminState>(
                    builder: (context, state) {
                      if (state is GetStressorSuccess) {
                        return Expanded(
                          child: GridView.builder(
                            itemCount: adminBloc.activeStressors.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 8,
                              mainAxisExtent: 50,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(
                                    () {
                                      if (_stressorsName.contains(
                                            adminBloc
                                                .activeStressors[index].title
                                                .toString(),
                                          ) ==
                                          true) {
                                        _stressorsName.remove(
                                          adminBloc.activeStressors[index].title
                                              .toString(),
                                        );
                                      } else {
                                        _stressorsName.add(
                                          adminBloc.activeStressors[index].title
                                              .toString(),
                                        );
                                      }
                                    },
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _stressorsName.contains(
                                              adminBloc
                                                  .activeStressors[index].title
                                                  .toString(),
                                            ) ==
                                            true
                                        ? const Color(
                                            0xFFB9BF88,
                                          )
                                        : const Color(
                                            0xFFD4DFD1,
                                          ),
                                    borderRadius: BorderRadius.circular(
                                      50,
                                    ),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: adminBloc
                                                            .activeStressors[
                                                                index]
                                                            .icon !=
                                                        null &&
                                                    adminBloc
                                                        .activeStressors[index]
                                                        .icon!
                                                        .isNotEmpty
                                                ? DecorationImage(
                                                    image: NetworkImage(
                                                      adminBloc
                                                          .activeStressors[
                                                              index]
                                                          .icon!,
                                                    ),
                                                  )
                                                : const DecorationImage(
                                                    image: AssetImage(
                                                      'assets/icons/s_happy.png',
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          adminBloc.activeStressors[index].title
                                              .toString(),
                                          style: TextStyle(
                                            color: _stressorsName.contains(
                                                      adminBloc
                                                          .activeStressors[
                                                              index]
                                                          .title
                                                          .toString(),
                                                    ) ==
                                                    true
                                                ? const Color(
                                                    0xFFffffff,
                                                  )
                                                : const Color(
                                                    0xFF000000,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else if (state is GettingStressor) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return const Center(
                          child: Text(
                            'no data',
                          ),
                        );
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: BlocConsumer<UserBloc, UserState>(
                      listener: (context, state) {
                        if (state is StressorSelected) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (
                                context,
                              ) =>
                                  const BottomNavBar(),
                            ),
                          );
                        } else if (state is StressorSelectedFailed) {
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
                        if (state is SelectingStressor) {
                          return const CircularProgressIndicator();
                        }
                        return AppPrimaryButton(
                          buttonColor: 0xFFF4F2E8,
                          text: 'Continue',
                          onTap: () {
                            userBloc.add(
                              SelectStressor(
                                stressorsName: _stressorsName,
                              ),
                            );
                          },
                        );
                      },
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
