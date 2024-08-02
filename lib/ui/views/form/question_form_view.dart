import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'question_form_viewmodel.dart';

class QuestionFormView extends StackedView<QuestionFormViewModel> {
  const QuestionFormView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, QuestionFormViewModel viewModel, Widget? child) {
    final questionFormKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Create Question')),
      body: SingleChildScrollView(
        child: viewModel.isBusy
            ? const Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: questionFormKey,
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  hint: const Text('Select Section'),
                  value: viewModel.selectedSectionId,
                  items: viewModel.sectionItems,
                  onChanged: (value) => viewModel.setSelectedSectionId(value!),
                  validator: (value) => value == null ? 'Section is required' : null,
                ),
                DropdownButtonFormField<String>(
                  hint: const Text('Select Pathway'),
                  value: viewModel.selectedPathwayId,
                  items: viewModel.pathwayItems,
                  onChanged: (value) => viewModel.setSelectedPathwayId(value!),
                  validator: (value) => value == null ? 'Pathway is required' : null,
                ),
                DropdownButtonFormField<String>(
                  hint: const Text('Select Item'),
                  value: viewModel.selectedItemId,
                  items: viewModel.itemItems,
                  onChanged: (value) => viewModel.setSelectedItemId(value!),
                  validator: (value) => value == null ? 'Item is required' : null,
                ),
                DropdownButtonFormField<int>(
                  isExpanded: true,
                  hint:  const Text('Soru indexini seç (0 ile 2 arasında)'),
                  value: viewModel.selectedQuestionIndex,
                  items: viewModel.questionIndexItem,
                  onChanged: (value) => viewModel.setSelectedQuestionIndex(value!),
                  validator: (value) => value == null ? 'Index is required' : null,
                ),
                DropdownButtonFormField<String>(
                  hint: const Text('Soru Tipini Seç'),
                  value: viewModel.selectedQuestionType,
                  items: const [
                    DropdownMenuItem(value: 'multiple_choice', child: Text('Şıklı')),
                    DropdownMenuItem(value: 'fill_in_blank', child: Text('Boşluk Doldurmalı')),
                    DropdownMenuItem(value: 'coding', child: Text('kodlama')),
                  ],
                  onChanged: (value) => viewModel.setSelectedQuestionType(value!),
                  validator: (value) => value == null ? 'Soru tipi seçmek zorunlu' : null,
                ),


                //Çok Şıklı
                if (viewModel.selectedQuestionType == 'multiple_choice') ...[
                  TextFormField(
                    controller: viewModel.questionController,
                    decoration: const InputDecoration(labelText: 'Soru'),
                    validator: (value) => value?.isEmpty ?? true ? 'Bir soru giriniz' : null,
                  ),
                  TextFormField(
                    controller: viewModel.optionAController,
                    decoration: const InputDecoration(labelText: 'A şıkkı'),
                    validator: (value) => value?.isEmpty ?? true ? 'A şıkkını giriniz' : null,
                  ),
                  TextFormField(
                    controller: viewModel.optionBController,
                    decoration: const InputDecoration(labelText: 'B şıkkı'),
                    validator: (value) => value?.isEmpty ?? true ? 'B şıkkını giriniz' : null,
                  ),
                  TextFormField(
                    controller: viewModel.optionCController,
                    decoration: const InputDecoration(labelText: 'C şıkkı'),
                    validator: (value) => value?.isEmpty ?? true ? 'C şıkkını giriniz' : null,
                  ),
                  TextFormField(
                    controller: viewModel.optionDController,
                    decoration: const InputDecoration(labelText: 'D şıkkı'),
                    validator: (value) => value?.isEmpty ?? true ? 'D şıkkını giriniz' : null,
                  ),
                  TextFormField(
                    controller: viewModel.answerController,
                    decoration: const InputDecoration(labelText: 'Cevap'),
                    validator: (value) => value?.isEmpty ?? true ? 'Cevabı giriniz' : null,
                  ),

                  // Boşluk Doldurma
                ] else  if (viewModel.selectedQuestionType == 'fill_in_blank') ...[
                  TextFormField(
                    controller: viewModel.questionController,
                    decoration: const InputDecoration(labelText: 'Soru (boşluklar için ___ kullanın)'),
                    validator: (value) => value?.isEmpty ?? true ? 'Lütfen soruyu giriniz' : null,
                  ),
                  const SizedBox(height: 10),
                  const Text('Şıklar (satır başı):'),
                  TextFormField(
                    controller: viewModel.fillInBlankOptionsController,
                    decoration: const InputDecoration(hintText: 'Şıkları her satır başına girin'),
                    maxLines: 4,
                    validator: (value) => value?.isEmpty ?? true ? 'lütfen şıkları giriniz' : null,
                  ),
                  const SizedBox(height: 10),
                  const Text('Her satır başına doğru cevabı giriniz:'),
                  TextFormField(
                    controller: viewModel.fillInBlankAnswersController,
                    decoration: const InputDecoration(hintText: 'her satır başına doğru cevabı giriniz'),
                    maxLines: 4,
                    validator: (value) => value?.isEmpty ?? true ? 'Lütfen doğru cevabı giriniz' : null,
                  ),

                  // Kodlama
                ] else if (viewModel.selectedQuestionType == 'coding') ...[
                  TextFormField(
                    controller: viewModel.questionController,
                    decoration: const InputDecoration(labelText: 'Soru '),
                    validator: (value) => value?.isEmpty ?? true ? 'Lütfen soruyu giriniz' : null,
                  ),
                  TextFormField(
                    controller: viewModel.initialCodeController,
                    decoration: const InputDecoration(labelText: 'Başlangıç Kodu'),
                    maxLines: 5,
                    validator: (value) => value?.isEmpty ?? true ? 'Lütfen başlangıç kodunu yazınız' : null,
                  ),
                  const SizedBox(height: 10),
                  const Text('Çıktı:'),
                  TextFormField(
                    controller: viewModel.expectedOutputController,
                    decoration: const InputDecoration(labelText: 'Beklenen Çıktı'),
                    maxLines: 3,
                    validator: (value) => value?.isEmpty ?? true ? 'Lütfen beklenen çıktıyı yazınız' : null,
                  ),
                ],
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                  onPressed: () async {
                    if (questionFormKey.currentState?.validate() ?? false) {
                      await viewModel.createQuestion();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Soru Oluştur',style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  QuestionFormViewModel viewModelBuilder(BuildContext context) => QuestionFormViewModel();
}