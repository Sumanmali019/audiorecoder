import 'package:audiorecoed/soundAPI/sound_player.dart';
import 'package:audiorecoed/soundAPI/sound_recoder.dart';
import 'package:audiorecoed/theme/colors.dart';
import 'package:audiorecoed/widgets/timer_widget.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class Buildstate extends StatefulWidget {
  const Buildstate({Key? key}) : super(key: key);

  @override
  State<Buildstate> createState() => _BuildstateState();
}

class _BuildstateState extends State<Buildstate> {
  final timeController = TimeController();
  final recorder = Soundrecoder();
  final player = SoundPlayer();

  @override
  void initState() {
    super.initState();
    recorder.init();
    player.init();
  }

  @override
  void dispose() {
    recorder.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: veryDarkBlue,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildPlayer(),
          const SizedBox(
            height: 18,
          ),
          buildstate(),
          const SizedBox(
            height: 10,
          ),
          buildPlay(),
        ],
      )),
    );
  }

  Widget buildstate() {
    {
      final isRecoding = recorder.isRecording;
      final text = isRecoding ? 'STOP' : 'START';
      final icon = isRecoding ? Icons.stop : Icons.mic;
      final primary = isRecoding ? Colors.red : Colors.white;
      final onPrimary = isRecoding ? Colors.white : Colors.black;

      return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(195, 50),
          primary: primary,
          onPrimary: onPrimary,
        ),
        icon: Icon(icon),
        label: Text(text),
        onPressed: () async {
          await recorder.toggleRecoding();
          final isRecoding = recorder.isRecording;
          setState(() {});
          if (isRecoding) {
            timeController.startTimer();
          } else {
            timeController.stopTimer();
          }
        },
      );
    }
  }

  Widget buildPlayer() {
    final text = recorder.isRecording ? 'Now Recording' : 'Press Start';
    final animation = recorder.isRecording;
    return AvatarGlow(
      endRadius: 140,
      animate: animation,
      repeatPauseDuration: const Duration(microseconds: 1),
      child: CircleAvatar(
        radius: 100,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 92,
          backgroundColor: Colors.indigo.shade900.withBlue(70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.mic, size: 32),
              TimeWidget(
                controller: timeController,
              ),
              const SizedBox(height: 8),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPlay() {
    final isPlaying = player.isPlaying;
    final icon = isPlaying ? Icons.stop : Icons.play_arrow;
    final text = isPlaying ? 'Stop Player' : 'Play Recording';

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(195, 50),
        primary: Colors.white,
        onPrimary: Colors.black,
      ),
      icon: Icon(icon),
      label: Text(text),
      onPressed: () async {
        await player.togglePlayer(whenFinished: () => setState(() {}));
        setState(() {});
      },
    );
  }
}
