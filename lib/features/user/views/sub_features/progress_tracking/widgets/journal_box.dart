import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/features/authentication/bloc/authentication_bloc.dart';
import 'package:mind_labify/features/user/views/write_journals.dart';
import 'package:mind_labify/user_provider.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:mind_labify/widgets/app_primary_button.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class JournalBox extends StatefulWidget {
  const JournalBox({super.key});

  @override
  State<JournalBox> createState() => _JournalBoxState();
}

class _JournalBoxState extends State<JournalBox> {
  late final UserProvider userProvider;
  late final AuthenticationBloc authenticationBloc;
  late final AdminBloc adminBloc;
  late final PageController controller;
  int currentPage = 0;

  @override
  void initState() {
    authenticationBloc = context.read<AuthenticationBloc>();
    userProvider = context.read<UserProvider>();
    if (userProvider.user == null) {
      authenticationBloc.add(
        const GetUser(),
      );
    }
    controller = PageController();
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.journals.isEmpty) {
      adminBloc.add(
        GetJournal(),
      );
    }
    super.initState();
    controller.addListener(
      () {
        // Safely handle the controller.page value
        final page = controller.page;
        if (page != null && page.isFinite) {
          setState(
            () {
              currentPage = page.toInt();
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    controller.dispose(); // Dispose of the PageController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adminBloc = context.read<AdminBloc>();
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return BlocBuilder<AdminBloc, AdminState>(
          builder: (context, state) {
            final activeJournals = adminBloc.journals
                .where(
                  (journal) => journal.status == 'Active',
                )
                .toList();
            final filteredJournals = activeJournals.take(3).toList();
            if (state is GettingJournal) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetJournalFailed) {
              return Center(
                child: Text(state.message),
              );
            }
            return Column(
              children: [
                SizedBox(
                  height: 160,
                  child: PageView.builder(
                    onPageChanged: (int page) {
                      setState(() {
                        currentPage = page;
                      });
                    },
                    controller: controller,
                    itemCount:
                        filteredJournals.isEmpty ? 1 : filteredJournals.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, index) {      
                      return filteredJournals.isEmpty
                          ? const Center(
                              child: Text(
                                'no journal',
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 15,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                color: const Color(
                                  0xFFF2F5DB,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    filteredJournals[index].title.toString(),
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                  Gaps.hGap20,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0,
                                    ),
                                    child: AppPrimaryButton(
                                      buttonColor: 0xFFFD5DFD2,
                                      text: 'Answer',
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (
                                              context,
                                            ) =>
                                                WriteJournals(
                                              journal: filteredJournals[index],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                ),
                Gaps.hGap15,
                SmoothPageIndicator(
                  controller: controller,
                  count: filteredJournals.isEmpty ? 1 : filteredJournals.length,
                  effect: ExpandingDotsEffect(
                    radius: 0,
                    dotHeight: 5,
                    dotWidth: 8,
                    spacing: 10,
                    dotColor: const Color(
                      0xFF979797,
                    ),
                    activeDotColor: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
