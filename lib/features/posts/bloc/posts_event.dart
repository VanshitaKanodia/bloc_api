part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}


//as soon as we open the app
class PostsInitialFetchEvent extends PostsEvent{}
