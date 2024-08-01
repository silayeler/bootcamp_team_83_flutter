import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'profile_photo_viewmodel.dart';
import 'package:bootcamp_team_83_flutter/ui/common/app_colors.dart';

class ProfilePhotoView extends StackedView<ProfilePhotoViewModel> {
  const ProfilePhotoView({Key? key, required String photoUrl})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ProfilePhotoViewModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTap: () {
        if (viewModel.isGuest) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: drawerContainerColor,
                title: const Text(
                  'Uyarı',
                  style: TextStyle(
                    color: drawerTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: const Text(
                  'Profil resminizi değiştirmek için lütfen giriş yapınız.',
                  style: TextStyle(color: drawerTextColor),
                ),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: const Text(
                          'Giriş Yap',
                          style: TextStyle(color: drawerTextColor),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          // Burada login sayfasına yönlendirme kodunu ekleyin
                          Navigator.pushNamed(context, '/login-view'); // Örnek
                        },
                      ),
                      TextButton(
                        child: const Text(
                          'Tamam',
                          style: TextStyle(color: drawerTextColor),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        } else {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Profil Resmini Yönet',
                      style: TextStyle(
                          color: drawerTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    _buildTransparentButton(
                      onPressed: () {
                        viewModel.pickAndUploadImage();
                        Navigator.of(context).pop();
                      },
                      icon: Icons.edit,
                      label: 'Profil Resmini Değiştir',
                    ),
                    const SizedBox(height: 10),
                    _buildTransparentButton(
                      onPressed: () {
                        viewModel.removeProfileImage();
                        Navigator.of(context).pop();
                      },
                      icon: Icons.delete,
                      label: 'Profil Resmini Kaldır',
                    ),
                    const SizedBox(height: 10),
                    _buildTransparentButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icons.cancel,
                      label: 'İptal',
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
      child: CircleAvatar(
        radius: 40,
        backgroundImage: viewModel.profileImageUrl.isNotEmpty
            ? NetworkImage(viewModel.profileImageUrl)
            : const AssetImage('assets/guest_pp.png') as ImageProvider,
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
    viewModel.fetchUserProfileImage();
    super.onViewModelReady(viewModel);
  }

  Widget _buildTransparentButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: drawerTextColor),
      label: Text(label, style: const TextStyle(color: drawerTextColor)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: drawerTextColor,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}
