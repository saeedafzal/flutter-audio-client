import 'package:flutter/material.dart';
import 'package:flutter_audio_client/%20core/player_handler.dart';
import 'package:flutter_audio_client/components/controls.dart';
import 'package:flutter_audio_client/components/duration_labels.dart';
import 'package:flutter_audio_client/components/seeker.dart';
import 'package:flutter_audio_client/notifiers/playlist_notifier.dart';
import 'package:flutter_audio_client/views/playlist_view.dart';
import 'package:media_kit/media_kit.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late final PlayerHandler playerHandler;
  late final Player player;

  @override
  void initState() {
    super.initState();

    final playlistNotifier = context.read<PlaylistNotifier>();

    player = Player();
    player.setPlaylistMode(PlaylistMode.loop);
    playlistNotifier.player = player;

    playerHandler = PlayerHandler(
      player: player,
      notifier: playlistNotifier,
    );

    playerHandler.subscribeToEvents();
  }

  @override
  Widget build(BuildContext context) {
    var playlistNotifier = context.read<PlaylistNotifier>();

    return Scaffold(
      appBar: AppBar(actions: [
        ElevatedButton(
          onPressed: playlistNotifier.loadMusicDirectory,
          child: const Text("Load Music Directory"),
        )
      ]),
      body: const Column(children: [
        Expanded(child: PlaylistView()),
        Row(children: [
          Controls(),
          Expanded(child: Seeker()),
          DurationLabels(),
        ])
      ]),
    );
  }

  @override
  void dispose() {
    playerHandler.cancelSubscriptions();
    player.dispose();
    super.dispose();
  }
}
