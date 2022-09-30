import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/bloc/post_bloc.dart';
import 'package:flutter_infinite_list/presentation/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<PostBloc>(
        create: (context) =>
            PostBloc(httpClient: HttpClient())..add(PostFetched()),
        child: HomePage(),
      ),
    );
  }
}
