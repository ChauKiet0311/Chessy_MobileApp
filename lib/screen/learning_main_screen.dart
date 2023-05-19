import "package:flutter/material.dart";

class LearningTabView extends StatefulWidget {
  const LearningTabView({super.key});

  @override
  State<LearningTabView> createState() {
    return _LearningTabView();
  }
}

class _LearningTabView extends State<LearningTabView> {
  @override
  Widget build(BuildContext context) {
    return Column(children: const [
      const SizedBox(
        height: 50,
      ),
      const Text(
        "LEARNING",
        style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Colors.white),
      ),
    ]);
  }
}
