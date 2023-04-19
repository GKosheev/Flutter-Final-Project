import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBhpqPB_54j5NtMDlv6TTdviPTBCuyWvQI",
            authDomain: "tinder-test-app-bcc65.firebaseapp.com",
            projectId: "tinder-test-app-bcc65",
            storageBucket: "tinder-test-app-bcc65.appspot.com",
            messagingSenderId: "449813023017",
            appId: "1:449813023017:web:6036b27e81e2924e600f38",
            measurementId: "G-NLDYDKR5XF"));
  } else {
    await Firebase.initializeApp();
  }
}
