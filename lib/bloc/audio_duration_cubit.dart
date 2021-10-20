import 'package:bloc/bloc.dart';

class AudioDurationCubit extends Cubit<Duration> {
  AudioDurationCubit() : super(Duration(seconds: 0));
  void setDuration(Duration duration) => emit(duration);
}

class ChangeAudioDurationBlocState {
  // final int index;
  ChangeAudioDurationBlocState();
}
