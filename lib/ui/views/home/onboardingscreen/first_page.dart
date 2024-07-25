import 'package:bootcamp_team_83_flutter/ui/views/home/onboardingscreen/second_page.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/onboardingscreen/widgets.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playBackgroundSound();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playBackgroundSound() async {
    try {
      await _audioPlayer.setSource(AssetSource('assets/ses_klavye.mp3'));
      _audioPlayer.setReleaseMode(ReleaseMode.loop);
      _audioPlayer.resume();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey, // Arka plan rengini ayarla
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
                        text:
                            '\t Yıl 2249. İnsanlık, uzayın sırrını çözmek ve yeni gezegenler keşfetmek için “Uzay Keşfi Akademisi”ni kurdu.\n\n'
                            'Sen de bu akademiye kabul edilen seçilmiş zihinlerden birisin.\n\n'
                            'Akademide, kodlama becerilerini kullanarak uzayı keşfedeceksin.',
                        textStyle: TextStyle(
                          fontSize: 25, // Daha büyük yazı boyutu
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        duration: Duration(
                            milliseconds: 50), // Daha hızlı yazma süresi
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomProgressBar(currentPage: 1),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        Colors.transparent, // Butonun arka plan rengi
                    side: BorderSide(
                      color: Colors.white, // Şerit rengi
                      width: 2, // Şerit kalınlığı
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'DEVAM',
                    style: TextStyle(
                      fontSize: 20, // Daha büyük yazı boyutu
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
