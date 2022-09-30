import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/widgets/post_list_tile.dart';

import '../posts/bloc/post_bloc.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if ((state).status == PostStatus.failure) {
          return Center(child: Text('failed to fetch'));
        }
        if (state.status == PostStatus.initial) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.status == PostStatus.success) {
          if (state.posts.isEmpty) {
            return Text('no available posts to fetch');
          }
          return ListView.builder(
            itemBuilder: ((context, index) {
              return index >= state.posts.length
                  ? Center(child: Text('no posts'))
                  : PostList(post: state.posts[index]);
            }),
            itemCount: state.hasReachedMax
                ? state.posts.length
                : state.posts.length + 1,
          );
        }
        return Center(
          child: Text('something went wrong'),
        );
      },
    );
  }
}
