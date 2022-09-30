import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_infinite_list/posts/models/post.dart';

part 'post_event.dart';
part 'post_state.dart';

const int _postLimit = 10;
List<Posts> _list = [];

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.httpClient}) : super(PostState()) {
    on<PostFetched>(_onPostFetched);
  }
  final HttpClient httpClient;

  Future<void> _onPostFetched(PostEvent event, Emitter<PostState> emit) async {
    if (state.hasReachedMax == true) return;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();
        return emit(state.copyWith(
            status: PostStatus.success, posts: posts, hasReachedMax: false));
      }
      final posts = await _fetchPosts(state.posts.length);
      emit(posts.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: PostStatus.success,
              posts: List.of(posts)..addAll(posts),
              hasReachedMax: false));
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<List<Posts>> _fetchPosts([int startIndex = 0]) async {
    final url = Uri.parse(
        'https://jsonplaceholder.typicode.com/posts?_start=${startIndex}&_limit.json');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final body = await json.decode(response.body) as List<dynamic>;
        body.forEach((element) {
          _list.add(Posts.fromJson(element));
        });
      }
      return _list;
    } catch (e) {
      print(e);
    }
    return [];
  }
}
