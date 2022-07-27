import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:to_do_app/core/all_tasks.dart';
import 'package:to_do_app/core/completed_tasks.dart';
import 'package:to_do_app/core/favorite_tasks.dart';
import 'package:to_do_app/core/uncompleted_tasks.dart';



class TaskBuilder extends StatelessWidget {
  TaskBuilder({Key? key, required this.taskType, required this.noTasks, required this.tasks}) : super(key: key);

  List<Map> tasks;
  String noTasks;
  String taskType;


  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) =>  ListView.separated(
        itemBuilder: (context, index) {
          if(taskType == 'uncompleted') {
            return DoneTaskItem(model: tasks[index],);
          }else if(taskType == 'completed') {
            return CompletedTaskItem(model: tasks[index],);
          }else if(taskType == 'favourite') {
            return   FavoriteTaskItem(model: tasks[index],);
          }else {
            return AllTaskItem(model: tasks[index]);
          }
        },
        separatorBuilder: (context, index) => Row(
          children: [
            Expanded(child: Divider(height: 1.h, color: Colors.black45)),
          ],
        ),
        itemCount: tasks.length,
      ),
      fallback: (context) =>  Center(child: const CircularProgressIndicator()),
    );
  }
}
