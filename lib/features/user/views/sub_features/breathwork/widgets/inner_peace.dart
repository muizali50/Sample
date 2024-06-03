import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mind_labify/utils/gaps.dart';

class InnerPeace extends StatefulWidget {
  const InnerPeace({super.key});

  @override
  State<InnerPeace> createState() => _InnerPeaceState();
}

class _InnerPeaceState extends State<InnerPeace> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.custom(
        gridDelegate: SliverWovenGridDelegate.count(
          crossAxisCount: 2,
          mainAxisSpacing: 6,
          crossAxisSpacing: 4,
          pattern: [
            const WovenGridTile(1),
            const WovenGridTile(
              7 / 9,
              crossAxisRatio: 0.9,
              alignment: AlignmentDirectional.centerEnd,
            ),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          childCount: 4,
          (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  16,
                ),
                color: const Color(
                  0xFFE7F6FF,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Reflection',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(
                        0xFF191D21,
                      ),
                    ),
                  ),
                  Gaps.hGap05,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                      color: const Color(
                        0xFFffffff,
                      ),
                    ),
                    child: const Text(
                      '6 min',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: Color(
                          0xFF393939,
                        ),
                      ),
                    ),
                  ),
                  Gaps.hGap10,
                   const Center(
                    child: SizedBox(
                      height: 72,
                      width: 100,
                      child: Image(
                        fit: BoxFit.contain,
                        image: NetworkImage(
                          'https://banner2.cleanpng.com/20190512/wqe/kisspng-sahaja-yoga-self-realization-meditation-collection-of-free-yoga-vector-banner-download-on-5cd8d8a4bc34b1.1300772715577151087709.jpg',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
