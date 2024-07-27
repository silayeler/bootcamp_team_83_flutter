import 'package:bootcamp_team_83_flutter/ui/common/ui_helpers.dart';
import 'package:bootcamp_team_83_flutter/ui/views/chapter/chapter_view.dart';
import 'package:bootcamp_team_83_flutter/ui/views/forms/chapter_form_view.dart';
import 'package:bootcamp_team_83_flutter/ui/views/forms/pathway_form_view.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/account/account_screen.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/home_viewmodel.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/profile/profile_photo_view.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/success/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:bootcamp_team_83_flutter/ui/common/app_colors.dart';

class HomeView extends StackedView<HomeViewModel> {
  final bool isGuestLogin;

  const HomeView({Key? key, required this.isGuestLogin}) : super(key: key);

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
                      const ProfilePhotoView(),
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
                    MaterialPageRoute(builder: (context) => const AccountScreen()),
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
                    MaterialPageRoute(builder: (context) =>  SuccessScreen()),
                  );
                },
              ),
              buildCustomListTile(
                color: drawerContainerColor,
                icon: Icons.task_alt_sharp,
                text: 'Bölüm Formu',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChapterFormView()),
                  );
                },
              ),
              buildCustomListTile(
                color: drawerContainerColor,
                icon: Icons.task,
                text: 'Görev Yolu Formu',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PathWayFormView(sectionId: "sectionId")),
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
        body: const Center(
          child: ChapterView(userId: 'userId',),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    if (isGuestLogin) {
      viewModel.loginAsGuest();
    } else {
      viewModel.fetchUserName();
    }
  }

  Widget buildCustomListTile(
      {required Color color,
        required IconData icon,
        required String text,
        required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        leading: Icon(icon, color: drawerTextColor),
        title: Text(text, style: const TextStyle(color: drawerTextColor)),
        onTap: onTap,
      ),
    );
  }
}
