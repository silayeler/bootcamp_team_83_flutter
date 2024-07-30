import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class TypewriterEffect extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final Duration duration;
  final VoidCallback onTypingStart;

  const TypewriterEffect({
    Key? key,
    required this.text,
    required this.textStyle,
    required this.duration,
    required this.onTypingStart,
  }) : super(key: key);

  @override
  _TypewriterEffectState createState() => _TypewriterEffectState();
}

class _TypewriterEffectState extends State<TypewriterEffect> {
  String _displayedText = '';
  late AudioPlayer _audioPlayer;
  int _currentCharIndex = 0;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playAudio();
    widget.onTypingStart(); // onTypingStart fonksiyonunu çağır
    _typeText();
  }

  void _playAudio() async {
    try {
      await _audioPlayer.setSource(AssetSource('ses_klavye.mp3'));
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.resume();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  void _typeText() {
    Future.delayed(widget.duration, () {
      if (_currentCharIndex < widget.text.length) {
        setState(() {
          _displayedText += widget.text[_currentCharIndex];
          _currentCharIndex++;
        });
        _typeText(); // Continue typing
      } else {
        _audioPlayer.stop(); // Stop the audio when typing is done
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayedText,
      style: widget.textStyle,
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
