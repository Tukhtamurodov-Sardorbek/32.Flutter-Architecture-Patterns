// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_create_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddOrEditStore on _AddOrEditStore, Store {
  late final _$postAtom = Atom(name: '_AddOrEditStore.post', context: context);

  @override
  Post? get post {
    _$postAtom.reportRead();
    return super.post;
  }

  @override
  set post(Post? value) {
    _$postAtom.reportWrite(value, super.post, () {
      super.post = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AddOrEditStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$titleControllerAtom =
      Atom(name: '_AddOrEditStore.titleController', context: context);

  @override
  TextEditingController get titleController {
    _$titleControllerAtom.reportRead();
    return super.titleController;
  }

  @override
  set titleController(TextEditingController value) {
    _$titleControllerAtom.reportWrite(value, super.titleController, () {
      super.titleController = value;
    });
  }

  late final _$bodyControllerAtom =
      Atom(name: '_AddOrEditStore.bodyController', context: context);

  @override
  TextEditingController get bodyController {
    _$bodyControllerAtom.reportRead();
    return super.bodyController;
  }

  @override
  set bodyController(TextEditingController value) {
    _$bodyControllerAtom.reportWrite(value, super.bodyController, () {
      super.bodyController = value;
    });
  }

  @override
  String toString() {
    return '''
post: ${post},
isLoading: ${isLoading},
titleController: ${titleController},
bodyController: ${bodyController}
    ''';
  }
}
