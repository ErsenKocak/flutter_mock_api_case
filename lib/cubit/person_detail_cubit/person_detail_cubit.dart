import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mock_api_case_ersen_kocak/service/person/person_service.dart';
import 'package:meta/meta.dart';

import '../../core/init/locator.dart';
import '../../model/Person.dart';

part 'person_detail_state.dart';

class PersonDetailCubit extends Cubit<PersonDetailState> {
  PersonDetailCubit() : super(PersonDetailInitialState());

  final _personService = getIt<PersonService>();
  Person? person;

  Future<void> getPersonById({required String personId}) async {
    try {
      emit(PersonDetailLoadingState());
      EasyLoading.show();
      var response = await _personService.getPersonById(personId: personId);

      if (response != null) {
        person = response;
        emit(PersonDetailLoadedState(person!));
      } else {
        emit(PersonDetailErrorState(
            'Kişi Detay Bilgileri Getirilemedi! Lütfen Tekrar Deneyin.'));
      }
    } on DioError catch (error) {
      emit(PersonDetailErrorState(
          'Kişi Detay Bilgileri Getirilemedi! Lütfen Tekrar Deneyin.'));
    }
  }

  Future<void> addPerson() async {
    try {
      emit(PersonDetailAddLoadingState());

      var isSuccess = await _personService.addPerson(person: person!);

      if (isSuccess) {
        emit(PersonDetailAddSuccessState());
      } else {
        emit(PersonDetailAddErrorState(
            'Kişi Kayıt İşlemi Başarısız! Lütfen Tekrar Deneyin.'));
      }
    } on DioError catch (error) {
      emit(PersonDetailAddErrorState(
          'Kişi Kayıt İşlemi Başarısız! Lütfen Tekrar Deneyin.'));
    }
  }

  Future<void> updatePerson() async {
    try {
      emit(PersonDetailUpdateLoadingState());

      var isSuccess = await _personService.updatePerson(person: person!);

      if (isSuccess) {
        emit(PersonDetailUpdateSuccessState());
      } else {
        emit(PersonDetailUpdateErrorState(
            'Kişi Güncelleme İşlemi Başarısız! Lütfen Tekrar Deneyin.'));
      }
    } on DioError catch (error) {
      emit(PersonDetailUpdateErrorState(
          'Kişi Güncelleme İşlemi Başarısız! Lütfen Tekrar Deneyin.'));
    }
  }

  Future<bool> deletPerson({required String personId}) async {
    try {
      emit(PersonDetailDeleteLoadingState());

      var isSuccess = await _personService.deletePerson(personId: personId);

      if (isSuccess) {
        emit(PersonDetailDeleteSuccessState());
        return true;
      } else {
        emit(PersonDetailDeleteErrorState(
            'Kişi Silme İşlemi Başarısız! Lütfen Tekrar Deneyin.'));
        return false;
      }
    } on DioError catch (error) {
      emit(PersonDetailDeleteErrorState(
          'Kişi Silme İşlemi Başarısız! Lütfen Tekrar Deneyin.'));
      return false;
    }
  }
}
