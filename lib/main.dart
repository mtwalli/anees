import 'package:flutter/material.dart';
import 'package:quran_library/quran_library.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await QuranLibrary.init();
  QuranLibrary.initWordAudio();
  runApp(const AneesApp());
}
