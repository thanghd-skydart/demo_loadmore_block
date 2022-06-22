import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block/events/time_event.dart';
import 'package:flutter_block/states/time_state.dart';

class TimeBloc extends Bloc<TimeEvent, TimeState> {
  TimeBloc(TimeState initialState) : super(initialState);
}
