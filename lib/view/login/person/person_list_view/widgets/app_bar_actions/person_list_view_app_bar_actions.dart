import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mock_api_case_ersen_kocak/core/widgets/custom_icon_button/custom_icon_button.dart';
import 'package:flutter_mock_api_case_ersen_kocak/cubit/person_list_cubit/person_list_cubit.dart';

personListViewAppBarActions({required BuildContext context}) => [
      CustomIconButton(
        message: 'Yenile',
        icon: const Icon(Icons.refresh),
        callBack: () {
          context.read<PersonListCubit>().personList.clear();
          context.read<PersonListCubit>().pagingController.refresh();
        },
      )
    ];
