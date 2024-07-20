import 'package:bootcamp_team_83_flutter/ui/common/ui_helpers.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/account/account_screen.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/account/success_screen.dart';
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
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        endDrawer: Drawer(
          width: screenWidth(context)/1.75,
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
                      const CircleAvatar(),
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
          title: Text(text, style: const TextStyle(color: drawerTextColor,fontWeight: FontWeight.bold)),
          onTap: onTap,
        ),
      ),
    );
  }
}
