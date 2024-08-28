import 'package:flutter/material.dart';

class ExpansionListTopicsWidget extends StatefulWidget {
  const ExpansionListTopicsWidget({
    super.key,
  });

  @override
  State<ExpansionListTopicsWidget> createState() =>
      _ExpansionListTopicsWidgetState();
}

class _ExpansionListTopicsWidgetState extends State<ExpansionListTopicsWidget> {
  final List<bool> _isOpen = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expandIconColor: const Color.fromRGBO(255, 107, 107, 1),
      animationDuration: const Duration(seconds: 1),
      elevation: 2,
      expandedHeaderPadding: const EdgeInsets.all(8),
      materialGapSize: 15,
      dividerColor: const Color.fromRGBO(255, 107, 107, 1),
      children: [
        ExpansionPanel(
          canTapOnHeader: true,
          backgroundColor: const Color.fromRGBO(84, 62, 233, 1),
          headerBuilder: (context, isOpen) {
            return const Padding(
              padding: EdgeInsets.only(top: 12.0, left: 12, right: 12),
              child: Text(
                "Divide and Conquer",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(255, 107, 107, 1)),
              ),
            );
          },
          body: const ExpansionPanelBody(
            infoText:
                "Divide and Conquer Algorithm is a problem-solving technique used to solve problems by dividing the main problem into subproblems, solving them individually and then merging them to find solution to the original problem.",
            imagePath: "assets/icons/dac.png",
          ),
          isExpanded: _isOpen[0],
        ),
        ExpansionPanel(
          canTapOnHeader: true,
          backgroundColor: const Color.fromRGBO(84, 62, 233, 1),
          headerBuilder: (context, isOpen) {
            return const Padding(
              padding: EdgeInsets.only(top: 12.0, left: 12, right: 12),
              child: Text(
                "Normalization",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(255, 107, 107, 1)),
              ),
            );
          },
          body: const ExpansionPanelBody(
            infoText:
                "Normalization is the process of minimizing redundancy from a relation or set of relations. Redundancy in relation may cause insertion, deletion, and update anomalies. So, it helps to minimize the redundancy in relations.",
            imagePath: "assets/icons/NormalizationTopPicksIcon.jpg",
          ),
          isExpanded: _isOpen[1],
        ),
        ExpansionPanel(
          canTapOnHeader: true,
          backgroundColor: const Color.fromRGBO(84, 62, 233, 1),
          headerBuilder: (context, isOpen) {
            return const Padding(
              padding: EdgeInsets.only(top: 12.0, left: 12, right: 12),
              child: Text(
                "CPU Scheduling",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(255, 107, 107, 1)),
              ),
            );
          },
          body: const ExpansionPanelBody(
            infoText:
                "CPU Scheduling is a process that allows one process to use the CPU while another process is delayed (in standby) due to unavailability of any resources such as I / O etc, thus making full use of the CPU.",
            imagePath: "assets/icons/cpuSchedulingHomeScreenIcon.png",
          ),
          isExpanded: _isOpen[2],
        ),
        ExpansionPanel(
          canTapOnHeader: true,
          backgroundColor: const Color.fromRGBO(84, 62, 233, 1),
          headerBuilder: (context, isOpen) {
            return const Padding(
              padding: EdgeInsets.only(top: 12.0, left: 12, right: 12),
              child: Text(
                "Pushdown Automata",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(255, 107, 107, 1)),
              ),
            );
          },
          body: const ExpansionPanelBody(
            fit: BoxFit.contain,
            infoText:
                "Pushdown Automata is a finite automata with extra memory called stack which helps Pushdown automata to recognize Context Free Languages. A Pushdown Automata (PDA) can be defined as : Q is the set of states. ∑is the set of input symbols. Γ is the set of pushdown symbols (which can be pushed and popped from stack).",
            imagePath: "assets/icons/PdatopPicksicon.jpg",
          ),
          isExpanded: _isOpen[3],
        ),
        ExpansionPanel(
          canTapOnHeader: true,
          backgroundColor: const Color.fromRGBO(84, 62, 233, 1),
          headerBuilder: (context, isOpen) {
            return const Padding(
              padding: EdgeInsets.only(top: 12.0, left: 12, right: 12),
              child: Text(
                "Sliding Window Protocol",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(255, 107, 107, 1)),
              ),
            );
          },
          body: const ExpansionPanelBody(
            infoText:
                "In this protocol, multiple frames can be sent by a sender at a time before receiving an acknowledgment from the receiver. The term sliding window refers to the imaginary boxes to hold frames. Sliding window method is also known as windowing.",
            imagePath: "assets/icons/swpTopPicksIcon.png",
          ),
          isExpanded: _isOpen[4],
        )
      ],
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          _isOpen[panelIndex] = isExpanded;
        });
      },
    );
  }
}

class ExpansionPanelBody extends StatelessWidget {
  final String infoText;
  final String imagePath;
  final BoxFit fit;
  const ExpansionPanelBody({
    super.key,
    required this.infoText,
    required this.imagePath,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      // color: Colors.red,
      padding: const EdgeInsets.only(top: 1, left: 15, right: 15, bottom: 10),
      width: screenWidth * 0.999,
      height: screenHeight * 0.27,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                "${infoText}",
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Image(
            fit: fit,
            height: 220,
            width: 130,
            image: AssetImage(imagePath),
          ),
        ],
      ),
    );
  }
}
