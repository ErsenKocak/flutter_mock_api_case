import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mock_api_case_ersen_kocak/core/app/localization/localization_keys_constants.dart';
import 'package:flutter_mock_api_case_ersen_kocak/core/widgets/custom_icon_button/custom_icon_button.dart';
import 'package:flutter_mock_api_case_ersen_kocak/core/widgets/custom_text_form_field/custom_text_form_field_widget.dart';
import 'package:flutter_mock_api_case_ersen_kocak/core/widgets/date_time_picker/date_time_picker_widget.dart';
import 'package:flutter_mock_api_case_ersen_kocak/cubit/person_detail_cubit/person_detail_cubit.dart';
import 'package:flutter_mock_api_case_ersen_kocak/view/login/person/person_list_view/person_list_view.dart';
import 'package:logger/logger.dart';

import '../../../../core/app/constants/constants.dart';
import '../../../../core/helper/dialog_helper/dialog_helper.dart';
import '../../../../core/helper/identifier_helper/identifier_helper.dart';
import '../../../../core/helper/mask_formatter_helper/mask_formatter_helper.dart';
import '../../../../core/helper/toast_helper/toast_helper.dart';
import '../../../../core/init/locator.dart';
import '../../../../core/widgets/appbar/app_bar_widget.dart';
import '../../../../cubit/person_detail_cubit/person_identifier_cubit/person_identifier_cubit.dart';
import '../../../../model/Person.dart';

class PersonDetailView extends StatefulWidget {
  PersonDetailView({super.key, required this.isDetail, this.person});
  final bool isDetail;
  final Person? person;

  @override
  State<PersonDetailView> createState() => _PersonDetailViewState();
}

class _PersonDetailViewState extends State<PersonDetailView>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late GlobalKey<FormState> _formKey;
  final _logger = getIt<Logger>();
  final _dialogHelper = getIt<DialogHelper>();
  final _maskFormatterHelper = getIt<MaskFormatterHelper>();
  final _identifierHelper = getIt<IdentifierHelper>();
  final _toastHelper = getIt<ToastHelper>();

  //CONTROLLERS

  final _personNameTextController = TextEditingController();
  final _personSurNameTextController = TextEditingController();
  final _personBirthDayTextController =
      TextEditingController(text: DateTime.now().toString());
  final _personIdendityTextController = TextEditingController();
  final _personCompanyNameTextController = TextEditingController();
  final _personJobTitleTextController = TextEditingController();
  final _personJobDescriptionTextController = TextEditingController();
  final _personPhoneNumberTextController = TextEditingController();
  final _personSallaryTextController = TextEditingController();
  final _personimageUrlTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();

    context.read<PersonDetailCubit>().person = Person();
    context.read<PersonIdentifierCubit>().changeTheState(value: false);

    if (widget.isDetail) {
      context
          .read<PersonDetailCubit>()
          .getPersonById(personId: widget.person!.id!)
          .then((value) => {
                _personNameTextController.text =
                    context.read<PersonDetailCubit>().person?.name ?? '',
                _personSurNameTextController.text =
                    context.read<PersonDetailCubit>().person?.surname ?? '',
                _personBirthDayTextController.text =
                    context.read<PersonDetailCubit>().person?.birthDate ?? '',
                _personIdendityTextController.text =
                    context.read<PersonDetailCubit>().person?.identity ?? '',
                _personCompanyNameTextController.text =
                    context.read<PersonDetailCubit>().person?.companyName ?? '',
                _personJobTitleTextController.text =
                    context.read<PersonDetailCubit>().person?.jobTitle ?? '',
                _personJobDescriptionTextController.text =
                    context.read<PersonDetailCubit>().person?.jobDescription ??
                        '',
                _personPhoneNumberTextController.text =
                    context.read<PersonDetailCubit>().person?.phoneNumber ?? '',
                _personimageUrlTextController.text =
                    context.read<PersonDetailCubit>().person?.imageUrl ?? '',
                _personSallaryTextController.text = context
                        .read<PersonDetailCubit>()
                        .person
                        ?.sallary
                        .toString() ??
                    '',
              });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: buildAppBar(context),
        floatingActionButton: buildFabButton(),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70.0,
                  backgroundImage: NetworkImage(context
                          .watch<PersonDetailCubit>()
                          .person
                          ?.imageUrl ??
                      'https://icon-library.com/images/avatar-icon-images/avatar-icon-images-4.jpg'),
                  backgroundColor: Colors.transparent,
                ),
                buildBody(),
              ],
            )));
  }

  buildAppBar(BuildContext context) {
    return appBarWidget(
        AppBar().preferredSize.height,
        context,
        widget.isDetail
            ? '${widget.person?.name} ${widget.person?.surname}'
            : LocalizationKeys.PERSON_DETAIL_VIEW_ADD_PERSON.tr(),
        _scaffoldKey,
        [],
        CustomIconButton(
          icon: const Icon(Icons.arrow_back_ios),
          callBack: () => Navigator.pop(context),
        ));
  }

  buildFabButton() {
    return BlocConsumer<PersonDetailCubit, PersonDetailState>(
      listener: (context, state) {
        if (state is PersonDetailLoadingState ||
            state is PersonDetailAddLoadingState ||
            state is PersonDetailUpdateLoadingState) {
          EasyLoading.show();
        } else if (state is PersonDetailLoadedState) {
          EasyLoading.dismiss();
        } else if (state is PersonDetailErrorState) {
          EasyLoading.dismiss();
        } else if (state is PersonDetailAddSuccessState) {
          EasyLoading.dismiss();
          showResult(
              title: LocalizationKeys.PERSON_DETAIL_VIEW_ADD_PERSON_RESULT.tr(),
              bodyText: LocalizationKeys
                  .PERSON_DETAIL_VIEW_ADD_PERSON_RESULT_SUCCESS
                  .tr(),
              isShowToast: true,
              toastColor: Colors.green,
              toastText: LocalizationKeys
                  .PERSON_DETAIL_VIEW_ADD_PERSON_RESULT_SUCCESS
                  .tr());
        } else if (state is PersonDetailAddErrorState) {
          EasyLoading.dismiss();
          showResult(
              title: LocalizationKeys.PERSON_DETAIL_VIEW_ADD_PERSON_RESULT.tr(),
              bodyText: LocalizationKeys
                  .PERSON_DETAIL_VIEW_ADD_PERSON_RESULT_ERROR
                  .tr(),
              isShowToast: true,
              toastColor: Colors.red,
              toastText: LocalizationKeys
                  .PERSON_DETAIL_VIEW_ADD_PERSON_RESULT_ERROR
                  .tr());
        } else if (state is PersonDetailUpdateSuccessState) {
          EasyLoading.dismiss();
          showResult(
              title:
                  LocalizationKeys.PERSON_DETAIL_VIEW_UPDATE_PERSON_RESULT.tr(),
              bodyText: LocalizationKeys
                  .PERSON_DETAIL_VIEW_UPDATE_PERSON_RESULT_SUCCESS
                  .tr(),
              isShowToast: true,
              toastColor: Colors.green,
              toastText: LocalizationKeys
                  .PERSON_DETAIL_VIEW_UPDATE_PERSON_RESULT_SUCCESS
                  .tr());
        } else if (state is PersonDetailUpdateErrorState) {
          EasyLoading.dismiss();
          showResult(
              title:
                  LocalizationKeys.PERSON_DETAIL_VIEW_UPDATE_PERSON_RESULT.tr(),
              bodyText: LocalizationKeys
                  .PERSON_DETAIL_VIEW_UPDATE_PERSON_RESULT_ERROR
                  .tr(),
              isShowToast: true,
              toastColor: Colors.red,
              toastText: LocalizationKeys
                  .PERSON_DETAIL_VIEW_UPDATE_PERSON_RESULT_ERROR
                  .tr());
        }
      },
      builder: (context, state) {
        return FloatingActionButton(
            child: const Icon(Icons.save),
            onPressed: () {
              var isValid = _formKey.currentState?.validate();

              if (isValid == true) {
                _formKey.currentState?.save();

                if (widget.isDetail) {
                  context.read<PersonDetailCubit>().updatePerson();
                } else {
                  context.read<PersonDetailCubit>().addPerson();
                }
              } else {
                _toastHelper.showToast(
                    message: LocalizationKeys.REQUIRED.tr(), color: Colors.red);
              }
            });
      },
    );
  }

  buildBody() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            buildSizedBox(height: 20),
            CustomTextFormFieldWidget(
              controller: _personNameTextController,
              hintText: LocalizationKeys.WRITE.tr(),
              labelText: LocalizationKeys.PERSON_NAME.tr(),
              validator: true,
              onSaved: (value) {
                if (value != null) {
                  _personNameTextController.text = value;
                  context.read<PersonDetailCubit>().person?.name = value;
                }
              },
            ),
            buildSizedBox(height: 20),
            CustomTextFormFieldWidget(
              controller: _personSurNameTextController,
              hintText: LocalizationKeys.WRITE.tr(),
              labelText: LocalizationKeys.PERSON_SURNAME.tr(),
              validator: true,
              onSaved: (value) {
                if (value != null) {
                  _personSurNameTextController.text = value;
                  context.read<PersonDetailCubit>().person?.surname = value;
                }
              },
            ),
            buildSizedBox(height: 20),
            CustomTextFormFieldWidget(
              controller: _personIdendityTextController,
              hintText: LocalizationKeys.WRITE.tr(),
              labelText: LocalizationKeys.PERSON_IDENDITY.tr(),
              validator: true,
              errorText: identifierErrorText,
              maxLength: 11,
              onChanged: (value) {
                identifierErrorText;
              },
              onSaved: (value) {
                if (value != null &&
                    context.read<PersonIdentifierCubit>().isValid) {
                  context.read<PersonDetailCubit>().person?.identity = value;
                }
              },
              suffixIcon: Icon(
                context.watch<PersonIdentifierCubit>().isValid
                    ? Icons.check
                    : Icons.cancel_outlined,
                color: context.watch<PersonIdentifierCubit>().isValid
                    ? ksecondaryColor
                    : Colors.red,
              ),
            ),
            buildSizedBox(height: 20),
            CustomDateTimePickerWidget(
              controller: _personBirthDayTextController,
              isWithHours: false,
              labelText: LocalizationKeys.PERSON_BIRTH_DAY.tr(),
              nextDate: false,
              weekend: true,
              validator: true,
              wantKeepAlive: false,
              onSaved: (value) {
                if (value != null) {
                  _personBirthDayTextController.text = value;
                  context.read<PersonDetailCubit>().person?.birthDate = value;
                }
              },
            ),
            buildSizedBox(height: 20),
            CustomTextFormFieldWidget(
              controller: _personPhoneNumberTextController,
              hintText: LocalizationKeys.WRITE.tr(),
              labelText: LocalizationKeys.PERSON_PHONE_NUMBER.tr(),
              keyboardType: TextInputType.phone,
              validator: true,
              customInputFormatters: [_maskFormatterHelper.maskPhoneFormatter],
              onSaved: (value) {
                if (value != null) {
                  value =
                      _maskFormatterHelper.maskPhoneFormatter.unmaskText(value);
                  _personPhoneNumberTextController.text = value;
                  context.read<PersonDetailCubit>().person?.phoneNumber = value;
                }
              },
            ),
            buildSizedBox(height: 20),
            CustomTextFormFieldWidget(
              controller: _personJobTitleTextController,
              hintText: LocalizationKeys.WRITE.tr(),
              labelText: LocalizationKeys.PERSON_JOB_TITLE.tr(),
              validator: true,
              onSaved: (value) {
                if (value != null) {
                  _personJobTitleTextController.text = value;
                  context.read<PersonDetailCubit>().person?.jobTitle = value;
                }
              },
            ),
            buildSizedBox(height: 20),
            CustomTextFormFieldWidget(
              controller: _personSallaryTextController,
              hintText: LocalizationKeys.WRITE.tr(),
              labelText: LocalizationKeys.PERSON_SALLARY.tr(),
              keyboardType: TextInputType.number,
              validator: true,
              onSaved: (value) {
                if (value != null) {
                  _personSallaryTextController.text = value;
                  context.read<PersonDetailCubit>().person?.sallary =
                      double.parse(value);
                }
              },
            ),
            buildSizedBox(height: 20),
            CustomTextFormFieldWidget(
              controller: _personJobDescriptionTextController,
              hintText: LocalizationKeys.WRITE.tr(),
              labelText: LocalizationKeys.PERSON_JOB_DESCRIPTION.tr(),
              validator: true,
              maxLines: 5,
              onSaved: (value) {
                if (value != null) {
                  _personJobDescriptionTextController.text = value;
                  context.read<PersonDetailCubit>().person?.jobDescription =
                      value;
                }
              },
            ),
            buildSizedBox(height: 20),
            CustomTextFormFieldWidget(
              controller: _personCompanyNameTextController,
              hintText: LocalizationKeys.WRITE.tr(),
              labelText: LocalizationKeys.PERSON_COMPANY.tr(),
              validator: true,
              onSaved: (value) {
                if (value != null) {
                  _personCompanyNameTextController.text = value;
                  context.read<PersonDetailCubit>().person?.companyName = value;
                }
              },
            ),
            buildSizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  showResult({
    required String title,
    required String bodyText,
    required bool isShowToast,
    required Color toastColor,
    String? toastText,
  }) {
    if (isShowToast) {
      _toastHelper.showToast(message: toastText ?? '', color: toastColor);
    }

    _dialogHelper.showDialog(context,
        title: title,
        body: Text(
          bodyText,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(kprimaryColor)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(LocalizationKeys.STAY_THIS_SCREEN.tr())),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kprimaryColor)),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const PersonListView(),
                      ));
                },
                child: Text(LocalizationKeys.GO_LIST_SCREEN.tr())),
          ),
        ]);
  }

  String? get identifierErrorText {
    String text = _personIdendityTextController.text;

    if (text.isNotEmpty) {
      var result = getIt<IdentifierHelper>().identificationNumberControl(text);

      if (result) {
        context.read<PersonIdentifierCubit>().changeTheState(value: true);
        return null;
      } else {
        context.read<PersonIdentifierCubit>().changeTheState(value: false);
        return LocalizationKeys.PERSON_IDENDITY_ERROR.tr();
      }
    }
    return null;
  }

  buildSizedBox({double? height, double? width}) => SizedBox(
        height: height,
        width: width,
      );

  @override
  bool get wantKeepAlive => true;
}
