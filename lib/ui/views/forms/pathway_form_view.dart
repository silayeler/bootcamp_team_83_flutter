import 'package:bootcamp_team_83_flutter/ui/views/forms/pathway_form_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PathWayFormView extends StackedView<PathWayFormViewmodel> {
  final String sectionId;

  const PathWayFormView({super.key, required this.sectionId});

  @override
  Widget builder(BuildContext context, PathWayFormViewmodel viewModel, Widget? child) {
    final _formKey = GlobalKey<FormState>();
    String starNumber = '';
    String content = '';

    return Scaffold(
      appBar: AppBar(title: const Text('Create Star Page')),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Star Number'),
              onChanged: (value) {
                starNumber = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a star number';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Content'),
              onChanged: (value) {
                content = value;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  await viewModel.createStarPage(sectionId, starNumber, content);
                  Navigator.pop(context);
                }
              },
              child: const Text('Create Star Page'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  PathWayFormViewmodel viewModelBuilder(BuildContext context) => PathWayFormViewmodel();
}
