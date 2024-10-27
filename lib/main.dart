import 'package:flutter/material.dart';
import 'package:flutter_audio_client/notifiers/playlist_notifier.dart';
import 'package:flutter_audio_client/views/dashboard_view.dart';
import 'package:media_kit/media_kit.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();

  runApp(provider());
}

MultiProvider provider() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PlaylistNotifier()),
    ],
    child: const FlutterAudioClient(),
  );
}

class FlutterAudioClient extends StatelessWidget {
  const FlutterAudioClient({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Audio Client",
      theme: ThemeData.dark(useMaterial3: true),
      home: const DashboardView(),
    );
  }
}
