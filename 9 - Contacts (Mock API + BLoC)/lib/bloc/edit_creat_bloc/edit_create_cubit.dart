import 'package:contacts_mock_api_bloc/models/contact_model.dart';
import 'package:contacts_mock_api_bloc/services/http_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'edit_create_state.dart';

class EditCreateContactCubit extends Cubit<EditCreateContactState> {
  EditCreateContactCubit() : super(EditCreateContactInit());

  void saveAndExit(Contact contact, String name, String number) async {
    emit(EditCreateContactLoading());

    /// Edit
    if (contact.name != null && contact.number != null) {
      Contact contactUpdate =
          Contact(id: contact.id, name: name, number: number);

      final response = await Network.PUT(
          Network.API_UPDATE + contactUpdate.id.toString(),
          Network.paramsUpdate(contactUpdate));

      if (response != null) {
        emit(EditCreateContactLoaded(isDone: true));
      } else {
        emit(EditCreateContactError(error: "Couldn't update post"));
      }
    }

    /// Create
    else {
      Contact contactCreate = Contact(name: name, number: number);
      final response = await Network.POST(
          Network.API_CREATE, Network.paramsCreate(contactCreate));

      if (response != null) {
        emit(EditCreateContactLoaded(isDone: true));
      } else {
        emit(EditCreateContactError(error: "Couldn't create post"));
      }
    }
  }
}
