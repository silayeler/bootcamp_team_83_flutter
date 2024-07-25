import 'package:flutter/material.dart';
import 'package:bootcamp_team_83_flutter/ui/views/login/login_view.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/onboardingscreen/widgets.dart';

class ThirdPage extends StatelessWidget {
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
                            '\t Her kodlama görevini tamamladığında uzay geminin eksik bir parçasını bulacaksın. Eksik olan parçaları tamamladığında uzay gemini kullanarak yeni gezegenlere doğru yol alacaksın. Evrenin gizemini çözmek için maceraya hazır mısın? Öyleyse başlayalım!',
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
                  child: CustomProgressBar(currentPage: 3),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginView()),
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
                    'BAŞLA!',
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
