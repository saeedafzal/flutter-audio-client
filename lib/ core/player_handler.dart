import 'dart:async';

import 'package:flutter_audio_client/notifiers/playlist_notifier.dart';
import 'package:media_kit/media_kit.dart';

class PlayerHandler {
  List<StreamSubscription> subscriptions = [];

  final Player player;
  final PlaylistNotifier notifier;

  PlayerHandler({required this.player, required this.notifier});

  void subscribeToEvents() {
    subscriptions.addAll([
      player.stream.playing.listen(notifier.playing),
      player.stream.duration.listen(notifier.setMax),
      player.stream.position.listen(notifier.setCurrent),
      player.stream.completed.listen(notifier.onAudioComplete),
    ]);
  }

  void cancelSubscriptions() {
    for (final sub in subscriptions) {
      sub.cancel();
    }
  }
}
