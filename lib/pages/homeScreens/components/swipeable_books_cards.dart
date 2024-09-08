import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:swipable_stack/swipable_stack.dart';

class SwipeableBooksCards extends StatefulWidget {
  final List<Map<String, String>> data;
  const SwipeableBooksCards({
    super.key,
    required this.data,
    required SwipableStackController controller,
  }) : _controller = controller;

  final SwipableStackController _controller;

  @override
  State<SwipeableBooksCards> createState() => _SwipeableBooksCardsState();
}

class _SwipeableBooksCardsState extends State<SwipeableBooksCards> {
  bool _allCardsSwiped = false;
  int _swipedCount = 0; // Track the number of swiped cards

  void _onSwipeCompleted(int index, SwipeDirection direction) {
    // Increment swiped count and check if all cards have been swiped
    setState(() {
      _swipedCount++;
      if (_swipedCount >= 5) {
        // Assuming there are 5 cards (0 to 4)
        _allCardsSwiped = true; // All cards have been swiped
      }
    });
    if (kDebugMode) {
      print('$index, $direction');
    }
  }

  void _restoreCards() {
    setState(() {
      _allCardsSwiped = false; // Restore the cards
      _swipedCount = 0; // Reset the swiped count
      widget._controller.currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.57,
      width: screenWidth * 0.99,
      child: Stack(
        children: [
          SwipableStack(
            dragStartBehavior: DragStartBehavior.down,
            swipeAnchor: SwipeAnchor.bottom,
            detectableSwipeDirections: const {
              SwipeDirection.right,
              SwipeDirection.left,
            },
            controller: widget._controller,
            stackClipBehaviour: Clip.none,
            onSwipeCompleted: _onSwipeCompleted,
            itemCount: 5, // Updated item count to 5
            horizontalSwipeThreshold: 0.8,
            verticalSwipeThreshold: 0.8,
            builder: (context, properties) {
              final itemIndex = properties.index % 5;

              final double rotationAngle;
              final double translationOffset;

              if (itemIndex < 3) {
                // For the first three cards
                rotationAngle =
                    (itemIndex) * 0.04; // Adjust rotation for first three cards
                translationOffset = (itemIndex) *
                    40.0; // Adjust vertical offset for first three cards
              } else {
                // For the remaining cards
                rotationAngle = (itemIndex) * 0.0001; // Reverse rotation effect
                translationOffset =
                    (4 - itemIndex) * 30.0; // Reverse vertical offset effect
              }

              return GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (_) => PDFViewerFromUrl(
                        url: widget.data[0]['pdfUrl']!,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.44,
                        width: screenWidth * 0.77,
                        child: CardView(
                          text: "Introduction  to \n Algorithm",
                          rotationAngle: rotationAngle,
                          translationOffset: translationOffset,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          if (_allCardsSwiped) // Show the button when all cards are swiped
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                onPressed: _restoreCards,
                child: const Text(
                  'Restore All Books',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class PDFViewerFromUrl extends StatelessWidget {
  const PDFViewerFromUrl({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'PDF From Url',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const PDF().fromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}

class PDFViewerCachedFromUrl extends StatelessWidget {
  const PDFViewerCachedFromUrl({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cached PDF From Url'),
      ),
      body: const PDF().cachedFromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}

class PDFViewerFromAsset extends StatelessWidget {
  PDFViewerFromAsset({super.key, required this.pdfAssetPath});
  final String pdfAssetPath;
  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
      StreamController<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF From Asset'),
        actions: <Widget>[
          StreamBuilder<String>(
              stream: _pageCountController.stream,
              builder: (_, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue[900],
                      ),
                      child: Text(snapshot.data!),
                    ),
                  );
                }
                return const SizedBox();
              }),
        ],
      ),
      body: PDF(
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onPageChanged: (int? current, int? total) =>
            _pageCountController.add('${current! + 1} - $total'),
        onViewCreated: (PDFViewController pdfViewController) async {
          _pdfViewController.complete(pdfViewController);
          final int currentPage = await pdfViewController.getCurrentPage() ?? 0;
          final int? pageCount = await pdfViewController.getPageCount();
          _pageCountController.add('${currentPage + 1} - $pageCount');
        },
      ).fromAsset(
        pdfAssetPath,
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _pdfViewController.future,
        builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: '-',
                  child: const Text('-'),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data!;
                    final int currentPage =
                        (await pdfController.getCurrentPage())! - 1;
                    if (currentPage >= 0) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
                FloatingActionButton(
                  heroTag: '+',
                  child: const Text('+'),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data!;
                    final int currentPage =
                        (await pdfController.getCurrentPage())! + 1;
                    final int numberOfPages =
                        await pdfController.getPageCount() ?? 0;
                    if (numberOfPages > currentPage) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class CardView extends StatelessWidget {
  final String text;
  final double rotationAngle;
  final double translationOffset;

  const CardView({
    super.key,
    required this.text,
    this.rotationAngle = 0.0,
    this.translationOffset = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(rotationAngle)
        ..translate(0.0, translationOffset),
      child: Container(
        alignment: Alignment.center,
        height: 300,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromRGBO(84, 62, 233, 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
