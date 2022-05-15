import 'package:equatable/equatable.dart';

abstract class EditCreatePostState extends Equatable{
  @override
  List<Object> get props => [];

}

class EditCreatePostInit extends EditCreatePostState {}

class EditCreatePostLoading extends EditCreatePostState {}

class EditCreatePostLoaded extends EditCreatePostState {
  final bool? isDone;

  EditCreatePostLoaded({required this.isDone});
}

class EditCreatePostError extends EditCreatePostState {
  final error;
  EditCreatePostError({required this.error});
}