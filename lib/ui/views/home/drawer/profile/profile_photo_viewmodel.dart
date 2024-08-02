import 'dart:io';
import 'package:bootcamp_team_83_flutter/app/app.locator.dart';
import 'package:bootcamp_team_83_flutter/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

class ProfilePhotoViewModel extends BaseViewModel {
  final _userService = locator<UserService>();
  final _imagePicker = ImagePicker();

  String _profileImageUrl = "";
  String get profileImageUrl => _profileImageUrl;

  bool get isGuest => FirebaseAuth.instance.currentUser?.isAnonymous ?? false;

  Future<void> fetchUserProfileImage() async {
    setBusy(true);
    try {
      if (FirebaseAuth.instance.currentUser != null && !isGuest) {
        _profileImageUrl = await _userService.getUserProfileImageUrl() ?? '';
      } else {
        _profileImageUrl =
            'https://firebasestorage.googleapis.com/v0/b/bootcamp-760bf.appspot.com/o/profile_images%2Fguest_pp.png?alt=media&token=206dc128-8257-4346-b75a-70d80373a68b'; // Misafir için varsayılan fotoğraf
      }
    } catch (e) {
      print('Hata: $e');
      _profileImageUrl =
          'https://firebasestorage.googleapis.com/v0/b/bootcamp-760bf.appspot.com/o/profile_images%2Fguest_pp.png?alt=media&token=206dc128-8257-4346-b75a-70d80373a68b'; // Hata durumunda varsayılan fotoğraf
    } finally {
      setBusy(false);
      rebuildUi();
    }
  }

  Future<void> pickAndUploadImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      try {
        setBusy(true);
        String fileName =
            'profile_pictures/${FirebaseAuth.instance.currentUser!.uid}.png';
        Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
        await storageRef.putFile(imageFile);
        String downloadUrl = await storageRef.getDownloadURL();
        await _userService.updateUserProfileImageUrl(downloadUrl);
        _profileImageUrl = downloadUrl;
      } catch (e) {
        print('Hata: $e');
      } finally {
        setBusy(false);
        rebuildUi();
      }
    }
  }

  Future<void> removeProfileImage() async {
    try {
      setBusy(true);
      String fileName =
          'profile_pictures/${FirebaseAuth.instance.currentUser!.uid}.png';
      Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
      await storageRef.delete();
      await _userService.updateUserProfileImageUrl('');
      _profileImageUrl = 'assets/guest_pp.png'; // Varsayılan fotoğraf
    } catch (e) {
      print('Hata: $e');
    } finally {
      setBusy(false);
      rebuildUi();
    }
  }
}
