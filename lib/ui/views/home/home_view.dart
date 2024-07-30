import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:bootcamp_team_83_flutter/ui/common/ui_helpers.dart';
import 'package:bootcamp_team_83_flutter/ui/views/chapter/chapter_view.dart';
import 'package:bootcamp_team_83_flutter/ui/views/form/general_form_page.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/drawer/account/account_screen.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/drawer/profile/profile_photo_view.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/drawer/success/success_screen.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/home_viewmodel.dart';
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
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            color: Colors.grey,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const GeneralFormPage()),
              );
            },
            icon: const Icon(Icons.add_box_outlined),
          ),
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                          child: ProfilePhotoView(
                        photoUrl: '',
                      )),
                      Flexible(
                        child: viewModel.isBusy
                            ? const CircularProgressIndicator()
                            : Text(
                                viewModel.userName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: drawerTextColor,
                                  fontSize: 24,
                                ),
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
                    MaterialPageRoute(
                        builder: (context) => const AccountScreen()),
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
        body: Container(
          width: screenWidth(context),
          height: screenHeight(context),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/anasayfa_arkaplan.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: ChapterView(
            userId: viewModel.userId ?? "",
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.initialize();
  }

  Widget buildCustomListTile({
    required Color color,
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: ListTile(
        leading: Icon(icon, color: drawerTextColor),
        title: Text(text, style: const TextStyle(color: drawerTextColor)),
        onTap: onTap,
      ),
    );
  }
}
