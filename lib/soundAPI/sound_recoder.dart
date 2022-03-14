// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:flutter_sound_lite/flutter_sound.dart';

const pathTosave = 'suman';

class Soundrecoder {
  FlutterSoundRecorder? _soundRecorder;
  // ignore: unused_field
  bool _isRecordedInitialised = false;
  bool get isRecording => _soundRecorder!.isRecording;

  Future init() async {
    _soundRecorder = FlutterSoundRecorder();
    // ignore: unused_local_variable
    PermissionStatus? permission =
        await window.navigator.permissions?.query({'name': 'microphone'});
    await _soundRecorder!.openAudioSession();
    _isRecordedInitialised = true;
  }

  void dispose() {
    _soundRecorder!.closeAudioSession();
    _soundRecorder = null;
    _isRecordedInitialised = false;
  }

  Future _recoder() async {
    await _soundRecorder!.startRecorder(toFile: pathTosave);
  }

  Future _stop() async {
    await _soundRecorder!.stopRecorder();
  }

  Future toggleRecoding() async {
    if (_soundRecorder!.isStopped) {
      await _recoder();
    } else {
      await _stop();
    }
  }
}
