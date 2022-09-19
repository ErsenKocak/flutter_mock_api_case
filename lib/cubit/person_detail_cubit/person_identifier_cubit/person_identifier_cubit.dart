import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class PersonIdentifierCubit extends Cubit<bool> {
  PersonIdentifierCubit() : super(false);
  bool isValid = false;

  changeTheState({required bool value}) {
    isValid = value;
    emit(isValid);
  }
}
