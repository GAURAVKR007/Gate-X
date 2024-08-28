// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeSliderProvider =
    StateNotifierProvider<HomeSliderNotifier, HomesliderNumber>((ref) {
  return HomeSliderNotifier();
});

class HomesliderNumber {
  final int carousalCurrentIndex;
  final Map<String, String> banners;

  HomesliderNumber(this.carousalCurrentIndex, this.banners);

  HomesliderNumber copyWith({
    int? carousalCurrentIndex,
    Map<String, String>? banners,
  }) {
    return HomesliderNumber(
      carousalCurrentIndex ?? this.carousalCurrentIndex,
      banners ?? this.banners,
    );
  }
}

class HomeSliderNotifier extends StateNotifier<HomesliderNumber> {
  HomeSliderNotifier()
      : super(
          HomesliderNumber(0, {
            "https://img.freepik.com/premium-photo/3d-render-error-404-page-found-your-mockup-design_252008-643.jpg":
                "",
          }),
        );

  void updateHomeSliderIndex(index) {
    state = state.copyWith(carousalCurrentIndex: index);
  }

  void updateBanners(Map<String, String> banners) {
    state = state.copyWith(banners: banners);
  }
}
