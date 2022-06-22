import 'package:equatable/equatable.dart';

abstract class TimeEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StartEvent extends TimeEvent {
  final int timeDuration;

  StartEvent({required this.timeDuration});
}

class RunEvent extends TimeEvent {
  final int timeDuration;

  RunEvent({required this.timeDuration});
}

class PauseEvent extends TimeEvent {}

class ResetEvent extends TimeEvent {}

class ResumeEvent extends TimeEvent {}
