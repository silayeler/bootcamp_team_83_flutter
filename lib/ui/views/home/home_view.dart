import 'package:bootcamp_team_83_flutter/ui/common/ui_helpers.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/account/account_screen.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/success/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'home_viewmodel.dart';
import 'package:bootcamp_team_83_flutter/ui/common/app_colors.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: acikMavi,
        appBar: AppBar(
          backgroundColor: acikMavi,
        ),
        endDrawer: Drawer(
          width: screenWidth(context) / 1.75,
          backgroundColor: acikMavi,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DrawerHeader(
                  decoration: const BoxDecoration(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return Container(
                                width:
                                    double.infinity, // Ekran genişliğini kapla
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.white, // Arka planı beyaz yap
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16)),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
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
                        },
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: viewModel.profileImageUrl.isNotEmpty
                              ? NetworkImage(viewModel.profileImageUrl)
                              : null,
                          child: viewModel.profileImageUrl.isEmpty
                              ? const Icon(Icons.add_a_photo,
                                  size: 40, color: Colors.grey)
                              : null,
                        ),
                      ),
                      viewModel.isBusy
                          ? const CircularProgressIndicator()
                          : Text(
                              viewModel.userName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: drawerTextColor,
                                fontSize: 24,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              buildCustomListTile(
                color: drawerContainerColor,
                icon: Icons.home,
                text: 'Hesabım',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccountScreen()),
                  );
                },
              ),
              buildCustomListTile(
                color: drawerContainerColor,
                icon: Icons.area_chart_sharp,
                text: 'Başarılar',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SuccessScreen()),
                  );
                },
              ),
              buildCustomListTile(
                color: Colors.lightGreen,
                icon: Icons.logout,
                text: 'Çıkış Yap',
                onTap: () {
                  viewModel.signOut();
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              viewModel.signOut();
            },
            child: const Text("Sign Out"),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.fetchUserName();
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
      label: Text(label, style: TextStyle(color: drawerTextColor)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent, // Butonun arka planı saydam
        foregroundColor: drawerTextColor, // Buton üzerindeki metin rengi
        elevation: 0, // Gölgeyi kaldır
        padding: EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.transparent), // Kenarlık
        ),
      ),
    );
  }

  Widget buildCustomListTile({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: ListTile(
          leading: Icon(icon, color: drawerIconColor),
          title: Text(text,
              style: const TextStyle(
                  color: drawerTextColor, fontWeight: FontWeight.bold)),
          onTap: onTap,
        ),
      ),
    );
  }
}
