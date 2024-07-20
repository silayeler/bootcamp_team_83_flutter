import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'story_viewmodel.dart';

class StoryView extends StackedView<StoryViewModel> {
  const StoryView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StoryViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Uygulamanın hikayesi burada...sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: viewModel.onStorySeen,
              child: const Text("Tamam"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  StoryViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StoryViewModel();
}
