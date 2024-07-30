import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'profile_photo_viewmodel.dart';

class ProfilePhotoView extends StackedView<ProfilePhotoViewModel> {
  const ProfilePhotoView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context,
      ProfilePhotoViewModel viewModel,
      Widget? child,
      ) {
    if (viewModel.isGuestLogin) {
      return CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey[300],
        child: Icon(Icons.person, size: 40, color: Colors.grey[600]),
      );
    }

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return Container(
              // ... (mevcut modal sheet içeriği)
            );
          },
        );
      },
      child: CircleAvatar(
        radius: 40,
        backgroundImage: viewModel.profileImageUrl.isNotEmpty
            ? AssetImage(viewModel.profileImageUrl)
            : null,
        child: viewModel.profileImageUrl.isEmpty
            ? const Icon(Icons.add_a_photo, size: 40, color: Colors.grey)
            : null,
      ),
    );
  }

  @override
  ProfilePhotoViewModel viewModelBuilder(BuildContext context) =>
      ProfilePhotoViewModel();

  @override
  void onViewModelReady(ProfilePhotoViewModel viewModel) {
    viewModel.initialize();
    super.onViewModelReady(viewModel);
  }

// ... (diğer metodlar aynı kalır)
}