import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/cubit/cubit.dart';
import 'package:to_do_app/features/cubit/states.dart';

import '../features/components/component.dart';
import '../features/views_models/task_builder.dart';


class AllTasks extends StatelessWidget {
  const AllTasks({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){

        var tasks = AppCubit.get(context).allTasks;

        return TaskBuilder(tasks: tasks, noTasks: 'Still Empty ...', taskType: 'all');
      },
    );
  }
}

class AllTaskItem extends StatelessWidget {
  AllTaskItem({Key? key, required this.model}) : super(key: key);

  Map model;
  int x = 0;

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
            fontSize: 20,
            fontWeight: FontWeight.bold,
            maxLines: 1,

          ),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {
          var size = MediaQuery
              .of(context)
              .size;
          showDialog(

            context: context,
            builder: (BuildContext context) =>
                Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(

                    height: size.height * 0.20,
                    width: size.height * 0.15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white
                    ),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        MaterialButton(
                          minWidth: size.width * 0.35,
                          onPressed: () {
                            AppCubit.get(context).changeStatus(
                              status: 'completed',
                              id: model['id'],
                            );
                            Navigator.pop(context);
                          },

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                              'Complete',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline6!

                          ),
                        ),
                        MaterialButton(
                          minWidth: size.width * 0.35,
                          onPressed: () {
                            AppCubit.get(context).changeStatus(
                              status: 'uncompleted',
                              id: model['id'],
                            );
                            Navigator.pop(context);
                          },

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                              'UnComplete',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline6!

                          ),
                        ),
                        MaterialButton(
                          minWidth: size.width * 0.35,
                          onPressed: () {
                            AppCubit.get(context).changeStatus(
                              status: 'favorite',
                              id: model['id'],
                            );
                            Navigator.pop(context);
                          },

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                              'favorite',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline6!

                          ),
                        ),

                      ],
                    ),
                  ),
                ),
          );
        },
      ),
    );
  }
}


