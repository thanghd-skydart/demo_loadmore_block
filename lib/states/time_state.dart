import 'package:equatable/equatable.dart';

class TimeState extends Equatable {
  final int timeDuration;

  const TimeState({required this.timeDuration});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialTimeState extends TimeState {
  final int timeDurationInit;

  const InitialTimeState(this.timeDurationInit)
      : super(timeDuration: timeDurationInit);
}

class RunningTimeState extends TimeState {
  final int timeDurationRun;

  const RunningTimeState(this.timeDurationRun)
      : super(timeDuration: timeDurationRun);
}

class PauseTimeState extends TimeState {
  final int timeDurationPause;

  const PauseTimeState(this.timeDurationPause)
      : super(timeDuration: timeDurationPause);
}

class CompletedTimeState extends TimeState {
  const CompletedTimeState() : super(timeDuration: 0);
}
