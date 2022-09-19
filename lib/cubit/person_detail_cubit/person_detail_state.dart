part of 'person_detail_cubit.dart';

@immutable
abstract class PersonDetailState {}

class PersonDetailInitialState extends PersonDetailState {}

//DETAIL
class PersonDetailLoadingState extends PersonDetailState {}

class PersonDetailLoadedState extends PersonDetailState {
  final Person person;

  PersonDetailLoadedState(this.person);
}

class PersonDetailErrorState extends PersonDetailState {
  final String errorMessage;

  PersonDetailErrorState(this.errorMessage);
}

//ADD
class PersonDetailAddLoadingState extends PersonDetailState {}

class PersonDetailAddSuccessState extends PersonDetailState {}

class PersonDetailAddErrorState extends PersonDetailState {
  final String errorMessage;

  PersonDetailAddErrorState(this.errorMessage);
}

//UPDATE
class PersonDetailUpdateLoadingState extends PersonDetailState {}

class PersonDetailUpdateSuccessState extends PersonDetailState {}

class PersonDetailUpdateErrorState extends PersonDetailState {
  final String errorMessage;

  PersonDetailUpdateErrorState(this.errorMessage);
}

//DELETE
class PersonDetailDeleteLoadingState extends PersonDetailState {}

class PersonDetailDeleteSuccessState extends PersonDetailState {}

class PersonDetailDeleteErrorState extends PersonDetailState {
  final String errorMessage;

  PersonDetailDeleteErrorState(this.errorMessage);
}
