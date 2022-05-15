import 'package:equatable/equatable.dart';

abstract class EditCreateContactState extends Equatable{
  @override
  List<Object> get props => [];

}

class EditCreateContactInit extends EditCreateContactState {}

class EditCreateContactLoading extends EditCreateContactState {}

class EditCreateContactLoaded extends EditCreateContactState {
  final bool? isDone;

  EditCreateContactLoaded({required this.isDone});
}

class EditCreateContactError extends EditCreateContactState {
  final error;
  EditCreateContactError({required this.error});
}