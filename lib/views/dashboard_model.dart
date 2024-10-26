import 'dart:async';
import 'dart:io';

import 'package:media_kit/media_kit.dart';

class DashboardModel {
  List<Media> mediaList = [];
  int selectedIndex = -1;
  bool isPlaying = false;

  // Seek
  double current = 0;
  double max = 0;

  List<StreamSubscription> subscriptions = [];

  void init(Player player, Function setState) {
    subscriptions.add(player.stream.playing
        .listen((event) => setState(() => isPlaying = event)));

    subscriptions.add(player.stream.completed.listen((event) {
      if (event) {
        int newIndex = selectedIndex + 1;
        if (newIndex >= mediaList.length) {
          newIndex = 0;
        }

        setState(() => selectedIndex = newIndex);
        loadAndPlay(newIndex, player);
      }
    }));

    subscriptions.add(player.stream.position.listen((event) {
      double value = event.inMilliseconds.toDouble();
      if (event != Duration.zero && max >= value) {
        setState(() => current = value);
      }
    }));

    subscriptions.add(player.stream.duration.listen((event) {
      if (event != Duration.zero) {
        setState(() => max = event.inMilliseconds.toDouble());
      }
    }));
  }

  void loadMusicDirectory() {
    final directory = Directory("${Platform.environment["HOME"]!}/Music");
    if (directory.existsSync()) {
      mediaList = directory.listSync().map((e) => Media(e.path)).toList();
    }
  }

  void loadAndPlay(int index, Player player) {
    final media = mediaList[index];
    player.open(media);
  }

  void playOrPause(Player player) {
    player.playOrPause();
  }

  void seek(Player player, double value) {
    player.seek(Duration(milliseconds: value.toInt()));
  }

  String currentFormatted() =>
      _formatDuration(Duration(milliseconds: current.toInt()));

  String maxFormatted() => _formatDuration(Duration(milliseconds: max.toInt()));

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return duration.inHours > 0
        ? "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds"
        : "$twoDigitMinutes:$twoDigitSeconds";
  }
}
