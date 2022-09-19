import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../../core/init/locator.dart';
import '../../model/Person.dart';
import '../../service/person/person_service.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
part 'person_list_state.dart';

class PersonListCubit extends Cubit<PersonListState> {
  PersonListCubit() : super(PersonListInitialState());
  late PagingController<int, Person> pagingController =
      PagingController(firstPageKey: 0);

  final _personService = getIt<PersonService>();
  final _logger = getIt<Logger>();
  List<Person> personList = [];

  //REQUEST
  int limit = 10;

  Future<void> getPersonList({required int pageKey}) async {
    try {
      emit(PersonListLoadingState());

      var response =
          await _personService.getPersonList(pageKey: pageKey, limit: limit);

      if (response != null) {
        personList = response;
        final isLastPage = personList.length < limit;
        if (isLastPage) {
          pagingController.appendLastPage(personList!);
        } else {
          pagingController.appendPage(personList, pageKey);
        }
        emit(PersonListSuccessState(personList));
      } else {
        emit(PersonListErrorState(
            'List Bilgileri Getirilemedi! Lütfen Tekrar Deneyin'));
        pagingController.error = '';
      }
    } on DioError catch (error) {
      _logger.e('PersonListCubit ERROR - > ${error.response}');
      emit(PersonListErrorState(
          'List Bilgileri Getirilemedi! Lütfen Tekrar Deneyin'));
      pagingController.error = '';
    }
  }
}
