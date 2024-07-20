import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountScreenViewModel {
  late String name;
  late String surname;
  late String email;

  late TextEditingController nameController;
  late TextEditingController surnameController;
  late TextEditingController emailController;

  bool isEditingName = false;
  bool isEditingSurname = false;
  bool isEditingEmail = false;

  AccountScreenViewModel() {
    // Varsayılan değerler
    name = 'İsim';
    surname = 'Soyisim';
    email = 'isimsoyisim@gmail.com';

    nameController = TextEditingController(text: name);
    surnameController = TextEditingController(text: surname);
    emailController = TextEditingController(text: email);

    // Firebase'den kullanıcı bilgilerini yükle
    _loadUserData();
  }

  void _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      email = user.email ?? 'isimsoyisim@gmail.com';
      emailController.text = email;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        name = data['name'] ?? 'İsim';
        surname = data['surname'] ?? 'Soyisim';

        nameController.text = name;
        surnameController.text = surname;
      }
    }
  }

  void editFeedback(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Görüş/Öneri'),
          content: TextField(
            controller: _controller,
            decoration:
                const InputDecoration(hintText: "Görüş veya önerinizi yazınız"),
            maxLines: 4,
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Save action
                Navigator.of(context).pop();
              },
              child: const Text('Gönder'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD7DADD),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('İptal'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD7DADD),
              ),
            ),
          ],
        );
      },
    );
  }
}
