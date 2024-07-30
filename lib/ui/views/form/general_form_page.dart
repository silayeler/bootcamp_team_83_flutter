import 'package:bootcamp_team_83_flutter/ui/views/form/chapter_form_view.dart';
import 'package:bootcamp_team_83_flutter/ui/views/form/pathway_form_view.dart';
import 'package:bootcamp_team_83_flutter/ui/views/form/question_form_view.dart';
import 'package:flutter/material.dart';

class GeneralFormPage extends StatelessWidget {
  const GeneralFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChapterFormView()),
                  );
                },
                child: Text("Bölüm Ekle")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PathwayFormView()),
                  );
                },
                child: Text("Görev Yolu Ekle")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QuestionFormView(),
                    ),
                  );
                },
                child: Text("Soru Ekle")),
          ],
        ),
      ),
    );
  }
}
