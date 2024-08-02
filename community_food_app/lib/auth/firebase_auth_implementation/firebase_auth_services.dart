import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_food_app/toast.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:package_info/package_info.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'The email address is already in use');
      } else {
        showToast(message: 'An erroe  occured: ${e.code}');
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Invalid email or password');
      } else {
        showToast(message: 'An error  occured: ${e.code}');
      }
    }
    return null;
  }
}

class UserHelper {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future saveShelterUser(User user, String name) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);
    Map<String, dynamic> userData = {
      "name": name,
      "email": user.email,
      "last_login": user.metadata.lastSignInTime!.millisecondsSinceEpoch,
      "created_at": user.metadata.creationTime!.millisecondsSinceEpoch,
      "role": "Shelter",
      "build_number": buildNumber,
    };

    final userRef = _db.collection("users").doc(user.uid);
    if ((await userRef.get()).exists) {
      await userRef.update({
        "last_login": user.metadata.lastSignInTime!.millisecondsSinceEpoch,
        "build_number": buildNumber,
      });
    } else {
      await userRef.set(userData);
    }
    await _saveDevice(user);
  }

  Future saveRestaurantUser(User user, String name) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);
    Map<String, dynamic> userData = {
      "name": name,
      "email": user.email,
      "last_login": user.metadata.lastSignInTime!.millisecondsSinceEpoch,
      "created_at": user.metadata.creationTime!.millisecondsSinceEpoch,
      "role": "Restaurant",
      "build_number": buildNumber,
    };

    final userRef = _db.collection("users").doc(user.uid);
    if ((await userRef.get()).exists) {
      await userRef.update({
        "last_login": user.metadata.lastSignInTime!.millisecondsSinceEpoch,
        "build_number": buildNumber,
      });
    } else {
      await userRef.set(userData);
    }
    await _saveDevice(user);
    await createRestaurantCollection(user, name);

  }

  Future _saveDevice(User user) async {
    DeviceInfoPlugin devicePlugin = DeviceInfoPlugin();
    String? deviceId;
    Map<String, dynamic> deviceData = {};

    if (Platform.isAndroid) {
      final deviceInfo = await devicePlugin.androidInfo;
      deviceId = deviceInfo.androidId;
      deviceData = {
        "os_version": deviceInfo.version.sdkInt.toString(),
        "platform": "android",
        "model": deviceInfo.model,
        "device": deviceInfo.device,
      };
    }
    if (Platform.isIOS) {
      final deviceInfo = await devicePlugin.iosInfo;
      deviceId = deviceInfo.identifierForVendor;
      deviceData = {
        "os_version": deviceInfo.systemVersion,
        "platform": "ios",
        "model": deviceInfo.model,
        "device": deviceInfo.name,
      };
    }
    final nowMs = DateTime.now().millisecondsSinceEpoch;

    final deviceRef = _db
        .collection("users")
        .doc(user.uid)
        .collection("devices")
        .doc(deviceId);
    if ((await deviceRef.get()).exists) {
      await deviceRef.update({
        "updated_at":nowMs,
        "uninstalled":false,
      });
    } else {
      await deviceRef.set({
        "created_at":nowMs,
        "updated_at":nowMs,
        "uninstalled":false,
        "id":deviceId,
        "device_info":deviceData,
    });
    }
  }

  Future<void> createRestaurantCollection(User user, name) async {
    final restaurantRef = _db.collection('restaurants').doc(user.uid);

    await restaurantRef.set({
      'name': name,
      'email': user.email,
      'role': 'Restaurant',
    });

    // Create an empty meals subcollection
    // ignore: unused_local_variable
    final mealsCollectionRef = restaurantRef.collection('meals');
    // The subcollection 'meals' will be empty initially
  }

}
