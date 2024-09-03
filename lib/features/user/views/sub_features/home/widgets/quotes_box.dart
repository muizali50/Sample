import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/features/user/views/declaration_detail_screen.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class QuotesBox extends StatefulWidget {
  const QuotesBox({
    super.key,
  });

  @override
  State<QuotesBox> createState() => _QuotesBoxState();
}

class _QuotesBoxState extends State<QuotesBox> {
  late final AdminBloc adminBloc;
  late final PageController controller;
  int currentPage = 0;

  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.declarations.isEmpty) {
      adminBloc.add(
        GetDeclaration(),
      );
    }
    controller = PageController();
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
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        final activeDeclarations = adminBloc.declarations
            .where(
              (declaration) => declaration.status == 'Active',
            )
            .toList();
        final declaration = activeDeclarations.take(3).toList();
        if (state is GettingDeclaration) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetDeclarationFailed) {
          return Center(
            child: Text(state.message),
          );
        }
        return Column(
          children: [
            SizedBox(
              height: 79,
              child: PageView.builder(
                onPageChanged: (int page) {
                  setState(() {
                    currentPage = page;
                  });
                },
                controller: controller,
                itemCount: declaration.isEmpty ? 1 : declaration.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, index) {
                  return declaration.isEmpty
                      ? const Center(
                          child: Text(
                            'no declaration',
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DeclarationDetailScreen(
                                  declaration: declaration[index],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                16,
                              ),
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(
                                    0.5,
                                  ),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 258,
                                  child: Text(
                                    '“${declaration[index].description}”',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Color(
                                        0xFF707070,
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Image(
                                  height: 20,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  image: const AssetImage(
                                    'assets/icons/quote.png',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                },
              ),
            ),
            Gaps.hGap15,
            SmoothPageIndicator(
              controller: controller,
              count: declaration.isEmpty ? 1 : declaration.length,
              effect: const ExpandingDotsEffect(
                radius: 0,
                dotHeight: 8,
                dotWidth: 10,
                spacing: 10,
                dotColor: Color(
                  0xFF979797,
                ),
                activeDotColor: Color(
                  0xFF87B39B,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
