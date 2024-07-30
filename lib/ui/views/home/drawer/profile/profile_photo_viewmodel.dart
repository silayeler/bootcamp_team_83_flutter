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

  bool _isGuestLogin = false;
  bool get isGuestLogin => _isGuestLogin;

  Future<void> initialize() async {
    setBusy(true);
    _isGuestLogin = await _userService.isGuestLogin();
    if (!_isGuestLogin) {
      await fetchUserProfileImage();
    }
    setBusy(false);
  }

  Future<void> fetchUserProfileImage() async {
    if (_isGuestLogin) return;
    _profileImageUrl = await _userService.getUserProfileImageUrl();
    rebuildUi();
  }

  Future<void> pickAndUploadImage() async {
    if (_isGuestLogin) return;

    final pickedFile =
    await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      String downloadUrl = await _uploadImageToFirebase(imageFile);

      await _userService.updateUserProfileImageUrl(downloadUrl);

      _profileImageUrl = downloadUrl;
      notifyListeners();
    }
  }

  Future<void> removeProfileImage() async {
    if (_isGuestLogin) return;

    String userId = FirebaseAuth.instance.currentUser!.uid;
    Reference storageReference =
    FirebaseStorage.instance.ref().child("profile_images/$userId");

    await storageReference.delete();
    await _userService.updateUserProfileImageUrl("");

    _profileImageUrl = "";
    notifyListeners();
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