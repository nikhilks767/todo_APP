// ignore_for_file: prefer_const_constructors, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListCard extends StatefulWidget {
  const ListCard(
      {super.key,
      required this.title,
      this.onDeletePressed,
      this.onEditPressed});
  final String title;
  final Function(BuildContext)? onDeletePressed;
  final Function()? onEditPressed;
  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane:
          ActionPane(motion: StretchMotion(), extentRatio: 0.2, children: [
        SlidableAction(
          onPressed: widget.onDeletePressed,
          icon: Icons.delete,
          backgroundColor: Colors.red.shade400,
          borderRadius: BorderRadius.circular(10),
        )
      ]),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.yellow),
        child: ListTile(
          leading: Checkbox(
              value: isChecked,
              activeColor: Colors.green,
              onChanged: (value) {
                setState(() {
                  isChecked = value!;
                });
              }),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                    decoration: isChecked == true
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
              isChecked == true
                  ? Visibility(
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Colors.lightGreenAccent)),
                          child: Text("Completed")))
                  : SizedBox()
            ],
          ),
          trailing: InkWell(
            onTap: widget.onEditPressed,
            child: Icon(Icons.edit),
          ),
        ),
      ),
    );
  }
}
