part of 'post_bloc.dart';

enum PostStatus { initial, success, failure }

class PostState extends Equatable {
  PostState(
      {this.status = PostStatus.initial,
      this.posts = const <Posts>[],
      this.hasReachedMax = false});
  final PostStatus status;
  final List<Posts> posts;
  final bool hasReachedMax;

  PostState copyWith(
      {PostStatus? status, List<Posts>? posts, bool? hasReachedMax}) {
    return PostState(
        status: status ?? this.status,
        posts: posts ?? this.posts,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  String toString() {
    return 'PostState{status: $status, posts: ${posts.length}, hasReachedMax: $hasReachedMax';
  }

  @override
  List<Object?> get props => [status, posts, hasReachedMax];
}
