// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCCRwl0vmPqTyYZuB1PR7tutFpPxi3GgOI',
    appId: '1:131601801894:android:75e43a99954018c4054a67',
    messagingSenderId: '131601801894',
    projectId: 'yummy-delivery-app',
    storageBucket: 'yummy-delivery-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAZCQFPWhne_WUpcM64s059zGsM9DuOGfY',
    appId: '1:131601801894:ios:8074ba266c2f2a77054a67',
    messagingSenderId: '131601801894',
    projectId: 'yummy-delivery-app',
    storageBucket: 'yummy-delivery-app.appspot.com',
    iosClientId: '131601801894-4o3hk8ag0seqkt51qpvhuov81ugaf4rk.apps.googleusercontent.com',
    iosBundleId: 'com.kevr.foodapp',
  );
}
