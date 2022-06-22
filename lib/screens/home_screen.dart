import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block/blocs/comment_bloc.dart';
import 'package:flutter_block/states/comment_state.dart';

import '../events/comment_event.dart';
import '../models/comment.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  bool get _isBottom {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= maxScroll;
  }

  void _onScroll() {
    if (_isBottom) context.read<CommentBloc>().add(CommentFetchedEvent());
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App demo block in flutter"),
        centerTitle: true,
      ),
      body: BlocBuilder<CommentBloc, CommentState>(
        builder: (context, state) {
          if (state.status == CommentStatus.initial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == CommentStatus.failure) {
            return const Center(
              child: Text("Lỗi rồi bé ơi!"),
            );
          }
          if (state.status == CommentStatus.success) {
            if (state.comments.isEmpty) {
              return const Center(
                child: Text("Hông có data bé eiii!"),
              );
            }
            final listComment = state.comments;
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.hasReachedEnd
                  ? listComment.length
                  : listComment.length + 1,
              itemBuilder: ((context, index) {
                if (index >= listComment.length) {
                  return Container(
                    alignment: Alignment.center,
                    child: const Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.5,
                        ),
                      ),
                    ),
                  );
                }
                final Comment comment = listComment[index];
                return ListTile(
                  leading: Text(
                    comment.id.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  title: Text(
                    comment.name!,
                    style: const TextStyle(
                        color: Colors.black45,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    comment.body!,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  isThreeLine: true,
                );
              }),
            );
          }
          return const Center(
            child: Text(" Mặc định bé ơi!!! ok hum?"),
          );
        },
      ),
    );
  }
}
