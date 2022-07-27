import 'package:calender_picker/date_picker_widget.dart';
import 'package:flutter/material.dart';

import '../features/components/component.dart';
import 'all_tasks.dart';


class Calender extends StatefulWidget {
  const Calender({Key? key}) : super(key: key);

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:   SafeArea(
          child: Column(
            children: <Widget>[
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
                    width: 15,
                  ),
                  const Text(
                    'Schedule',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  myDivider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: CalenderPicker(
                      DateTime.now(),
                      initialSelectedDate: DateTime.now(),
                      selectionColor: Colors.green,
                      selectedTextColor: Colors.white,
                      onDateChange: (date) {
                        // New date selected
                        setState(() {

                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  myDivider(),
                ],
              ),
              Expanded(child:
              AllTasks()
              )
              ,
            ],
          ),
        )
    );
  }
}


