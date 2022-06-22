import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/comment.dart';

class CommentRepo {}

Future<List<Comment>> getListComment(
    {required int start, required int limit}) async {
  final url =
      "https://jsonplaceholder.typicode.com/comments?_start=$start&_limit=$limit";
  try {
    final response = await Dio().get(url);

    if (response.statusCode == 200) {
      final responseData = response.data as List;
      final List<Comment> listData = responseData.map((comment) {
        return Comment.fromJson(comment);
      }).toList();
      return listData;
    } else {
      return [];
    }
  } catch (error) {
    print(error);
    return [];
  }
}
