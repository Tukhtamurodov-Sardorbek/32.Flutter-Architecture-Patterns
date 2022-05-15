import 'package:bloc_pattern/models/post_model.dart';
import 'package:equatable/equatable.dart';

abstract class PostListState extends Equatable{
  @override
  List<Object> get props => [];

}

class PostListInit extends PostListState {}

class PostListLoading extends PostListState {}

class PostListLoaded extends PostListState {
  final List<Post> posts;
  final bool? isDeleted;

  PostListLoaded({required this.posts, this.isDeleted});
}

class PostListError extends PostListState {
  final error;
  PostListError({required this.error});
}