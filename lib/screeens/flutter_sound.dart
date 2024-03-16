import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioRecorder extends StatefulWidget {
  @override
  _AudioRecorderState createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  late FlutterSoundPlayer _player;
  late FlutterSoundRecorder _recorder;

  @override
  void initState() {
    super.initState();
    _player = FlutterSoundPlayer();
    _recorder = FlutterSoundRecorder();
  }

  Future<void> startRecording() async {
   // await checkPermission();
    await _recorder.startRecorder(
      toFile: 'audio',
    );
  }

  Future<void> stopRecording() async {
    await _recorder.stopRecorder();
  }

  @override
  void dispose() {
    _player.closePlayer();
    _recorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Recorder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: startRecording,
              child: Text('Start Recording'),
            ),
            ElevatedButton(
              onPressed: stopRecording,

              child: Text('Stop Recording'),
            ),
          ],
        ),
      ),
    );
  }
}
