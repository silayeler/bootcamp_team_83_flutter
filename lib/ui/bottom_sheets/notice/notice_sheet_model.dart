import 'package:bootcamp_team_83_flutter/app/app.dialogs.dart';
import 'package:bootcamp_team_83_flutter/app/app.locator.dart';
import 'package:bootcamp_team_83_flutter/services/ai_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NoticeSheetModel extends BaseViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final AIService _aiService = locator<AIService>(); // AIService'i ekledik
  final List<Map<String, dynamic>> questions;
  final int currentQuestionIndex;

  NoticeSheetModel({
    required this.questions,
    required this.currentQuestionIndex,
  });

  Future<void> askAI() async {
    setBusy(true);
    var currentQuestion = questions[currentQuestionIndex];
    var response =
        await _aiService.askAI(currentQuestion); // AIService'i kullanıyoruz

    if (response != null) {
      await _dialogService.showCustomDialog(
        variant: DialogType.infoAlert,
        title: "AI Yanıtı",
        description: response,
      );
    } else {
      await _dialogService.showCustomDialog(
        variant: DialogType.infoAlert,
        title: "Hata",
        description: "AI yanıtı alınamadı.",
      );
    }
    setBusy(false);
  }
}
