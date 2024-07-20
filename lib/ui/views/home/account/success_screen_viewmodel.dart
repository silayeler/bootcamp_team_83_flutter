class Achievement {
  final String imageAsset;
  final String title;
  final String description;

  Achievement({
    required this.imageAsset,
    required this.title,
    required this.description,
  });
}

class SuccessScreenViewModel {
  List<Achievement> get achievements => [
        Achievement(
          imageAsset: 'assets/baslangic_yildizi.png',
          title: 'Başlangıç yıldızı',
          description: 'İlk sorunu doğru cevapladığında kazanacaksın.',
        ),
        Achievement(
          imageAsset: 'assets/bilim_insani.png',
          title: 'Bilim İnsanı',
          description: '1. bölümü tamamladığında kazanacaksın.',
        ),
        Achievement(
          imageAsset: 'assets/koloni_kurucusu.png',
          title: 'Koloni Kurucusu',
          description: '2. bölümü tamamladığında kazanacaksın.',
        ),
        Achievement(
          imageAsset: 'assets/kizil_gezegen_fatihi.png',
          title: 'Kızıl Gezegen Fatihi',
          description: '3. bölümü tamamladığında kazanacaksın.',
        ),
        Achievement(
          imageAsset: 'assets/algoritma_ustasi.png',
          title: 'Algoritma Ustası',
          description: '4. bölümü tamamladığında kazanacaksın.',
        ),
        Achievement(
          imageAsset: 'assets/manyetik_alan_ustasi.png',
          title: 'Manyetik Alan Ustası',
          description: '5. bölümü tamamladığında kazanacaksın.',
        ),
        Achievement(
          imageAsset: 'assets/sistem_analisti.png',
          title: 'Sistem Analisti',
          description: '6. bölümü tamamladığında kazanacaksın.',
        ),
        Achievement(
          imageAsset: 'assets/galaksi_kaşifi.png',
          title: 'Galaksi Kaşifi',
          description: '7. bölümü tamamladığında kazanacaksın.',
        ),
      ];
}
