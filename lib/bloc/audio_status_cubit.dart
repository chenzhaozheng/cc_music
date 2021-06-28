import 'package:bloc/bloc.dart';

class AudioStatusCubit extends Cubit<String> {
  AudioStatusCubit() : super('');
  void setValue(String audioStatus) => emit(audioStatus);
}
