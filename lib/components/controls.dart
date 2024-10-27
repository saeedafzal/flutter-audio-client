import 'package:flutter/material.dart';
import 'package:flutter_audio_client/notifiers/playlist_notifier.dart';
import 'package:provider/provider.dart';

class Controls extends StatelessWidget {
  const Controls({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistNotifier>(builder: (context, value, child) {
      return Row(children: [
        IconButton(
          onPressed: value.index != -1 ? value.prev : null,
          icon: const Icon(Icons.skip_previous_rounded),
        ),
        IconButton(
          onPressed: value.index != -1 ? value.player.playOrPause : null,
          icon: Icon(
              value.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded),
        ),
        IconButton(
          onPressed: value.index != -1 ? value.next : null,
          icon: const Icon(Icons.skip_next_rounded),
        )
      ]);
    });
  }
}
