import 'package:bootcamp_team_83_flutter/ui/common/app_colors.dart';
import 'package:bootcamp_team_83_flutter/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'notice_sheet_model.dart';

class NoticeSheet extends StackedView<NoticeSheetModel> {
  final Function(SheetResponse)? completer;
  final SheetRequest request;

  const NoticeSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
      BuildContext context,
      NoticeSheetModel viewModel,
      Widget? child,
      ) {

    bool isCorrect = request.data?["isCorrect"] ?? false;

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                request.title!,
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
              ),
              verticalSpaceTiny,
              Text(
                request.description!,
                style: const TextStyle(fontSize: 14, color: kcMediumGrey),
                textAlign: TextAlign.center,
                maxLines: 3,
                softWrap: true,
              ),
              verticalSpaceSmall,
              viewModel.isBusy
              ? const CircularProgressIndicator()
              : TextButton(
                onPressed: () async {
                  if (viewModel.questions.isNotEmpty && viewModel.currentQuestionIndex < viewModel.questions.length) {
                    await viewModel.askAI();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Geçerli bir soru bulunamadı.')),
                    );
                  }
                },
                child: const Text("Yapay zekaya sor!", style: TextStyle(color: Colors.blue)),
              ),
              ElevatedButton(
                onPressed: () => completer?.call(SheetResponse(confirmed: true)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCorrect ? Colors.green : Colors.red,
                ),
                child: Text(request.mainButtonTitle ?? 'Tamam', style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  NoticeSheetModel viewModelBuilder(BuildContext context) => NoticeSheetModel(
    questions: request.data?["questions"] ?? [],
    currentQuestionIndex: request.data?["currentQuestionIndex"] ?? 0,
  );
}
