import 'package:bootcamp_team_83_flutter/ui/views/form/pathway_form_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PathwayFormView extends StackedView<PathwayFormViewModel> {
  const PathwayFormView({super.key});

  @override
  Widget builder(BuildContext context, PathwayFormViewModel viewModel, Widget? child) {
    final _pathwayFormKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Create Pathway')),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _pathwayFormKey,
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
              TextFormField(
                controller: viewModel.titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: viewModel.itemController,
                decoration: const InputDecoration(labelText: 'Number of Items'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: viewModel.imageUrlController,
                decoration: const InputDecoration(labelText: 'Background Image URL'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_pathwayFormKey.currentState?.validate() ?? false) {
                    await viewModel.createPathway();
                    Navigator.pop(context);
                  }
                },
                child: const Text('Create Pathway'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  PathwayFormViewModel viewModelBuilder(BuildContext context) => PathwayFormViewModel();
}
