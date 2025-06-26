import 'package:auto_fin/core/services/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> firebaseConfigs() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
