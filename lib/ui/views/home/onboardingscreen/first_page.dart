import 'package:flutter/material.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/onboardingscreen/second_page.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/onboardingscreen/widgets.dart';
import 'package:audioplayers/audioplayers.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isSoundPlaying = false;
  double _volume = 1.0; // Ses seviyesi

  @override
  void initState() {
    super.initState();
    _playBackgroundSoundForDuration();
  }

  @override
  void dispose() {
    _stopSound(); // Sayfa kapanırken sesi durdur
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playBackgroundSoundForDuration() async {
    try {
      await _audioPlayer.setSource(AssetSource('ses_klavye.mp3'));
      _audioPlayer.setReleaseMode(ReleaseMode.loop);
      _audioPlayer.setVolume(_volume);
      _audioPlayer.resume();
      _isSoundPlaying = true;

      await Future.delayed(Duration(seconds: 10)); // Sesin azalması için bekle

      // Ses yavaşça azalacak
      for (double i = _volume; i >= 0; i -= 0.05) {
        await Future.delayed(Duration(milliseconds: 100));
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
                      child: const TypewriterEffect(
                        text:
                            '\t Yıl 2249. İnsanlık, uzayın sırrını çözmek ve yeni gezegenler keşfetmek için “Uzay Keşfi Akademisi”ni kurdu.\n\n'
                            'Sen de bu akademiye kabul edilen seçilmiş zihinlerden birisin.\n\n'
                            'Akademide, kodlama becerilerini kullanarak uzayı keşfedeceksin.',
                        textStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        duration: Duration(milliseconds: 50),
                        onTypingStart: () {},
                        onTypingComplete: () {},
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CustomProgressBar(currentPage: 1),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _stopSound(); // Ses durduruluyor
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondPage()),
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
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
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
