import 'package:bible/providers/AudioProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  double currentSlider = 0;

  @override
  Widget build(BuildContext context) {
    final _audioProvider = Provider.of<AudioProvider>(context);

    return Container(
      height: 115,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.only(topRight: Radius.circular(30))),
      child: Consumer<AudioProvider>(
        builder: (context, audioModel, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Container(
                  child: Text("Now Playing: " + _audioProvider.songName),
                ),
              ),
              Container(
                height: 25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      audioModel.position.toString().split('.').first,
                      style: TextStyle(color: Colors.black),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 120,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 4),
                          trackShape: RectangularSliderTrackShape(),
                          trackHeight: 4,
                        ),
                        child: Slider(
                          value: audioModel.position.inSeconds.toDouble(),
                          max: audioModel.totalDuration.inSeconds.toDouble(),
                          min: 0,
                          inactiveColor: Colors.red[100],
                          activeColor: Colors.red,
                          onChanged: (val) {
                            setState(() {
                              currentSlider = val;
                            });
                            audioModel
                                .seekAudio(Duration(seconds: val.toInt()));
                          },
                        ),
                      ),
                    ),
                    Text(
                      audioModel.totalDuration.toString().split('.').first,
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      backgroundColor: _audioProvider.isShuffle
                          ? Colors.grey
                          : Colors.transparent,
                      child: IconButton(
                        icon: Icon(Icons.shuffle),
                        color: Colors.black,
                        onPressed: () {
                          _audioProvider.setShuffle();
                          setState(() {
                            _audioProvider.isRepeat = false;
                          });
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.skip_previous),
                      color: _audioProvider.playingIndex != 0
                          ? Colors.black
                          : Colors.grey,
                      onPressed: () {
                        if (_audioProvider.playingIndex != 0) {
                          _audioProvider.stopAudio();
                          _audioProvider.isPlaying = true;
                          _audioProvider.playingIndex = _audioProvider.playingIndex - 1;
                          _audioProvider.isPaused = false;
                          _audioProvider.songName = _audioProvider.snapshot.data!.docs[_audioProvider.playingIndex].get("Name");
                          _audioProvider.setUrl(_audioProvider.snapshot.data!.docs[_audioProvider.playingIndex].get("SongLink"));
                          _audioProvider.playAudio();
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        _audioProvider.isPaused
                            ? Icons.play_arrow
                            : Icons.pause,
                      ),
                      onPressed: () {
                        print("Size is: ${_audioProvider.snapshot.data!.size.toString()}");
                        if (_audioProvider.isPaused) {
                          _audioProvider.setPause(false);
                          _audioProvider.playAudio();
                        } else {
                          _audioProvider.setPause(true);
                          _audioProvider.pauseAudio();
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.skip_next),
                      color: _audioProvider.snapshot.data!.size !=
                              _audioProvider.playingIndex + 1
                          ? Colors.black
                          : Colors.grey,
                      onPressed: () {
                        if (_audioProvider.snapshot.data!.size !=
                            _audioProvider.playingIndex + 1) {
                          _audioProvider.stopAudio();
                          _audioProvider.isPlaying = true;
                          _audioProvider.playingIndex = _audioProvider.playingIndex + 1;
                          _audioProvider.isPaused = false;
                          _audioProvider.songName = _audioProvider.snapshot.data!.docs[_audioProvider.playingIndex].get("Name");
                          _audioProvider.setUrl(_audioProvider.snapshot.data!.docs[_audioProvider.playingIndex].get("SongLink"));
                          _audioProvider.playAudio();
                        }
                      },
                    ),
                    CircleAvatar(
                      backgroundColor: _audioProvider.isRepeat
                          ? Colors.grey
                          : Colors.transparent,
                      child: IconButton(
                        icon: Icon(Icons.repeat),
                        color: Colors.black,
                        onPressed: () {
                          _audioProvider.setRepeat();
                          setState(() {
                            _audioProvider.isShuffle = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
