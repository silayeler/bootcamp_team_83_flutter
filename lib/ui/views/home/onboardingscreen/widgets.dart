import 'package:flutter/material.dart';
import 'dart:async';

// TypewriterEffect Widget
class TypewriterEffect extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final Duration duration;

  const TypewriterEffect({
    Key? key,
    required this.text,
    required this.textStyle,
    required this.duration, required void Function() onTypingStart, required void Function() onTypingComplete,
  }) : super(key: key);

  @override
  _TypewriterEffectState createState() => _TypewriterEffectState();
}

class _TypewriterEffectState extends State<TypewriterEffect> {
  late String _displayedText;
  late Timer _timer;
  int _textIndex = 0;

  @override
  void initState() {
    super.initState();
    _displayedText = '';
    _startTyping();
  }

  void _startTyping() {
    _timer = Timer.periodic(widget.duration, (timer) {
      if (_textIndex < widget.text.length) {
        setState(() {
          _displayedText += widget.text[_textIndex];
          _textIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayedText,
      style: widget.textStyle,
    );
  }
}

// CustomProgressBar Widget
class CustomProgressBar extends StatelessWidget {
  final int currentPage;

  const CustomProgressBar({Key? key, required this.currentPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 20,
          height: 6,
          decoration: BoxDecoration(
            color: index < currentPage ? Colors.white : Colors.grey,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}
