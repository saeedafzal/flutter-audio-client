import 'package:flutter/material.dart';
import 'package:flutter_audio_client/notifiers/playlist_notifier.dart';
import 'package:provider/provider.dart';

class Seeker extends StatelessWidget {
  const Seeker({super.key});

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: const SliderThemeData(
        showValueIndicator: ShowValueIndicator.onlyForContinuous,
      ),
      child: Consumer<PlaylistNotifier>(builder: (context, value, child) {
        return Slider(
          max: value.max,
          value: value.current,
          label: value.currentFormatted(),
          onChanged: value.index != -1 ? value.seek : null,
        );
      }),
    );
  }
}
