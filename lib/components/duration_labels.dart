import 'package:flutter/material.dart';
import 'package:flutter_audio_client/notifiers/playlist_notifier.dart';
import 'package:provider/provider.dart';

class DurationLabels extends StatelessWidget {
  const DurationLabels({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistNotifier>(builder: (context, value, child) {
      return Text("${value.currentFormatted()} - ${value.maxFormatted()}    ");
    });
  }
}
