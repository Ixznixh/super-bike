import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.windows:
        return windows;
      default:
        return web;
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDemoKeySuperBike4a70e',
    appId: '1:917039183488:web:superbikeapp',
    messagingSenderId: '917039183488',
    projectId: 'super-bike-4a70e',
    authDomain: 'super-bike-4a70e.firebaseapp.com',
    storageBucket: 'super-bike-4a70e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDemoKeySuperBike4a70e',
    appId: '1:917039183488:android:superbikeapp',
    messagingSenderId: '917039183488',
    projectId: 'super-bike-4a70e',
    storageBucket: 'super-bike-4a70e.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDemoKeySuperBike4a70e',
    appId: '1:917039183488:windows:superbikeapp',
    messagingSenderId: '917039183488',
    projectId: 'super-bike-4a70e',
    authDomain: 'super-bike-4a70e.firebaseapp.com',
    storageBucket: 'super-bike-4a70e.appspot.com',
  );
}
