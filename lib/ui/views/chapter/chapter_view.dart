import 'package:bootcamp_team_83_flutter/ui/common/app_colors.dart';
import 'package:bootcamp_team_83_flutter/ui/views/chapter/chapter_viewmodel.dart';
import 'package:bootcamp_team_83_flutter/ui/views/pathway/pathway_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChapterView extends StackedView<ChapterViewModel> {
  final String userId;

  const ChapterView({super.key, required this.userId});

  @override
  Widget builder(
      BuildContext context, ChapterViewModel viewModel, Widget? child) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('sections').get(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Veri yüklenemedi: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Hiç bölüm yok'));
        }

        var sections = snapshot.data!.docs;

        return ListView.builder(
          itemCount: sections.length,
          itemBuilder: (context, index) {
            var section = sections[index];
            var sectionId = section.id;
            return FutureBuilder(
              future: viewModel.isSectionCompleted(userId, sectionId),
              builder: (context, AsyncSnapshot<bool> completedSnapshot) {
                if (completedSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (completedSnapshot.hasError) {
                  return Center(
                      child: Text('Hata: ${completedSnapshot.error}'));
                }
                bool isCompleted = completedSnapshot.data ?? false;
                bool isFirstSection = index == 0;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: isCompleted || isFirstSection
                        ? () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PathwayView(
                                  sectionId: sectionId, userId: userId),
                            ));
                          }
                        : null,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 175,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(section['imageUrl']),
                              fit: BoxFit.cover,
                              colorFilter: isCompleted || isFirstSection
                                  ? null
                                  : ColorFilter.mode(
                                      Colors.white.withOpacity(0.7),
                                      BlendMode.luminosity),
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),

                        Positioned(
                          bottom: 10,
                          child: Column(
                            children: [
                              if (!isCompleted && !isFirstSection)
                                Icon(Icons.lock,
                                    color: Colors.grey.shade700, size: 50),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: chapterTextContainerColor,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 8),
                                  child: Text(
                                    section['title'],
                                    style: const TextStyle(
                                      color: chapterTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: chapterTextContainerColor,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 8),
                                  child: Text(
                                    section['description'],
                                    style: const TextStyle(
                                      color: chapterTextColor,
                                      fontSize: 16,

                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  ChapterViewModel viewModelBuilder(BuildContext context) {
    return ChapterViewModel();
  }
}
