import 'package:flutter/material.dart';

Column snsUIHeartComponent({
  required BuildContext context,
  required bool isHeart,
  required Function() onHeartTap,
  bool isShowHeart = false,
  required int imageIndex,
}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(1.5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    'https://picsum.photos/id/$imageIndex/400/400',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'snsaccount',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      GestureDetector(
        onDoubleTap: onHeartTap,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Image.network(
                'https://picsum.photos/id/$imageIndex/400/400',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: AnimatedSwitcher(
                    switchInCurve: Curves.fastLinearToSlowEaseIn,
                    switchOutCurve: Curves.fastLinearToSlowEaseIn,
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) => ScaleTransition(
                          scale: animation,
                          child: child,
                        ),
                    child: isShowHeart
                        ? const Icon(
                            Icons.favorite_rounded,
                            key: ValueKey('SHOW_HEART'),
                            size: 80,
                          )
                        : const Icon(
                            Icons.favorite_rounded,
                            size: 0,
                          )),
              )
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              children: [
                GestureDetector(
                  onTap: onHeartTap,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: ((child, animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    }),
                    child: !isHeart
                        ? const Icon(
                            key: ValueKey('UN_FAVORITE'),
                            Icons.favorite_border_outlined,
                            size: 30,
                          )
                        : const Icon(
                            key: ValueKey('FAVORITE'),
                            Icons.favorite_outlined,
                            color: Colors.red,
                            size: 30),
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(
                  Icons.chat_bubble_outline,
                  size: 30,
                ),
              ],
            ),
            const Icon(
              Icons.bookmark_border_outlined,
              size: 30,
            ),
          ],
        ),
      )
    ],
  );
}
