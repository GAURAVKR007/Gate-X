import 'package:flutter_riverpod/flutter_riverpod.dart';

final homepageResourcesProvider =
    StateNotifierProvider<ResourceHomeNotifier, HomepageResources>((ref) {
  return ResourceHomeNotifier();
});

class HomepageResources {
  final List<Map<String, String>> data;
  const HomepageResources(
    this.data,
  );
}

class ResourceHomeNotifier extends StateNotifier<HomepageResources> {
  ResourceHomeNotifier()
      : super(
          const HomepageResources([
            {
              "resourceIcon": "assets/icons/notice-board-resource-icon.png",
              "resourceText": "  Notice -   \n     Board",
            },
            {
              "resourceIcon": "assets/icons/leaderboard-resource-icon.png",
              "resourceText": "  Leader -  \n     Board",
            },
            {
              "resourceIcon": "assets/icons/news-resource-icon.png",
              "resourceText": "  News -  \n     Feed",
            },
            {
              "resourceIcon": "assets/icons/cube-resources-homescreen.png",
              "resourceText": "Community Forum",
            },
            {
              "resourceIcon": "assets/icons/score-predictor-resource-icon.png",
              "resourceText": "Gate Score Predictor",
            },
            {
              "resourceIcon": "assets/icons/exam-countdown-resource-icon.png",
              "resourceText": "Exam \nCountdown",
            },
            {
              "resourceIcon": "assets/icons/formula-resource-icon.png",
              "resourceText": "Important Formulas",
            },
            {
              "resourceIcon": "assets/icons/bookmark-resource-icon.png",
              "resourceText": "Saved Bookmarks",
            },
          ]),
        );
}
