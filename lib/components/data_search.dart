import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  final subjects = [
    "Engineering Mathematics",
    "Discrete Mathematics",
    "Matrices",
    "Differential Equations",
    "Linear Algebra",
    "Calculus",
    "Probability",
    "Digital Logic",
    "Boolean algebra",
    "Computer Organization and Architecture",
    "Programming C Language",
    "Recursion",
    "Graphs",
    "Trees",
    "Binary Search Trees",
    "Heaps",
    "Linked Lists",
    "Stacks",
    "Queues",
    "Hashing",
    "Sets",
    "Arrays",
    "Algorithms",
    "Big O Notation",
    "Dynamic Programming",
    "Greedy Algorithms",
    "Backtracking",
    "Divide and Conquer",
    "Sorting",
    "Theroy of Computation",
    "Regular Expressions",
    "Context-free Grammars",
    "Turing Machines",
    "Compiler Design",
    "Lexical Analysis",
    "Parsing",
    "Operating Systems",
    "Deadlock",
    "Concurrency and synchronization",
    "CPU and I/O scheduling",
    "Memory Management",
    "File Systems",
    "Database Management Systems",
    "ER-Model",
    "SQL",
    "Structured Query Language",
    "Transactions and concurrency control",
    "Relational databases",
    "Normalization",
    "Database Anomalies",
    "File Organization",
    "Indexing (B and B+Tree)",
    "Relational Database Management Systems",
    "Computer Networks",
    "Concept of layering",
    "OSI model",
    "TCP/IP model",
    "Data Link Layer",
    "Network Address Translation",
    "Transport Layer",
    "DNS",
    "SMTP",
    "FTP",
    "HTTP",
  ];

  final recentSubjects = [
    "Engineering Mathematics",
    "Database Management Systems",
    "Computer Networks",
    "Data Structures",
  ];

  String selectedSuggestion = "";

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      // Customize the text theme of the search query
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            color: Color.fromRGBO(84, 62, 233, 1),
            fontSize: 25,
            fontWeight: FontWeight.w500 // Adjust font size if needed
            ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(
            84, 62, 233, 0.1), // Change the app bar background color
      ),
      // Customize the input decoration
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(
            color: Color.fromRGBO(84, 62, 233, 1),
            fontSize: 22 // Change the hint text color
            ),
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(
          Icons.clear,
          size: 35,
          color: Color.fromRGBO(84, 62, 233, 1),
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        color: const Color.fromRGBO(84, 62, 233, 1),
        size: 35,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(selectedSuggestion.isEmpty ? query : selectedSuggestion,
          style: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(84, 62, 233, 1),
          )),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentSubjects
        : subjects
            .where((element) =>
                element.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          selectedSuggestion = suggestionList[index];
          showResults(context);
        },
        leading: const Icon(Icons.book_outlined),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: const TextStyle(
                  color: Color.fromRGBO(84, 62, 233, 1),
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: const TextStyle(color: Colors.grey))
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
