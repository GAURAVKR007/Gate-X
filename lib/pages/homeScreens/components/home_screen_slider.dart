import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;
import 'package:gate_x/components/shapesContainer/circular_container.dart';
import 'package:gate_x/pages/homeScreens/components/rounded_image.dart';
import 'package:gate_x/providers/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreenSlider extends ConsumerWidget {
  final Map<String, String> banners;

  const HomeScreenSlider({
    super.key,
    required this.banners,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        carousel_slider.CarouselSlider(
          options: carousel_slider.CarouselOptions(
            autoPlayInterval: const Duration(seconds: 7),
            autoPlayCurve: Curves.bounceInOut,
            autoPlay: true,
            viewportFraction: 1,
            onPageChanged: (index, _) {
              ref
                  .read(homeSliderProvider.notifier)
                  .updateHomeSliderIndex(index);
            },
          ),
          items: banners.entries.map((entry) {
            return RoundedImage(
              imageUrl: entry.value.toString(),
              isNetworkImage: true,
              width: screenWidth * 0.99,
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < banners.length; i++)
              CircularContainer(
                width: 20,
                height: 5,
                margin: const EdgeInsets.only(right: 10),
                backgroundColor:
                    ref.watch(homeSliderProvider).carousalCurrentIndex == i
                        ? const Color.fromRGBO(84, 62, 233, 1)
                        : Colors.white,
              ),
          ],
        )
      ],
    );
  }
}
