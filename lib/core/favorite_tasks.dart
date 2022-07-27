import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/cubit/cubit.dart';
import 'package:to_do_app/features/cubit/states.dart';
import '../features/components/component.dart';
import '../features/views_models/task_builder.dart';


class FavoriteTasksScreen extends StatelessWidget {
  const FavoriteTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){

        var tasks = AppCubit.get(context).favoriteTasks;

        return TaskBuilder(tasks: tasks, noTasks: 'No Favorite Tasks..', taskType: 'favorite');
      },
    );
  }
}


class FavoriteTaskItem extends StatelessWidget {
  FavoriteTaskItem({Key? key, required this.model}) : super(key: key);

  Map model;

  @override
  Widget build(BuildContext context) {

    return ListTile(
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Center(
              child: Text(
                'TT',
              )),
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DefaultText(
              text: '${model['title']}',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              maxLines: 1,

            ),
          ],
        ),
        trailing: TextButton(onPressed: () {   AppCubit.get(context).deleteData(id: model['id'],);  }, child: Text('Delete'),)
    );
  }
}


