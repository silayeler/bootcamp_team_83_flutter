import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AIService {
  Future<String?> askAI(Map<String, dynamic> questionData) async {
    return await _geminiAI(questionData);
  }

  Future<String?> _geminiAI(Map<String, dynamic> questionData) async {
    String? apiKey = dotenv.env['Google_Gemini_Api_Key'];
    if (apiKey == null) {
      print('No API_KEY environment variable');
      return null;
    }

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(maxOutputTokens: 1000),
    );

    String questionWithOptions = questionData['question'] + "\n";
    for (var option in ['optionA', 'optionB', 'optionC', 'optionD']) {
      questionWithOptions += "$option: ${questionData[option]}\n";
    }
    questionWithOptions += "Doğru cevap: ${questionData['answer']}";


    final chat = model.startChat(history: [
      Content.text(
          "Sen bir eğitim asistanısın. Sana bir soru ve cevap seçenekleri vereceğim. "
          "Lütfen soruyu analiz et, doğru cevabı açıkla ve öğrenciye yardımcı olabilecek ipuçları ver. En fazla 2 cümle ile neden cevabın o olduğunu açıkla."),
      Content.model(
          [TextPart("Anladım. Soruyu ve cevapları bana verebilirsiniz.")]),
    ]);

    try {
      var content = Content.text(questionWithOptions);
      var response = await chat.sendMessage(content);
      return response.text;
    } catch (e) {
      print("AI isteği sırasında bir hata oluştu: $e");
      return "Üzgünüm, şu anda AI yanıtı alınamıyor.";
    }
  }
}
