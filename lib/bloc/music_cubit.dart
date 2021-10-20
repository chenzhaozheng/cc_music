import 'package:bloc/bloc.dart';

class MusicCubit extends Cubit<int> {
  MusicCubit() : super(0);
  void increment(num) => emit(state + 1 + num);
  // void set() =>emit(state);
}

class ChangeMusicBlocState {
  final int index;
  ChangeMusicBlocState(this.index);
}