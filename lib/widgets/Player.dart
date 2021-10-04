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

    return Container(
      height: 60,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.only(topRight: Radius.circular(30))),
      child: Consumer<AudioProvider>(
        builder: (context, audioModel, child) {
          return Row(
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
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4),
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
                      audioModel.seekAudio(Duration(seconds: val.toInt()));
                    },
                  ),
                ),
              ),
              Text(
                audioModel.totalDuration.toString().split('.').first,
                style: TextStyle(color: Colors.black),
              )
            ],
          );
        },
      ),
    );
  }
}
