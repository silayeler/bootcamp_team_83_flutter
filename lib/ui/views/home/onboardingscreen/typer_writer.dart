import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class TypewriterEffect extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final Duration duration;

  const TypewriterEffect({
    Key? key,
    required this.text,
    required this.textStyle,
    required this.duration,
  }) : super(key: key);

  @override
  _TypewriterEffectState createState() => _TypewriterEffectState();
}

class _TypewriterEffectState extends State<TypewriterEffect> {
  late String _displayedText = '';
  late AudioPlayer _audioPlayer;
  late Duration _duration;
  late int _currentCharIndex = 0;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _duration = widget.duration;
    _playAudio();
    _typeText();
  }

  void _playAudio() async {
    try {
      await _audioPlayer.setSource(AssetSource('assets/ses_klavye.mp3'));
      _audioPlayer.setReleaseMode(ReleaseMode.loop);
      _audioPlayer.resume();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  void _typeText() {
    Future.delayed(_duration, () {
      if (_currentCharIndex < widget.text.length) {
        setState(() {
          _displayedText += widget.text[_currentCharIndex];
          _currentCharIndex++;
        });
        _playAudio(); // Continue playing the audio
        _typeText();
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
