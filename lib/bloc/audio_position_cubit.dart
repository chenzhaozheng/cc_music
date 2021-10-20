import 'package:bloc/bloc.dart';

class AudioPositionCubit extends Cubit<Duration> {
  AudioPositionCubit() : super(Duration(seconds: 0));
  void setPosition(Duration duration) => emit(duration);
}

class ChangeAudioPositionBlocState {
  // final int index;
  ChangeAudioPositionBlocState();
}
