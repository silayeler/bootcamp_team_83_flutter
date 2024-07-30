import 'package:bootcamp_team_83_flutter/ui/views/form/question_form_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class QuestionFormView extends StackedView<QuestionFormViewModel> {
  const QuestionFormView({super.key});

  @override
  Widget builder(BuildContext context, QuestionFormViewModel viewModel, Widget? child) {
    final _questionFormKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Create Question')),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _questionFormKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                hint: const Text('Select Section'),
                value: viewModel.selectedSectionId,
                items: viewModel.sectionItems,
                onChanged: (value) {
                  viewModel.setSelectedSectionId(value!);
                },
                validator: (value) => value == null ? 'Section is required' : null,
              ),
              DropdownButtonFormField<String>(
                hint: const Text('Select Pathway'),
                value: viewModel.selectedPathwayId,
                items: viewModel.pathwayItems,
                onChanged: (value) {
                  viewModel.setSelectedPathwayId(value!);
                },
                validator: (value) => value == null ? 'Pathway is required' : null,
              ),
              DropdownButtonFormField<String>(
                hint: const Text('Select Item'),
                value: viewModel.selectedItemId,
                items: viewModel.itemItems,
                onChanged: (value) {
                  viewModel.setSelectedItemId(value!);
                },
                validator: (value) => value == null ? 'Item is required' : null,
              ),
              TextFormField(
                controller: viewModel.questionController,
                decoration: const InputDecoration(labelText: 'Question'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a question';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: viewModel.optionAController,
                decoration: const InputDecoration(labelText: 'Option A'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter option A';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: viewModel.optionBController,
                decoration: const InputDecoration(labelText: 'Option B'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter option B';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: viewModel.optionCController,
                decoration: const InputDecoration(labelText: 'Option C'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter option C';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: viewModel.optionDController,
                decoration: const InputDecoration(labelText: 'Option D'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter option D';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: viewModel.answerController,
                decoration: const InputDecoration(labelText: 'Answer'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the answer';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_questionFormKey.currentState?.validate() ?? false) {
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
    );
  }

  @override
  QuestionFormViewModel viewModelBuilder(BuildContext context) => QuestionFormViewModel();
}
