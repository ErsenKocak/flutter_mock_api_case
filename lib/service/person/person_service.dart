import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_mock_api_case_ersen_kocak/core/app/constants/constants.dart';
import 'package:flutter_mock_api_case_ersen_kocak/model/Person.dart';
import 'package:logger/logger.dart';

import '../../core/init/locator.dart';

class PersonService {
  final _dio = getIt<Dio>();
  final _logger = getIt<Logger>();

  Future<List<Person>?> getPersonList(
      {required int pageKey, required int limit}) async {
    try {
      var response = await _dio
          .get('$PERSON_URL?page=$pageKey&limit=$limit&sortBy=name&order=asc');

      _logger
          .wtf('PersonService -- getPersonList-- RESPONSE -- ${response.data}');

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        return (response.data as List).map((e) => Person.fromJson(e)).toList();
      }
    } on DioError catch (error) {
      _logger.e('PersonService SERVICE ERROR --> ${error.message}');
      rethrow;
    }
  }

  Future<Person?> getPersonById({required String personId}) async {
    try {
      var response = await _dio.get('$PERSON_URL/$personId');

      _logger
          .wtf('PersonService -- getPersonById-- RESPONSE -- ${response.data}');

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        return Person.fromJson(response.data);
      }
    } on DioError catch (error) {
      _logger
          .e('PersonService SERVICE -- GET BY ID  ERROR --> ${error.message}');
      rethrow;
    }
  }

  Future<bool> addPerson({required Person person}) async {
    try {
      _logger.wtf('PersonService -- addPerson-- REQUEST -- ${person.toJson()}');

      var response = await _dio.post(PERSON_URL, data: person);

      if (response.statusCode == HttpStatus.created) {
        _logger.wtf('PersonService -- addPerson-- RESPONSE-- ${response.data}');
        return true;
      }
      return false;
    } on DioError catch (error) {
      _logger.e('PersonService SERVICE -- ADD -- ERROR --> ${error.message}');
      rethrow;
    }
  }

  Future<bool> updatePerson({required Person person}) async {
    try {
      _logger
          .wtf('PersonService -- updatePerson-- REQUEST -- ${person.toJson()}');
      var response = await _dio.put('$PERSON_URL/${person.id}', data: person);

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        _logger
            .wtf('PersonService -- updatePerson-- RESPONSE-- ${response.data}');
        return true;
      }
      return false;
    } on DioError catch (error) {
      _logger
          .e('PersonService SERVICE -- UPDATE -- ERROR --> ${error.message}');
      rethrow;
    }
  }

  Future<bool> deletePerson({required String personId}) async {
    try {
      _logger.wtf('PersonService -- updatePerson-- REQUEST -- $personId');
      var response = await _dio.delete('$PERSON_URL/${personId}');

      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.noContent) {
        _logger
            .wtf('PersonService -- deletePerson-- RESPONSE-- ${response.data}');
        return true;
      }
      return false;
    } on DioError catch (error) {
      _logger
          .e('PersonService SERVICE -- DELETE -- ERROR --> ${error.message}');
      rethrow;
    }
  }
}
