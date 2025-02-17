import 'package:flutter/material.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/onboardingscreen/third_page.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/onboardingscreen/widgets.dart';
import 'package:audioplayers/audioplayers.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isSoundPlaying = false;
  double _volume = 1.0; // Ses seviyesi

  @override
  void initState() {
    super.initState();
    _preloadAndPlayBackgroundSound();
  }

  @override
  void dispose() {
    _stopSound(); // Sayfa kapanırken sesi durdur
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _preloadAndPlayBackgroundSound() async {
    try {
      await _audioPlayer.setSource(AssetSource('ses_klavye.mp3'));
      _playBackgroundSound();
    } catch (e) {
      print("Error preloading audio: $e");
    }
  }

  void _playBackgroundSound() async {
    try {
      _audioPlayer.setReleaseMode(ReleaseMode.loop);
      _audioPlayer.setVolume(_volume);
      _audioPlayer.resume();
      _isSoundPlaying = true;

      // Sesin azalmasını bir saniye erken başlat
      await Future.delayed(
          const Duration(seconds: 2)); // 3 saniye yerine 2 saniye bekle

      // Ses yavaşça azalacak
      const decreaseDuration = Duration(seconds: 1);
      final decreaseStep =
          decreaseDuration.inMilliseconds ~/ 20; // 20 adımda azaltma

      for (double i = _volume; i >= 0; i -= 0.05) {
        await Future.delayed(Duration(milliseconds: decreaseStep));
        if (!_isSoundPlaying) break;
        _audioPlayer.setVolume(i);
      }
      _audioPlayer.stop(); // Ses tamamen durduktan sonra stop et
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  void _stopSound() {
    if (_isSoundPlaying) {
      _audioPlayer.stop();
      _isSoundPlaying = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/arka_plan.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: TypewriterEffect(
                        text: "CodeMania Beyond the Space",
                        textStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        duration: const Duration(milliseconds: 100),
                        onTypingStart: () {},
                        onTypingComplete: () {},
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CustomProgressBar(currentPage: 2),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _stopSound(); // Ses durduruluyor
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ThirdPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        Colors.transparent, // Butonun arka plan rengi
                    side: const BorderSide(
                      color: Colors.white, // Şerit rengi
                      width: 2, // Şerit kalınlığı
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'DEVAM',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
