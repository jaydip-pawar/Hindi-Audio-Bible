import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioProvider extends ChangeNotifier{

  Duration totalDuration = Duration(hours: 0, minutes: 0, seconds: 0);
  Duration position = Duration(hours: 0, minutes: 0, seconds: 0);
  String audioState = "";
  String song_url = "";
  bool isPlaying = false;
  bool isPaused = false;
  int playingIndex = -1;

  AudioProvider(){
    initAudio();
  }

  setUrl(String url) {
    this.song_url = url;
    notifyListeners();
  }

  String getUrl() {
    return this.song_url;
  }

  AudioPlayer audioPlayer = AudioPlayer();

  initAudio(){
    audioPlayer.onDurationChanged.listen((updatedDuration) {
      totalDuration = updatedDuration;
      notifyListeners();
    });

    audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
      position = updatedPosition;
      // if (position == totalDuration)
      //   audioState = "Stopped";
      notifyListeners();
    });

    audioPlayer.onPlayerCompletion.listen((event) {
      audioState = "Stopped";
      playingIndex = 0;
      stopAudio();
      seekAudio(Duration(milliseconds: 0));
      notifyListeners();
    });

    audioPlayer.onPlayerStateChanged.listen((playerState) {
      if(playerState == PlayerState.STOPPED)
        audioState = "Stopped";
      if(playerState==PlayerState.PLAYING)
        audioState = "Playing";
      if(playerState == PlayerState.PAUSED)
        audioState = "Paused";
      notifyListeners();
    });
  }

  playAudio(){
    // print("1" + song_url);
    audioPlayer.play(song_url);
    notifyListeners();
  }

  playNext(String url) {
    audioPlayer.play(url);
    notifyListeners();
  }

  pauseAudio(){
    audioPlayer.pause();
    notifyListeners();
  }

  stopAudio(){
    audioPlayer.stop();
    notifyListeners();
  }

  seekAudio(Duration durationToSeek){
    audioPlayer.seek(durationToSeek);
  }

}