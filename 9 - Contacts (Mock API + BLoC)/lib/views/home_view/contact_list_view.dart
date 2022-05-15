import 'package:contacts_mock_api_bloc/bloc/home_bloc/home_cubit.dart';
import 'package:contacts_mock_api_bloc/models/contact_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class postWidget extends StatelessWidget {
  final Contact contact;
  const postWidget({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Slidable(
        /// Edit
        startActionPane: ActionPane(
          dragDismissible: true,
          extentRatio: 0.3,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              backgroundColor: CupertinoColors.activeBlue,
              onPressed: (_) {
                BlocProvider.of<ContactListCubit>(context).openEditCreatePage(context, contact);
              },
              icon: Icons.edit,
            ),
          ],
        ),

        /// Delete
        endActionPane: ActionPane(
          dragDismissible: true,
          extentRatio: 0.3,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              backgroundColor: CupertinoColors.systemRed,
              onPressed: (_) {
                BlocProvider.of<ContactListCubit>(context)
                    .deleteContact(contact);
              },
              icon: Icons.delete,
            ),
          ],
        ),

        /// Body
        child: ListTile(
          minLeadingWidth: 10,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(contact.id!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          title: Text(contact.name!.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(contact.number!),
        ),
      ),
    );
  }
}
