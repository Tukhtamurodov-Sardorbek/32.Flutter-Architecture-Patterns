import 'package:contacts_mock_api_bloc/models/contact_model.dart';
import 'package:equatable/equatable.dart';

abstract class ContactListState extends Equatable{
  @override
  List<Object> get props => [];

}

class ContactListInit extends ContactListState {}

class ContactListLoading extends ContactListState {}

class ContactListLoaded extends ContactListState {
  final List<Contact> contacts;
  final bool? isDeleted;

  ContactListLoaded({required this.contacts, this.isDeleted});
}

class ContactListError extends ContactListState {
  final error;
  ContactListError({required this.error});
}