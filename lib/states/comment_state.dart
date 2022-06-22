import 'package:equatable/equatable.dart';

import '../models/comment.dart';

enum CommentStatus { initial, success, failure }

class CommentState extends Equatable {
  final List<Comment> comments;
  final bool hasReachedEnd;
  final CommentStatus status;
  const CommentState({
    this.comments = const <Comment>[],
    this.hasReachedEnd = false,
    this.status = CommentStatus.initial,
  });
  @override
  String toString() {
    return "comments : $comments, hasReachedEnd: $hasReachedEnd, status : $status";
  }

  CommentState copyWith({
    CommentStatus? status,
    List<Comment>? comments,
    bool? hasReachedEnd,
  }) {
    return CommentState(
      status: status ?? this.status,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      comments: comments ?? this.comments,
    );
  }

  @override
  List<Object?> get props => [comments, hasReachedEnd, status];
}

class CommentStateInit extends CommentState {}
