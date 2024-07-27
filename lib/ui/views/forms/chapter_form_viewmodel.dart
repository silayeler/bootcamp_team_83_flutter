import 'package:bootcamp_team_83_flutter/services/chapter_service.dart';
import 'package:stacked/stacked.dart';

class ChapterFormViewmodel extends BaseViewModel {
  final ChapterService _chapterService = ChapterService();

  Future<void> createSection(String title, String description, String imageUrl) async {
    setBusy(true);

    try {
      await _chapterService.createSection({
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
      });
    } catch (e) {
      print('Error creating section: $e');
    } finally {
      setBusy(false);
    }
  }
}
