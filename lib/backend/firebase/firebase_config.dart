import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCFt4gFDGK_-hxEW4SivoTRVtSHZEryY_k",
            authDomain: "profi-66d4a.firebaseapp.com",
            projectId: "profi-66d4a",
            storageBucket: "profi-66d4a.firebasestorage.app",
            messagingSenderId: "67678883808",
            appId: "1:67678883808:web:8fe73f198f1cfd00976585"));
  } else {
    await Firebase.initializeApp();
  }
}
