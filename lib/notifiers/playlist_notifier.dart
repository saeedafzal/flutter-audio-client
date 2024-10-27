import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:media_kit/media_kit.dart';

class PlaylistNotifier extends ChangeNotifier {
  late Player player;

  // State
  Playlist playlist = const Playlist([]);
  int index = -1;
  bool isPlaying = false;
  double max = 0;
  double current = 0;

  void loadMusicDirectory() {
    final directory = Directory("${Platform.environment["HOME"]}/Music");
    if (directory.existsSync()) {
      playlist = Playlist(
        directory.listSync().map((e) => Media(e.path)).toList(),
      );
      player.open(playlist, play: false);
      notifyListeners();
    }
  }

  void playIndex(int index) {
    this.index = index;
    player.jump(index);
    player.play();
    notifyListeners();
  }

  void playing(bool event) {
    isPlaying = event;
    notifyListeners();
  }

  void next() {
    player.next();
    index++;
    if (index == playlist.medias.length) {
      index = 0;
    }
    notifyListeners();
  }

  void prev() {
    player.previous();
    index--;
    if (index == -1) {
      index = playlist.medias.length - 1;
    }
    notifyListeners();
  }

  void setMax(Duration event) {
    max = event.inMilliseconds.toDouble();
    notifyListeners();
  }

  void setCurrent(Duration event) {
    current = event.inMilliseconds.toDouble();
    if (max >= current) {
      notifyListeners();
    }
  }

  void seek(double millis) {
    Duration duration = Duration(milliseconds: millis.toInt());
    player.seek(duration);
  }

  void onAudioComplete(bool event) {
    if (!event) return;
    index++;
    if (index == playlist.medias.length) {
      index = 0;
    }
    notifyListeners();
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
