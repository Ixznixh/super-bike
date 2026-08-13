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
    apiKey: 'AIzaSyCv5iVWmxxI4sEaXeb0_o7PZraLmFGkR7U',
    appId: '1:917039183488:web:d8c768808f539b47e65865',
    messagingSenderId: '917039183488',
    projectId: 'super-bike-4a70e',
    authDomain: 'super-bike-4a70e.firebaseapp.com',
    storageBucket: 'super-bike-4a70e.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCv5iVWmxxI4sEaXeb0_o7PZraLmFGkR7U',
    appId: '1:917039183488:android:superbikeapp',
    messagingSenderId: '917039183488',
    projectId: 'super-bike-4a70e',
    storageBucket: 'super-bike-4a70e.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCv5iVWmxxI4sEaXeb0_o7PZraLmFGkR7U',
    appId: '1:917039183488:web:d8c768808f539b47e65865',
    messagingSenderId: '917039183488',
    projectId: 'super-bike-4a70e',
    authDomain: 'super-bike-4a70e.firebaseapp.com',
    storageBucket: 'super-bike-4a70e.firebasestorage.app',
  );
}
