import 'package:flutter/material.dart';
import 'package:flutter_audio_client/views/dashboard_view.dart';
import 'package:media_kit/media_kit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  runApp(const FlutterAudioClient());
}

class FlutterAudioClient extends StatelessWidget {
  const FlutterAudioClient({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Audio Client",
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.dark,
      home: const DashboardView(),
    );
  }
}