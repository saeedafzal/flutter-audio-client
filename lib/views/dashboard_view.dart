import 'package:flutter/material.dart';
import 'package:flutter_audio_client/views/dashboard_model.dart';
import 'package:media_kit/media_kit.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final player = Player();
  final dashboardModel = DashboardModel();

  @override
  void initState() {
    super.initState();
    dashboardModel.init(player, setState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () => setState(dashboardModel.loadMusicDirectory),
            child: const Text("Load Music Directory"),
          )
        ],
      ),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            itemCount: dashboardModel.mediaList.length,
            itemBuilder: (_, index) {
              final media = dashboardModel.mediaList[index];
              final filename = media.uri.split("/").last;
              return ListTile(
                title: Text(filename),
                selected: dashboardModel.selectedIndex == index,
                onTap: () {
                  dashboardModel.loadAndPlay(index, player);
                  setState(() => dashboardModel.selectedIndex = index);
                },
              );
            },
          ),
        ),
        Row(children: [
          IconButton(
            onPressed: dashboardModel.selectedIndex != -1
                ? () => dashboardModel.playOrPause(player)
                : null,
            icon: Icon(dashboardModel.isPlaying
                ? Icons.pause_rounded
                : Icons.play_arrow_rounded),
          ),
          Expanded(
            child: Slider(
              value: dashboardModel.current,
              max: dashboardModel.max,
              onChanged: (value) {},
            ),
          ),
        ])
      ]),
    );
  }

  @override
  void dispose() {
    for (final element in dashboardModel.subscriptions) {
      element.cancel();
    }
    player.dispose();
    super.dispose();
  }
}
