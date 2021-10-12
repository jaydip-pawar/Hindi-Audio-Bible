import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AudioProvider extends ChangeNotifier{

  Duration totalDuration = Duration(hours: 0, minutes: 0, seconds: 0);
  Duration position = Duration(hours: 0, minutes: 0, seconds: 0);
  String audioState = "";
  String song_url = "";
  String songName = "";
  bool isPlaying = false;
  bool isPaused = false;
  bool isRepeat = false;
  bool isShuffle = false;
  int playingIndex = -1;
  late AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  AudioProvider(){
    initAudio();
  }

  setShuffle() {
    this.isShuffle = !this.isShuffle;
    notifyListeners();
  }

  setRepeat() {
    this.isRepeat = !this.isRepeat;
    notifyListeners();
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
      if(isRepeat) {
        stopAudio();
        playAudio();
        notifyListeners();
      } else if(isShuffle) {
        if (snapshot.data!.size != playingIndex + 1) {
          stopAudio();
          isPlaying = true;
          playingIndex = playingIndex + 1;
          isPaused = false;
          songName = snapshot.data!.docs[playingIndex].get("Name");
          setUrl(snapshot.data!.docs[playingIndex].get("SongLink"));
          playAudio();
          notifyListeners();
        } else {
          audioState = "Stopped";
          playingIndex = -1;
          isPlaying = false;
          stopAudio();
          seekAudio(Duration(milliseconds: 0));
          notifyListeners();
        }
      } else {
        audioState = "Stopped";
        playingIndex = -1;
        isPlaying = false;
        stopAudio();
        seekAudio(Duration(milliseconds: 0));
        notifyListeners();
      }
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

  setPause(bool isPaused) {
    this.isPaused = isPaused;
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

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

}