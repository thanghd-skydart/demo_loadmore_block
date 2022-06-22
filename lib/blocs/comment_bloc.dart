import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block/events/comment_event.dart';
import 'package:flutter_block/services/service.dart';
import 'package:flutter_block/states/comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  // init state
  CommentBloc() : super(const CommentState()) {
    on<CommentFetchedEvent>(_mapEventtoState);
  }
  Future<void> _mapEventtoState(
      CommentEvent event, Emitter<CommentState> emit) async {
    const int limit = 10;
    // check if "has reached end of a state"
    if (state.hasReachedEnd) return;
    try {
      if (state.status == CommentStatus.initial) {
        final comments = await getListComment(start: 0, limit: limit);
        emit(state.copyWith(
          status: CommentStatus.success,
          comments: comments,
          hasReachedEnd: false,
        ));
      }
      final int indexOfCurrentPage = state.comments.length;

      final comments =
          await getListComment(start: indexOfCurrentPage, limit: limit);

      comments.isEmpty
          ? emit(state.copyWith(hasReachedEnd: true))
          : emit(
              state.copyWith(
                status: CommentStatus.success,
                comments: List.of(state.comments)..addAll(comments),
                hasReachedEnd: false,
              ),
            );
    } catch (error) {
      emit(state.copyWith(
        status: CommentStatus.failure,
      ));
    }
  }
}
