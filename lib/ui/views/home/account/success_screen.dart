import 'package:bootcamp_team_83_flutter/ui/views/home/account/success_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:bootcamp_team_83_flutter/ui/common/app_colors.dart';

class SuccessScreen extends StatelessWidget {
  final SuccessScreenViewModel viewModel = SuccessScreenViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Başarılarım', style: TextStyle(color: drawerTextColor)),
        backgroundColor: acikMavi,
        elevation: 0,
      ),
      body: Container(
        color: acikMavi, // Arka plan rengi
        child: ListView.builder(
          itemCount: viewModel.achievements.length,
          itemBuilder: (context, index) {
            final achievement = viewModel.achievements[index];
            return AchievementCard(achievement: achievement);
          },
        ),
      ),
    );
  }
}

class AchievementCard extends StatelessWidget {
  final Achievement achievement;

  const AchievementCard({Key? key, required this.achievement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: Colors.white, // Kartın arka plan rengi
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: Image.asset(
          achievement.imageAsset,
          width: 50, // Resmin genişliği
          height: 50, // Resmin yüksekliği
          fit: BoxFit.cover, // Resmi kutuya uyacak şekilde ölçeklendir
        ),
        title: Text(
          achievement.title,
          style: TextStyle(fontWeight: FontWeight.bold, color: drawerTextColor),
        ),
        subtitle: Text(
          achievement.description,
          style: TextStyle(color: drawerTextColor),
        ),
      ),
    );
  }
}
