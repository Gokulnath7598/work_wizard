import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_macos_app/blocs/daily_task/daily_task_bloc.dart';
import 'package:my_macos_app/blocs/project/project_bloc.dart';
import 'package:my_macos_app/core/constants/app_assets.dart';
import 'package:my_macos_app/core/theme/app_colors.dart';
import 'package:my_macos_app/models/daily_task.dart';
import 'package:my_macos_app/views/home/configure_drawer.dart';
import 'package:timelines/timelines.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showTimeline = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 100),
            child: TextButton(
              onPressed: () {
                setState(() {
                  showTimeline = !showTimeline;
                });
              },
              child: Text(
                showTimeline ? 'Home Page' : 'Timeline',
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      endDrawer: BlocProvider(
        create: (context) => ProjectBloc(),
        child: ConfigureDrawer(size: size, scaffoldKey: _scaffoldKey),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                alignment: Alignment.centerRight,
                image: AssetImage(AppAssets.configureBg),
                fit: BoxFit.scaleDown)),
        child: Row(
          children: [
            showTimeline
                ? const TimeLineWidget()
                : BlocProvider(
                    create: (context) => DailyTaskBloc(),
                    child: AddTaskWidget(size: size),
                  ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: InkWell(
                      onTap: () {
                        _scaffoldKey.currentState?.openEndDrawer();
                      },
                      child: Center(
                        child: Image.asset(
                          AppAssets.expandIcon,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TimeLineWidget extends StatefulWidget {
  const TimeLineWidget({super.key});

  @override
  State<TimeLineWidget> createState() => _TimeLineWidgetState();
}

class _TimeLineWidgetState extends State<TimeLineWidget> {
  DateTime focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.all(20),
      height: 800,
      width: size.width * 0.5,
      child: ListView(
        shrinkWrap: true,
        children: [
          EasyInfiniteDateTimeLine(
            controller: EasyInfiniteDateTimelineController(),
            firstDate: DateTime(2024),
            focusDate: focusDate,
            lastDate: DateTime(2024, 12, 31),
            onDateChange: (selectedDate) {
              setState(() {
                focusDate = selectedDate;
              });
            },
          ),
          const SizedBox(
            height: 100,
          ),
          Timeline.tileBuilder(
            clipBehavior: Clip.none,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            builder: TimelineTileBuilder.fromStyle(
              addRepaintBoundaries: false,
              contentsAlign: ContentsAlign.basic,
              indicatorStyle: IndicatorStyle.outlined,
              contentsBuilder: (context, index) => const Padding(
                padding: EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Lorem ipsum dolor sit amet'),
                    SizedBox(
                      width: 50,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('3 Hrs'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Actual'),
                      ],
                    ),
                  ],
                ),
              ),
              oppositeContentsBuilder: (context, index) => const Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('11:00'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Rise'),
                  ],
                ),
              ),
              itemCount: 10,
            ),
          )
        ],
      ),
    );
  }
}

class AddTaskWidget extends StatefulWidget {
  const AddTaskWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  late DailyTaskBloc dailyTaskBloc;
  TextEditingController _taskNameController = TextEditingController();

  @override
  void initState() {
    dailyTaskBloc = context.read<DailyTaskBloc>();
    dailyTaskBloc.add(GetDailyTasks());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width * 0.5,
      child: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 50,
        ),
        children: [
          const Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.blackColor,
              ),
              SizedBox(
                width: 20,
                height: 0,
              ),
              Text(
                'Hi, Gokulnath!',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    color: Colors.black),
              ),
            ],
          ),
          const SizedBox(
            width: 20,
            height: 20,
          ),
          const Text(
            'Let’s plan the day!',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                color: AppColors.blackColor),
          ),
          const SizedBox(
            width: 20,
            height: 20,
          ),
          const Text(
            'Today’s Tasks',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          const SizedBox(
            width: 20,
            height: 20,
          ),
          TextFormField(
            controller: _taskNameController,
            decoration: InputDecoration(
              hintText: "Today's Task",
              hintStyle: const TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(8)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(
            width: 20,
            height: 20,
          ),
          BlocBuilder<DailyTaskBloc, DailyTaskState>(
            builder: (context, state) {
              return Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.start,
                children: [
                  ...?dailyTaskBloc.dailyTaskAppState.dailyTasks?.dailyTasks
                      ?.map((e) => TaskWidget(
                            dailyTask: e,
                          )),
                  state is DailyTaskLoading
                      ? const CupertinoActivityIndicator(
                          color: AppColors.blueColor,
                        )
                      : Container()
                ],
              );
            },
          ),
          const SizedBox(
            width: 20,
            height: 20,
          ),
          Container(
              width: 280,
              height: 56,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppColors.blueColor),
              child: TextButton(
                onPressed: () {
                  dailyTaskBloc
                      .add(AddDailyTask(name: _taskNameController.text));
                  _taskNameController.clear();
                },
                child: const Text(
                  'Add Task',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              )),
        ],
      ),
    );
  }
}

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key, this.dailyTask});

  final DailyTask? dailyTask;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyTaskBloc, DailyTaskState>(
      builder: (context, state) {
        return FittedBox(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColors.lightBlueColor),
            child: Center(
                child: Row(
              children: [
                Text(dailyTask?.taskDesc ?? ''),
                InkWell(
                  onTap: () {
                    if (state is! DailyTaskDeleteLoading) {
                      context
                          .read<DailyTaskBloc>()
                          .add(DeleteDailyTask(id: dailyTask?.id));
                    }
                  },
                  child: const Icon(
                    Icons.close,
                    size: 24,
                    color: AppColors.blackColor,
                  ),
                )
              ],
            )),
          ),
        );
      },
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   static const platform = const MethodChannel('overlay_channel');

//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter macOS Overlay Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 platform.invokeMethod('showOverlay');
//               },
//               child: const Text('Show Overlay'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 platform.invokeMethod('closeOverlay');
//               },
//               child: const Text('Close Overlay'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
