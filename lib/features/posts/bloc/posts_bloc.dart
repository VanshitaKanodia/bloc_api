import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_api/features/posts/models/post_data_ui_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
  }

  FutureOr<void> postsInitialFetchEvent(PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostsFetchingLoadingState());
    var client = http.Client();
    List<PostDataUiModel> posts = [];
    try {
      var response = await client.get(
          // https://jsonplaceholder.typicode.com/posts
          Uri.parse("https://jsonplaceholder.typicode.com/posts"));

      List result = jsonDecode(response.body);

      for(int i=0; i<result.length; i++)
        {
          PostDataUiModel post = PostDataUiModel.fromJson(result[i] as Map<String, dynamic>);
          posts.add(post);
        }

      print(posts);
      emit(PostFetchingSuccessfulState(posts: posts));
      // print(response.body);
    }
    catch(e){
      emit(PostsFetchingErrorState());
      log(e.toString());
    }
  }
}
