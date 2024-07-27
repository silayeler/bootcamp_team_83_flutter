import 'package:bootcamp_team_83_flutter/ui/views/forms/chapter_form_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChapterFormView extends StackedView<ChapterFormViewmodel> {
  const ChapterFormView({super.key});

  @override
  Widget builder(BuildContext context, ChapterFormViewmodel viewModel, Widget? child) {
    final _formKey = GlobalKey<FormState>();
    String title = '';
    String description = '';
    String imageUrl = '';

    return Scaffold(
      appBar: AppBar(title: const Text('Create Section')),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              onChanged: (value) {
                title = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              onChanged: (value) {
                description = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Image URL'),
              onChanged: (value) {
                imageUrl = value;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  await viewModel.createSection(title, description, imageUrl);
                  Navigator.pop(context);
                }
              },
              child: const Text('Create Section'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  ChapterFormViewmodel viewModelBuilder(BuildContext context) => ChapterFormViewmodel();
}
