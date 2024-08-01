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
                  hint:  const Text('Write Question Index (0 ile 2 arasında)'),
                  value: viewModel.selectedQuestionIndex,
                  items: viewModel.questionIndexItem,
                  onChanged: (value) => viewModel.setSelectedQuestionIndex(value!),
                  validator: (value) => value == null ? 'Index is required' : null,
                ),
                DropdownButtonFormField<String>(
                  hint: const Text('Select Question Type'),
                  value: viewModel.selectedQuestionType,
                  items: const [
                    DropdownMenuItem(value: 'multiple_choice', child: Text('Multiple Choice')),
                    DropdownMenuItem(value: 'fill_in_blank', child: Text('Fill in the Blank')),
                    DropdownMenuItem(value: 'coding', child: Text('Coding')),
                  ],
                  onChanged: (value) => viewModel.setSelectedQuestionType(value!),
                  validator: (value) => value == null ? 'Question type is required' : null,
                ),

                if (viewModel.selectedQuestionType == 'multiple_choice') ...[
                  TextFormField(
                    controller: viewModel.questionController,
                    decoration: const InputDecoration(labelText: 'Question'),
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter a question' : null,
                  ),
                  TextFormField(
                    controller: viewModel.optionAController,
                    decoration: const InputDecoration(labelText: 'Option A'),
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter option A' : null,
                  ),
                  TextFormField(
                    controller: viewModel.optionBController,
                    decoration: const InputDecoration(labelText: 'Option B'),
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter option B' : null,
                  ),
                  TextFormField(
                    controller: viewModel.optionCController,
                    decoration: const InputDecoration(labelText: 'Option C'),
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter option C' : null,
                  ),
                  TextFormField(
                    controller: viewModel.optionDController,
                    decoration: const InputDecoration(labelText: 'Option D'),
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter option D' : null,
                  ),
                  TextFormField(
                    controller: viewModel.answerController,
                    decoration: const InputDecoration(labelText: 'Answer'),
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter the answer' : null,
                  ),
                ] else  if (viewModel.selectedQuestionType == 'fill_in_blank') ...[
                  TextFormField(
                    controller: viewModel.questionController,
                    decoration: const InputDecoration(labelText: 'Question (Use ___ for blanks)'),
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter a question' : null,
                  ),
                  const SizedBox(height: 10),
                  const Text('Options (one per line):'),
                  TextFormField(
                    controller: viewModel.fillInBlankOptionsController,
                    decoration: const InputDecoration(hintText: 'Enter options, one per line'),
                    maxLines: 4,
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter options' : null,
                  ),
                  const SizedBox(height: 10),
                  const Text('Correct Answers (in order, one per line):'),
                  TextFormField(
                    controller: viewModel.fillInBlankAnswersController,
                    decoration: const InputDecoration(hintText: 'Enter correct answers, one per line'),
                    maxLines: 4,
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter correct answers' : null,
                  ),
                ] else if (viewModel.selectedQuestionType == 'coding') ...[
                  TextFormField(
                    controller: viewModel.initialCodeController,
                    decoration: const InputDecoration(labelText: 'Initial Code'),
                    maxLines: 5,
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter the initial code' : null,
                  ),
                  const SizedBox(height: 10),
                  const Text('Expected Output:'),
                  TextFormField(
                    controller: viewModel.expectedOutputController,
                    decoration: const InputDecoration(labelText: 'Expected Output'),
                    maxLines: 3,
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter the expected output' : null,
                  ),
                ],
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (questionFormKey.currentState?.validate() ?? false) {
                      await viewModel.createQuestion();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Create Question'),
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