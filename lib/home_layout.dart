import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/cupertino.dart';
import 'core/calender_screen.dart';
import 'core/uncompleted_tasks.dart';
import 'features/components/component.dart';
import 'core/all_tasks.dart';
import 'core/completed_tasks.dart';
import 'core/favorite_tasks.dart';
import 'features/cubit/cubit.dart';
import 'features/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController();
  var dateController = TextEditingController();
  TimeOfDay initialStartTime = TimeOfDay.now();
  TimeOfDay initialEndTime =
  TimeOfDay.fromDateTime(DateTime.now().add(const Duration(minutes: 1)));
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {
        if (state is AppInsertTaskState) {
          Navigator.pop(context);
        }
      },
      builder: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          backgroundColor: lightBlue,
          key: scaffoldKey,
          appBar: AppBar(
            elevation: 0.6,
            backgroundColor: Colors.white,
            title: const Text(
              "Board",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.calendar_month,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Calender();
                  }));
                },
              ),
            ],
          ),
          body:DefaultTabController(
            length: 4,
            child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                elevation: 0.6,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                title: const TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(
                      child: Text(
                        'All',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Tab(
                        child: Text(
                          'Completed',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )),
                    Tab(
                        child: Text(
                          'UnCompleted',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )),
                    Tab(
                        child: Text(
                          'Favarite',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )),
                  ],
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.black,
                  indicatorWeight: 2.0,
                  //   labelStyle: TextStyle(color: Colors.black,fontSize: 30),
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.black,
                ),
              ),
              body:    const TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  dragStartBehavior: DragStartBehavior.down,
                  children: [
                    AllTasks(),
                    CompletedTasks(),
                    UncompletedTasks(),
                    CompletedTasks(),
                  ]),
            ),
          ),


          floatingActionButton: Container(
            width: 360,
            // width: 200,
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Add Task',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          myDivider(),
                          const SizedBox(
                            height: 5,
                          ),
                          //---------------------------title--------------------------------------
                          Row(
                            children: const [
                              Text(
                                'Title',
                                style: TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          DefaultFormField(
                            controller: titleController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Title must not be empty';
                              }
                              return null;
                            },
                            labelText: 'Task Title',
                            textColor: Colors.black,
                            prefixIcon: const Icon(
                              Icons.title_outlined, color: lightBlue,),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          //---------------------------Date--------------------------------------
                          Row(
                            children: const [
                              Text(
                                'Date',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: DefaultFormField(
                              controller: dateController,
                              keyboardType: TextInputType.datetime,
                              onTap: () {
                                showDatePicker(context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2024-01-07'),
                                ).then((value) {
                                  selectedDate = value;
                                  dateController.text = DateFormat.yMMMd()
                                      .format(value!)
                                      .toString();
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Date must not be empty';
                                }
                                return null;
                              },
                              labelText: 'Task Date',
                              textColor: white,
                              prefixIcon: const Icon(
                                Icons.date_range_outlined,
                                color: lightBlue,),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          //---------------------------Start Time& End time--------------------------------------
                          Row(
                            children: const [
                              Text(
                                'Start Time                            Start Time',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: DefaultFormField(
                                  controller: startTimeController,
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: initialStartTime,
                                    ).then((value) {
                                      selectedStartTime = value;
                                      startTimeController.text =
                                          selectedStartTime!.format(
                                              context).toString();
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Start Time must not be empty';
                                    }
                                    return null;
                                  },
                                  labelText: 'Start Time',
                                  textColor: white,
                                  prefixIcon: const Icon(
                                    Icons.timer, color: lightBlue,),
                                  keyboardType: TextInputType.datetime,
                                ),
                              ),
                              Expanded(
                                child: DefaultFormField(
                                  controller: endTimeController,
                                  onTap: () {
                                    showTimePicker(

                                      context: context,
                                      initialTime: initialEndTime,
                                    ).then((value) {
                                      if (value!.hour.toDouble() >
                                          selectedStartTime!.hour
                                              .toDouble()) {
                                        selectedEndTime = value;
                                        endTimeController.text =
                                            selectedEndTime!.format(
                                                context).toString();
                                      } else if (value.hour.toDouble() ==
                                          selectedStartTime!.hour
                                              .toDouble()
                                          && value.minute.toDouble() >=
                                              selectedStartTime!.minute
                                                  .toDouble()) {
                                        selectedEndTime = value;
                                        endTimeController.text =
                                            selectedEndTime!.format(
                                                context).toString();
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "End Time can't be before Start Time",
                                            toastLength: Toast
                                                .LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: darkBlue,
                                            fontSize: 16.0
                                        );
                                      }
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'End Time must not be empty';
                                    }
                                    return null;
                                  },
                                  labelText: 'End Time',
                                  textColor: white,
                                  prefixIcon: const Icon(
                                    Icons.timer_off_outlined,
                                    color: lightBlue,),
                                  keyboardType: TextInputType.datetime,
                                ),
                              ),
                            ],
                          ),
                          //---------------------------DropDown--------------------------------------
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: const [
                              Text(
                                'Remind',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: black, width: 0.3),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: BlocBuilder<AppCubit, AppStates>(
                                builder: (BuildContext context, state) {
                                  return DropdownButton(
                                      isExpanded: true,
                                      dropdownColor: Colors.white,
                                      icon: Padding(
                                        padding: EdgeInsetsDirectional.only(end: 3),
                                        child: const Icon(Icons.keyboard_arrow_down, color: lightBlue,),
                                      ),
                                      value: cubit.dropDownValue,
                                      items: cubit.dropDownListItems.map((String items) {
                                        return DropdownMenuItem(
                                            value: items,
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.only(start: 3),
                                              child: DefaultText(text: items, color: Colors.black,),
                                            )
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) => cubit.changeDropDownListValue(newValue!)
                                  );
                                },
                              ),
                            ),
                          ),
                          //---------------------------Repeat--------------------------------------
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: const [
                              Text(
                                'Repeat',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: DropDown<String>(
                              items: const <String>[
                                "daily",
                                "Weakly",
                                "monthly"
                              ],
                              icon: const Icon(
                                Icons.expand_more,
                                color: Colors.blue,
                              ),
                              customWidgets: <Widget>[
                                Row(
                                  children: const <Widget>[
                                    Text("daily"),
                                  ],
                                ),
                                Row(
                                  children: const <Widget>[
                                    Text("Weakly"),
                                  ],
                                ),
                                Row(
                                  children: const <Widget>[
                                    Text("monthly"),
                                  ],
                                )
                              ],
                              hint: const Text("Select Repeat Time"),
                              onChanged: print,
                            ),

                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          //---------------------------Button--------------------------------------
                          const Spacer(),
                          SizedBox(
                            width:  MediaQuery.of(context).size.width,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.insertToDatabase(
                                      title: titleController.text,
                                      startTime: startTimeController.text,
                                      endTime: endTimeController.text,
                                      date: dateController.text,
                                      reminder: cubit.dropDownValue,
                                    );
                                    cubit.setReminder(titleController.text, selectedDate!,
                                        selectedStartTime!, cubit.dropDownValue);
                                  }else{
                                    debugPrint('@@@@###');
                                  }
                                },
                                child: const Text("Create A Task")),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: const Text(
                'Add a task',
              ),
            ),
          ),

        );
      },
    );
  }
}
