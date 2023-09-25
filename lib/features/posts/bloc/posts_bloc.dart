import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_api/features/posts/models/post_data_ui_model.dart';
import 'package:bloc_api/features/posts/repos/posts_page.dart';
import 'package:meta/meta.dart';
part 'posts_event.dart';
part 'posts_state.dart';


class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
    on<PostAddEvent>(postAddEvent);
  }

  FutureOr<void> postsInitialFetchEvent(PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostsFetchingLoadingState());
    List<PostDataUiModel> posts = await PostsRepo.fetchPosts();

      emit(PostFetchingSuccessfulState(posts: posts));
      // print(response.body);
  }

  FutureOr<void> postAddEvent(PostAddEvent event, Emitter<PostsState> emit) {
  }
}
