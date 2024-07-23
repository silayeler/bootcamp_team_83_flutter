import 'dart:io';

import 'package:bootcamp_team_83_flutter/app/app.locator.dart';
import 'package:bootcamp_team_83_flutter/app/app.router.dart';
import 'package:bootcamp_team_83_flutter/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _firestoreService = locator<FirestoreService>();
  final _imagePicker = ImagePicker();

  String _userName = "";
  String get userName => _userName;

  String _profileImageUrl = "";
  String get profileImageUrl => _profileImageUrl;

  Future<void> fetchUserName() async {
    setBusy(true);
    _userName = await _firestoreService.getUserNameSurname();
    _profileImageUrl = await _firestoreService.getUserProfileImageUrl();
    setBusy(false);
    rebuildUi();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    _navigationService.replaceWithLoginView();
  }

  Future<void> pickAndUploadImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      // Resmi Firebase Storage'a yükle
      String downloadUrl = await _uploadImageToFirebase(imageFile);

      // Firestore'da kullanıcı profil resmi URL'sini güncelle
      await _firestoreService.updateUserProfileImageUrl(downloadUrl);

      // Görüntüyü ViewModel'de güncelle
      _profileImageUrl = downloadUrl;
      rebuildUi();
    }
  }

  Future<void> removeProfileImage() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    Reference storageReference =
        FirebaseStorage.instance.ref().child("profile_images/$userId");

    await storageReference.delete();
    await _firestoreService.updateUserProfileImageUrl("");

    _profileImageUrl = "";
    rebuildUi();
  }

  Future<String> _uploadImageToFirebase(File imageFile) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    Reference storageReference =
        FirebaseStorage.instance.ref().child("profile_images/$userId");
    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }
}
