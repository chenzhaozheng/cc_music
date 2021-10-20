import 'package:cc_music/bloc/audio_cubit.dart';
import 'package:cc_music/bloc/audio_state.dart';
import 'package:cc_music/bloc/audio_status_cubit.dart';
import 'package:cc_music/music/second_screen_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cd extends StatefulWidget {
  const Cd() : super();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Cd> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 3000),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    ).drive(Tween(begin: 0, end: 1));
    controller
      ..reset()
      ..forward()
      ..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // BlocBuilder<AudioStatusCubit, String>(
        //     builder: (context, status) => Text('dddd')),
        BlocBuilder<AudioStatusCubit, String>(
          builder: (context, status) => status == 'AudioPlayerState.PLAYING'
              ? GestureDetector(
                  child: RotationTransition(
                      turns: animation,
                      child: IconButton(
                        icon: ClipOval(
                          child: Image.asset(
                            'images/zhizu.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondScreen()),
                          );
                        },
                      )))
              : IconButton(
                  icon: ClipOval(
                    child: Image.asset(
                      'images/zhizu.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondScreen()),
                    );
                  },
                ),
        ),
        // // BlocBuilder<AudioCubit, AudioState>(
        // //     builder: (context, audioState) =>
        //         Text(audioState.audioPlayer.state.toString())),
        // Text(widget.playStatus),
      ],
    );
  }
}
