import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:my_macos_app/blocs/project/project_bloc.dart';
import 'package:my_macos_app/core/constants/app_assets.dart';
import 'package:my_macos_app/core/theme/app_colors.dart';
import 'package:my_macos_app/models/projects.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class ConfigureDrawer extends StatefulWidget {
  const ConfigureDrawer({
    super.key,
    required this.size,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  final Size size;
  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  State<ConfigureDrawer> createState() => _ConfigureDrawerState();
}

class _ConfigureDrawerState extends State<ConfigureDrawer> {
  List<Project>? selectedProjects = <Project>[];
  DateTime startDate = DateTime.now();
  DateTime toDate = DateTime.now();
  DateFormat format = DateFormat.jm();

  late ProjectBloc projectBloc;

  Future<void> onAppBlocChange(
      {required BuildContext context, required ProjectState state}) async {
    if (state is UpdateProfileSuccess) {
      
      widget._scaffoldKey.currentState?.closeEndDrawer();
    } else if (state is ProjectAppState) {
      selectedProjects = context
              .read<ProjectBloc>()
              .projectAppState
              .user
              ?.user
              ?.workingProjects ??
          [];
      startDate = DateTime.parse(context
              .read<ProjectBloc>()
              .projectAppState
              .user
              ?.user
              ?.workingHours
              ?.startTime ??
          DateTime.now().toString());
      toDate = DateTime.parse(context
              .read<ProjectBloc>()
              .projectAppState
              .user
              ?.user
              ?.workingHours
              ?.endTime ??
          DateTime.now().toString());
    }
  }

  @override
  void initState() {
    projectBloc = context.read<ProjectBloc>();
    projectBloc.add(GetProfile());
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      projectBloc.stream.listen((ProjectState state) =>
          mounted ? onAppBlocChange(context: context, state: state) : null);
    });

    // projectBloc.add(GetProjects());

    // _appBloc.stream.listen((AppState state) =>
    //     (mounted ? onAppBlocChange(context: context, state: state) : null));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        return Drawer(
          width: widget.size.width * 0.5,
          backgroundColor: Colors.white,
          child: SizedBox(
            width: widget.size.width * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      widget._scaffoldKey.currentState?.closeEndDrawer();
                    },
                    child: Center(
                      child: Image.asset(
                        AppAssets.shrinkIcon,
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                ),
                Image.asset(AppAssets.configureText),
                Container(
                  width: widget.size.width * 0.35,
                  color: AppColors.lightBlueColor1,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    children: [
                      const Text(
                        'Configure Me!',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      const Text(
                        'Working Projects',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(20),
                        child: DropdownButtonHideUnderline(
                          child: GFDropdown<Project>(
                            focusColor: Colors.white,
                            iconEnabledColor: AppColors.blueColor,
                            hint: const Text('Working projects'),
                            itemHeight: 60,
                            borderRadius: BorderRadius.circular(10),
                            border: const BorderSide(
                                color: Colors.black12, width: 1),
                            dropdownButtonColor: Colors.white,
                            onChanged: (newValue) {
                              
                              setState(() {
                                if (selectedProjects
                                        ?.where((e) => e.id == newValue?.id)
                                        .isNotEmpty ??
                                    false) {
                                  selectedProjects?.remove(newValue);
                                } else {
                                  selectedProjects?.add(newValue ?? Project());
                                }
                              });
                            },
                            items: projectBloc
                                .projectAppState.projects?.projects
                                ?.map((value) => DropdownMenuItem(
                                      value: value,
                                      child: Container(
                                          margin: const EdgeInsets.all(2),
                                          padding: const EdgeInsets.all(8),
                                          color: AppColors.lightBlueColor1,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(value.name ?? ''),
                                              (selectedProjects
                                                          ?.where((e) =>
                                                              e.id == value.id)
                                                          .isNotEmpty ??
                                                      false)
                                                  ? const Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green,
                                                    )
                                                  : Container()
                                            ],
                                          )),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                      Wrap(
                        children: [
                          ...?selectedProjects?.map((e) => Container(
                                padding: const EdgeInsets.all(8),
                                margin:
                                    const EdgeInsets.only(right: 10, top: 10),
                                decoration: BoxDecoration(
                                    color: AppColors.blackColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  e.name ?? '',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      const Text(
                        'Working Hours',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            // fontStyle: FontStyle.italic,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Start From:',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            // fontStyle: FontStyle.italic,
                            color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () async {
                          List<DateTime>? dates =
                              await showOmniDateTimeRangePicker(
                                  context: context,
                                  startInitialDate: startDate,
                                  endInitialDate: toDate);
                          if (dates != null && (dates.isNotEmpty)) {
                            setState(() {
                              startDate = dates.first;
                              toDate = dates.last;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            format.format(startDate),
                            style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w500,
                                // fontStyle: FontStyle.italic,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      const Text(
                        'To:',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            // fontStyle: FontStyle.italic,
                            color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () async {
                          List<DateTime>? dates =
                              await showOmniDateTimeRangePicker(
                                  context: context,
                                  startInitialDate: startDate,
                                  endInitialDate: toDate);
                          if (dates != null && (dates.isNotEmpty)) {
                            setState(() {
                              startDate = dates.first;
                              toDate = dates.last;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            format.format(toDate),
                            style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (state is! ProjectLoading) {
                            // print(
                            //     '////////////////////////date ${startDate.toUtc()}');
                            projectBloc.add(UpdateProfile(objToApi: {
                              "user": {
                                "working_project_ids": selectedProjects == null
                                    ? []
                                    : (selectedProjects
                                            ?.map((e) => e.id)
                                            .toList() ??
                                        []),
                                "working_hours": {
                                  "start_time": startDate.toLocal().toString(),
                                  "end_time": toDate.toLocal().toString()
                                }
                              }
                            }));
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                          child: state is ProjectLoading
                              ? const CupertinoActivityIndicator(
                                  color: AppColors.blackColor,
                                )
                              : const Text(
                                  'Update',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
