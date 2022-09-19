import 'package:easy_localization/easy_localization.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mock_api_case_ersen_kocak/core/app/localization/localization_keys_constants.dart';
import 'package:flutter_mock_api_case_ersen_kocak/core/widgets/appbar/app_bar_widget.dart';
import 'package:flutter_mock_api_case_ersen_kocak/core/widgets/card/custom_card_widget.dart';
import 'package:flutter_mock_api_case_ersen_kocak/cubit/person_detail_cubit/person_detail_cubit.dart';
import 'package:flutter_mock_api_case_ersen_kocak/cubit/person_list_cubit/person_list_cubit.dart';
import 'package:flutter_mock_api_case_ersen_kocak/view/login/person/person_detail_view/person_detail_view.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../../core/app/constants/constants.dart';
import '../../../../core/helper/date_time_formatter_helper/date_formatter_helper.dart';
import '../../../../core/helper/dialog_helper/dialog_helper.dart';
import '../../../../core/helper/toast_helper/toast_helper.dart';
import '../../../../core/init/locator.dart';
import '../../../../core/widgets/custom_icon_button/custom_icon_button.dart';
import '../../../../core/widgets/custom_progress_indicator/custom_progress_indicator_widget.dart';
import '../../../../core/widgets/default_button/default_button.dart';
import '../../../../model/Person.dart';
import 'widgets/app_bar_actions/person_list_view_app_bar_actions.dart';

class PersonListView extends StatefulWidget {
  const PersonListView({super.key});

  @override
  State<PersonListView> createState() => _PersonListViewState();
}

class _PersonListViewState extends State<PersonListView>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _fabBubbleAnimationController;
  late Animation<double> _fabBubbleAnimation;
  late AutoScrollController _autoScrollController;
  final _dateFormatterHelper = getIt<DateFormatterHelper>();
  final _toastHelper = getIt<ToastHelper>();
  final _dialogHelper = getIt<DialogHelper>();

  @override
  void initState() {
    super.initState();

    context
        .read<PersonListCubit>()
        .pagingController
        .addPageRequestListener((pageKey) {
      context.read<PersonListCubit>().getPersonList(pageKey: pageKey + 1);
    });

    _fabBubbleAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 260));
    final curvedAnimation = CurvedAnimation(
        parent: _fabBubbleAnimationController, curve: Curves.easeInOut);
    _fabBubbleAnimation =
        Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    _autoScrollController = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      floatingActionButton: buildFabButton(),
      body: buildBody(),
    );
  }

  buildAppBar(BuildContext context) {
    return appBarWidget(
        AppBar().preferredSize.height,
        context,
        LocalizationKeys.PERSON_LIST_VIEW_APP_BAR_TITLE.tr(),
        _scaffoldKey,
        personListViewAppBarActions(context: context),
        null);
  }

  buildFabButton() {
    return FloatingActionBubble(
      iconData: Icons.keyboard_arrow_up_outlined,
      iconColor: Colors.white,
      onPress: () {
        _fabBubbleAnimationController.isCompleted
            ? _fabBubbleAnimationController.reverse()
            : _fabBubbleAnimationController.forward();
      },
      backGroundColor: ksecondaryColor,
      animation: _fabBubbleAnimation,
      items: [
        Bubble(
            icon: Icons.arrow_upward,
            iconColor: Colors.white,
            title: LocalizationKeys.PERSON_LIST_VIEW_FAB_BUTTON_UP.tr(),
            titleStyle: const TextStyle(color: Colors.white),
            bubbleColor: ksecondaryColor,
            onPress: () async {
              _fabBubbleAnimationController.reverse();
              scrollToBegin();
            }),
        Bubble(
            icon: Icons.arrow_upward,
            iconColor: Colors.white,
            title: LocalizationKeys.PERSON_LIST_VIEW_FAB_BUTTON_ADD_PERSON.tr(),
            titleStyle: TextStyle(color: Colors.white),
            bubbleColor: ksecondaryColor,
            onPress: () async {
              _fabBubbleAnimationController.reverse();
              onGoBack(dynamic value) async {
                // _productAuditBMSACubit.skipCount = 0;
                // _productAuditBMSACubit.pagingController.refresh();
              }

              Route route = CupertinoPageRoute(
                  builder: (context) => PersonDetailView(
                        isDetail: false,
                      ));
              Navigator.push(context, route).then(onGoBack);
            })
      ],
    );
  }

  buildBody() {
    return RefreshIndicator(
      color: ksecondaryColor,
      onRefresh: () async {
        refreshPagination();
      },
      child: PagedListView<int, Person>(
        scrollDirection: Axis.vertical,
        scrollController: _autoScrollController,
        physics: const BouncingScrollPhysics(),
        pagingController: context.read<PersonListCubit>().pagingController,
        builderDelegate: PagedChildBuilderDelegate(
            firstPageProgressIndicatorBuilder: (context) =>
                const CustomProgressIndicatorWidget(),
            newPageProgressIndicatorBuilder: (context) =>
                const CustomProgressIndicatorWidget(),
            noItemsFoundIndicatorBuilder: (context) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Text(
                  'Kritere Uygun Kişi Bulunmamaktadır.',
                  style: Theme.of(context).textTheme.copyWith().bodyLarge,
                  textAlign: TextAlign.center,
                ),
              );
            },
            firstPageErrorIndicatorBuilder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Veriler getirilirken bir sorun oluştu.\n Lütfen tekrar deneyin.',
                    style: Theme.of(context).textTheme.copyWith().bodyText1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 42),
                    child: DefaultButtonWidget(
                        text: 'Yenile', press: () => refreshPagination()),
                  ),
                ],
              );
            },
            itemBuilder: (context, item, index) {
              return InkWell(
                child: _buildCard(item),
                onTap: () {
                  // onGoBack(dynamic value) {
                  //   refreshPagination();
                  // }

                  var route = CupertinoPageRoute(
                      builder: (context) => PersonDetailView(
                            isDetail: true,
                            person: item,
                          ));
                  Navigator.push(context, route);
                },
              );
            }),
      ),
    );
  }

  _buildCard(Person item) {
    return CustomCardWidget(
      cardHeader: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(item.identity ?? ''),
              const Spacer(),
              item.birthDate != null
                  ? Tooltip(
                      message: LocalizationKeys.PERSON_BIRTH_DAY.tr(),
                      child: Text(
                        _dateFormatterHelper.dateFormat(
                          item.birthDate ?? '',
                          includeHours: false,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ],
      cardBody: [
        Expanded(
          child: ListTile(
            leading: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage("${item.imageUrl}"),
              backgroundColor: Colors.transparent,
            ),
            title: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Tooltip(
                  message: LocalizationKeys.PERSON_NAME_SURNAME.tr(),
                  child: Text(
                    '${item.name ?? ''} / ${item.surname ?? ''}',
                    style: Theme.of(context).textTheme.copyWith().bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Tooltip(
                  message: LocalizationKeys.PERSON_COMPANY.tr(),
                  child: Text(
                    item.companyName ?? '',
                    style: Theme.of(context).textTheme.copyWith().bodyMedium,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ],
      cardFooter: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                color: kprimaryColor,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Tooltip(
                      message: LocalizationKeys.PERSON_JOB_TITLE.tr(),
                      child: Text(
                        item.jobTitle!,
                        overflow: TextOverflow.ellipsis,
                      )),
                  CustomIconButton(
                    message:
                        LocalizationKeys.PERSON_LIST_VIEW_PERSON_DELETE.tr(),
                    icon: const Icon(Icons.delete),
                    callBack: () => deletePerson(personId: item.id!),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  deletePerson({required String personId}) {
    _dialogHelper.showDialog(context,
        title: LocalizationKeys.PERSON_LIST_VIEW_PERSON_DELETE_PROCESS.tr(),
        body: Text(
          LocalizationKeys.PERSON_LIST_VIEW_PERSON_DELETE_PROCESS_SURE.tr(),
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
                child: Text(LocalizationKeys.NO.tr())),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kprimaryColor)),
                onPressed: () async {
                  Navigator.pop(context);
                  EasyLoading.show();

                  await context
                      .read<PersonDetailCubit>()
                      .deletPerson(personId: personId)
                      .then((value) => {
                            if (value) refreshPagination(),
                            showResult(
                                title: LocalizationKeys.PROCESS_RESULT.tr(),
                                bodyText:
                                    '${LocalizationKeys.PERSON_PERSON.tr()} ${value ? LocalizationKeys.DELETE_SUCCESS.tr() : LocalizationKeys.DELETE_ERROR.tr()} ',
                                isShowToast: true,
                                toastText:
                                    '${LocalizationKeys.PERSON_LIST_VIEW_PERSON_DELETE_PROCESS.tr()} ${value ? LocalizationKeys.DELETE_SUCCESS.tr() : LocalizationKeys.DELETE_ERROR.tr()} ',
                                toastColor: value ? Colors.green : Colors.red),
                          });
                  EasyLoading.dismiss();
                },
                child: const Text('Evet')),
          ),
        ]);
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
                child: const Icon(
                  Icons.check,
                  color: ksecondaryColor,
                )),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: ElevatedButton(
          //       style: ButtonStyle(
          //           backgroundColor: MaterialStateProperty.all(kprimaryColor)),
          //       onPressed: () {
          //         Navigator.pop(context);
          //         Navigator.pushReplacement(
          //             context,
          //             CupertinoPageRoute(
          //               builder: (context) => const PersonListView(),
          //             ));
          //       },
          //       child: Text(LocalizationKeys.GO_LIST_SCREEN.tr())),
          // ),
        ]);
  }

  scrollToBegin() {
    _autoScrollController.jumpTo(0);
    _toastHelper.showToast(
        message: LocalizationKeys.POSITION_UP.tr(), color: ksecondaryColor);
  }

  refreshPagination() async {
    context.read<PersonListCubit>().personList?.clear();

    context.read<PersonListCubit>().pagingController.refresh();
  }
}
