import 'package:bootcamp_team_83_flutter/models/achievement_model.dart';

class SuccessScreenViewModel {
  List<Achievement> get achievements => [
        Achievement(
          imageAsset: 'assets/achievements/baslangic_yildizi.png',
          title: 'Başlangıç yıldızı',
          description: 'İlk sorunu doğru cevapladığında kazanacaksın.',
        ),
        Achievement(
          imageAsset: 'assets/achievements/bilim_insani.png',
          title: 'Bilim İnsanı',
          description: '1. bölümü tamamladığında kazanacaksın.',
        ),
        Achievement(
          imageAsset: 'assets/achievements/koloni_kurucusu.png',
          title: 'Koloni Kurucusu',
          description: '2. bölümü tamamladığında kazanacaksın.',
        ),
        Achievement(
          imageAsset: 'assets/achievements/kizil_gezegen_fatihi.png',
          title: 'Kızıl Gezegen Fatihi',
          description: '3. bölümü tamamladığında kazanacaksın.',
        ),
        Achievement(
          imageAsset: 'assets/achievements/algoritma_ustasi.png',
          title: 'Algoritma Ustası',
          description: '4. bölümü tamamladığında kazanacaksın.',
        ),
        Achievement(
          imageAsset: 'assets/achievements/manyetik_alan_ustasi.png',
          title: 'Manyetik Alan Ustası',
          description: '5. bölümü tamamladığında kazanacaksın.',
        ),
        Achievement(
          imageAsset: 'assets/achievements/sistem_analisti.png',
          title: 'Sistem Analisti',
          description: '6. bölümü tamamladığında kazanacaksın.',
        ),
        Achievement(
          imageAsset: 'assets/achievements/galaksi_kaşifi.png',
          title: 'Galaksi Kaşifi',
          description: '7. bölümü tamamladığında kazanacaksın.',
        ),
      ];
}
