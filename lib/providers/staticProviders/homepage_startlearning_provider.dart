// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homepageStartLearningProvider =
    StateNotifierProvider<HomePageStartLearningNotifier, HomepageStartLearning>(
        (ref) {
  return HomePageStartLearningNotifier();
});

class HomepageStartLearning {
  final List<Map<String, String>> data;
  const HomepageStartLearning(
    this.data,
  );

  HomepageStartLearning copyWith({
    List<Map<String, String>>? data,
  }) {
    return HomepageStartLearning(
      data ?? this.data,
    );
  }
}

class HomePageStartLearningNotifier
    extends StateNotifier<HomepageStartLearning> {
  HomePageStartLearningNotifier()
      : super(
          const HomepageStartLearning([
            {
              "imageUrl":
                  "https://cdn0.iconfinder.com/data/icons/database-table-and-cardinality/128/database-12-512.png",
              "subject": "Database Management System",
              "chapters": "12",
            },
            {
              "imageUrl":
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/C_Programming_Language.svg/570px-C_Programming_Language.svg.png?20201031132917",
              "subject": "Programming C Language",
              "chapters": "08",
            },
            {
              "imageUrl":
                  "https://hamnus.com/wp-content/uploads/2023/07/Data-Structures-and-Algorithm.png",
              "subject": "Data Structures & Algorithms",
              "chapters": "15",
            },
            {
              "imageUrl":
                  "https://banner2.cleanpng.com/20180703/esg/aaxqyfo3x.webp",
              "subject": "Theory of Computation",
              "chapters": "17",
            },
          ]),
        );
}
