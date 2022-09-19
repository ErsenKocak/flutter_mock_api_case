part of 'person_list_cubit.dart';

@immutable
abstract class PersonListState {}

class PersonListInitialState extends PersonListState {}

class PersonListLoadingState extends PersonListState {}

class PersonListSuccessState extends PersonListState {
  final List<Person> personList;

  PersonListSuccessState(this.personList);
}

class PersonListErrorState extends PersonListState {
  final String errorMessage;

  PersonListErrorState(this.errorMessage);
}
