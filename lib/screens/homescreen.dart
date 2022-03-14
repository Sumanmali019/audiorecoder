import 'package:audiorecoed/firebaseAuth/login_service.dart';
import 'package:audiorecoed/soundAPI/sound_player.dart';
import 'package:audiorecoed/soundAPI/sound_recoder.dart';
import 'package:audiorecoed/soundAPI/upload_api.dart';
import 'package:audiorecoed/theme/colors.dart';
import 'package:audiorecoed/widgets/timer_widget.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    Key? key,
  }) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final timeController = TimeController();
  final recorder = Soundrecoder();
  final player = SoundPlayer();
  // final upload = Recodedbutton(
  //   onUploadComplete: () {},
  // );
  List<Reference> references = [];

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
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Welcome'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                Authentication().signOut();
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      backgroundColor: veryDarkBlue,
      body: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              buildPlayer(),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildstate(),
                  const SizedBox(
                    width: 18,
                  ),
                  buildPlay(),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              buildUpload(),
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
    final primary = isPlaying ? Colors.red : Colors.white;
    final onPrimary = isPlaying ? Colors.white : Colors.black;

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(195, 50),
        primary: primary,
        onPrimary: onPrimary,
      ),
      icon: Icon(icon),
      label: Text(text),
      onPressed: () async {
        await player.togglePlayer(whenFinished: () => setState(() {}));
        setState(() {});
      },
    );
  }

  Widget buildUpload() {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(195, 50),
          primary: Colors.green,
        ),
        onPressed: () {},
        icon: const Icon(Icons.upload_file),
        label: const Text('upload'));
  }

  Future<void> _onUploadComplete() async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    ListResult listResult =
        await firebaseStorage.ref().child('upload-voice-firebase').list();
    setState(() {
      references = listResult.items;
    });
  }
}
