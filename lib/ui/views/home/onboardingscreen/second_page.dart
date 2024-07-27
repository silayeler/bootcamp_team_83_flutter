import 'package:flutter/material.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/onboardingscreen/third_page.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/onboardingscreen/widgets.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

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
                      child: const TypewriterEffect(
                        text: "CodeMania Beyond the Space",

                        textStyle: TextStyle(
                          fontSize: 25, // Daha büyük yazı boyutu
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        duration: Duration(
                            milliseconds: 100), // Daha hızlı yazma süresi
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ThirdPage()),
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
