import 'package:bloc_clean_architecture/features/auth/presentation/pages/auth_page.dart';
import 'package:bloc_clean_architecture/features/auth/presentation/pages/login_page.dart';
import 'package:bloc_clean_architecture/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'themes/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}
