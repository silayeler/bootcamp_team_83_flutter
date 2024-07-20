import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bootcamp_team_83_flutter/ui/common/app_colors.dart';
import 'package:bootcamp_team_83_flutter/ui/views/home/account/account_screen_viewmodel.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late AccountScreenViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = AccountScreenViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: acikMavi, // Arka plan rengi
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Hesabım',
                style: TextStyle(
                  color: drawerTextColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              AccountItem(
                controller: viewModel.nameController,
                isEditing: viewModel.isEditingName,
                onEdit: () {
                  setState(() {
                    viewModel.isEditingName = !viewModel.isEditingName;
                    if (!viewModel.isEditingName) {
                      viewModel.name = viewModel.nameController.text;
                    }
                  });
                },
              ),
              const SizedBox(height: 10),
              AccountItem(
                controller: viewModel.surnameController,
                isEditing: viewModel.isEditingSurname,
                onEdit: () {
                  setState(() {
                    viewModel.isEditingSurname = !viewModel.isEditingSurname;
                    if (!viewModel.isEditingSurname) {
                      viewModel.surname = viewModel.surnameController.text;
                    }
                  });
                },
              ),
              const SizedBox(height: 10),
              AccountItem(
                controller: viewModel.emailController,
                isEditing: viewModel.isEditingEmail,
                onEdit: () {
                  setState(() {
                    viewModel.isEditingEmail = !viewModel.isEditingEmail;
                    if (!viewModel.isEditingEmail) {
                      viewModel.email = viewModel.emailController.text;
                    }
                  });
                },
              ),
              const SizedBox(height: 30), // Daha fazla boşluk bırakıldı
              ElevatedButton(
                onPressed: () {
                  _showChangePasswordDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: drawerContainerColor.withOpacity(0.85),
                  textStyle: TextStyle(color: drawerTextColor),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Şifremi Güncelle',
                  style: TextStyle(
                    color: drawerTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _showFeedbackDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: drawerContainerColor.withOpacity(0.85),
                  textStyle: TextStyle(color: drawerTextColor),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Görüş/Öneri',
                  style: TextStyle(
                    color: drawerTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: drawerContainerColor.withOpacity(0.85),
          title: const Text('Şifre Güncelle',
              style: TextStyle(color: drawerTextColor)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: oldPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Eski Şifre',
                  hintStyle: TextStyle(color: drawerTextColor),
                ),
              ),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Yeni Şifre',
                  hintStyle: TextStyle(color: drawerTextColor),
                ),
              ),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Yeni Şifre (Tekrar)',
                  hintStyle: TextStyle(color: drawerTextColor),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final oldPassword = oldPasswordController.text;
                final newPassword = newPasswordController.text;
                final confirmPassword = confirmPasswordController.text;

                if (newPassword == confirmPassword) {
                  User? user = FirebaseAuth.instance.currentUser;

                  if (user != null) {
                    final cred = EmailAuthProvider.credential(
                        email: user.email!, password: oldPassword);

                    try {
                      await user.reauthenticateWithCredential(cred);
                      await user.updatePassword(newPassword);
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Şifre başarıyla güncellendi!'),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Eski şifre yanlış!'),
                        ),
                      );
                    }
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Yeni şifreler eşleşmiyor!'),
                    ),
                  );
                }
              },
              child: const Text('Güncelle'),
              style: ElevatedButton.styleFrom(
                backgroundColor: drawerContainerColor,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('İptal'),
              style: ElevatedButton.styleFrom(
                backgroundColor: drawerContainerColor,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    final feedbackController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: drawerContainerColor.withOpacity(0.85),
          title: const Text('Görüş/Öneri',
              style: TextStyle(color: drawerTextColor)),
          content: TextField(
            controller: feedbackController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Görüş ve önerilerinizi buraya yazın...',
              hintStyle: TextStyle(color: drawerTextColor),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                final feedback = feedbackController.text;
                if (feedback.isNotEmpty) {
                  // Görüş/öneri gönderme işlemini burada yapın
                  Navigator.of(context).pop();
                } else {
                  // Hata mesajı göster
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Görüş veya öneri girilmedi!'),
                    ),
                  );
                }
              },
              child: const Text('Gönder'),
              style: ElevatedButton.styleFrom(
                backgroundColor: drawerContainerColor,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('İptal'),
              style: ElevatedButton.styleFrom(
                backgroundColor: drawerContainerColor,
              ),
            ),
          ],
        );
      },
    );
  }
}

class AccountItem extends StatelessWidget {
  final TextEditingController controller;
  final bool isEditing;
  final Function onEdit;

  const AccountItem({
    Key? key,
    required this.controller,
    required this.isEditing,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onEdit(),
      style: ElevatedButton.styleFrom(
        backgroundColor: drawerContainerColor.withOpacity(0.85),
        textStyle: TextStyle(color: drawerTextColor),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
              decoration: null,
              style: const TextStyle(
                color: drawerTextColor,
                fontSize: 18,
              ),
              readOnly: !isEditing,
            ),
          ),
          const Icon(Icons.edit, color: drawerTextColor),
        ],
      ),
    );
  }
}
