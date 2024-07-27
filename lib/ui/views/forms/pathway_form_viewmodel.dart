import 'package:bootcamp_team_83_flutter/services/chapter_service.dart';
import 'package:stacked/stacked.dart';

class PathWayFormViewmodel extends BaseViewModel {
  final ChapterService _chapterService = ChapterService();

  Future<void> createStarPage(String sectionId, String starNumber, String content) async {
    setBusy(true);

    try {
      await _chapterService.createStarPage(sectionId, {
        'starNumber': starNumber,
        'content': content,
      });
    } catch (e) {
      print('Error creating star page: $e');
    } finally {
      setBusy(false);
    }
  }
}
