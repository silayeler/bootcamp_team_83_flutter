import 'package:bootcamp_team_83_flutter/ui/views/pathway/pathway_viewmodel.dart';
import 'package:bootcamp_team_83_flutter/ui/views/question/question_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PathwayView extends StackedView<PathwayViewModel> {
  final String sectionId;
  final String userId;

  const PathwayView({super.key, required this.sectionId, required this.userId});

  @override
  Widget builder(
      BuildContext context, PathwayViewModel viewModel, Widget? child) {
    final List<Offset> starPositions = [
      Offset(MediaQuery.of(context).size.width / 2 + 20,
          MediaQuery.of(context).size.height - 200),
      Offset(MediaQuery.of(context).size.width / 2 + 100,
          MediaQuery.of(context).size.height - 280),
      Offset(MediaQuery.of(context).size.width / 2 + 110,
          MediaQuery.of(context).size.height - 400),
      Offset(MediaQuery.of(context).size.width / 2 + 5,
          MediaQuery.of(context).size.height - 380),
      Offset(MediaQuery.of(context).size.width / 2 - 120,
          MediaQuery.of(context).size.height - 340),
      Offset(MediaQuery.of(context).size.width / 2 - 210,
          MediaQuery.of(context).size.height - 440),
      Offset(MediaQuery.of(context).size.width / 2 - 100,
          MediaQuery.of(context).size.height - 550),
      Offset(MediaQuery.of(context).size.width / 2 + 10,
          MediaQuery.of(context).size.height - 600),
      Offset(MediaQuery.of(context).size.width / 2 + 50,
          MediaQuery.of(context).size.height - 750),
      Offset(MediaQuery.of(context).size.width / 2 - 150,
          MediaQuery.of(context).size.height - 850),
    ];

    return Scaffold(
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('sections')
                  .doc(sectionId)
                  .collection('pathways')
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                      child: Text('Veri yüklenemedi: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('Bölüm bulunamadı'));
                }

                var pathwayDocs = snapshot.data!.docs;
                var pathwayData =
                    pathwayDocs.first.data() as Map<String, dynamic>;
                var numberOfStars = pathwayData['numberOfStars'] ?? 0;
                var backgroundUrl = pathwayData['backgroundUrl'] ?? '';
                var itemImageUrl = pathwayData['itemImageUrl'] ?? '';

                return Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(backgroundUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: List.generate(numberOfStars, (index) {
                          var pathwayDocId =
                              pathwayDocs.first.id; // pathway doc id
                          return _buildStar(
                            context,
                            pathwayDocId,
                            index + 1,
                            itemImageUrl,
                            starPositions[index],
                            index ==
                                numberOfStars -
                                    1,
                          );
                        }),
                      ),
                    ),
                    Positioned(
                      top: 30,
                      left: 10,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_sharp,
                            color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }

  Widget _buildStar(BuildContext context, String pathwayId, int itemNumber,
      String itemImageUrl, Offset position, bool isLastStar) {
    double starSize =
        isLastStar ? 150 : 100; // Make the last star 1.5 times bigger

    return Positioned(
      top: position.dy,
      left: position.dx,
      child: GestureDetector(
        onTap: () async {
          var itemsSnapshot = await FirebaseFirestore.instance
              .collection('sections')
              .doc(sectionId)
              .collection('pathways')
              .doc(pathwayId)
              .collection('items')
              .get();

          var itemDoc = itemsSnapshot.docs.firstWhere(
              (doc) => doc['title'] == 'Star $itemNumber',
              orElse: () => throw Exception('Item not found'));

          var starSnapshot = await FirebaseFirestore.instance
              .collection('sections')
              .doc(sectionId)
              .collection('pathways')
              .doc(pathwayId)
              .collection('items')
              .doc(itemDoc.id)
              .collection('questions')
              .orderBy('questionIndex')
              .get();

          if (starSnapshot.docs.isNotEmpty) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => QuestionView(
                questions: starSnapshot.docs.map((doc) => doc.data()).toList(),
              ),
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Bu yıldız için soru bulunamadı')),
            );
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(itemImageUrl, width: starSize, height: starSize),
            Text(
              '$itemNumber',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  PathwayViewModel viewModelBuilder(BuildContext context) => PathwayViewModel();
}
