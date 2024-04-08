// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, use_build_context_synchronously, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:todo/controller/home_screen_controller.dart';
import 'package:todo/view/widget/list_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    HomeScreenController.initKeys();
    super.initState();
  }

  TextEditingController titlecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          "TODO",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Icon(Icons.search),
          SizedBox(width: 30),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: HomeScreenController.todoListKeys.length,
              itemBuilder: (context, index) {
                final currentKey = HomeScreenController.todoListKeys[index];
                final currentElement =
                    HomeScreenController.myBox.get(currentKey);
                return ListCard(
                  title: currentElement["title"],
                  onDeletePressed: (BuildContext) async {
                    await HomeScreenController.deleteTask(currentKey);
                    setState(() {});
                  },
                  onEditPressed: () {
                    titlecontroller.text = currentElement["title"];
                    customShowDialog(
                        context: context, isEdit: true, currentKey: currentKey);
                  },
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 20),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          height: 50,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: Colors.black),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 1, top: 5, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Add a Task",
                  style: TextStyle(color: Colors.white),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: InkWell(
                    onTap: () {
                      titlecontroller.clear();
                      customShowDialog(context: context);
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> customShowDialog(
      {required BuildContext context, bool isEdit = false, var currentKey}) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: Colors.yellow.shade300,
              content: Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextFormField(
                      controller: titlecontroller,
                      maxLines: 2,
                      decoration: InputDecoration(
                          hintText: "Title",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              if (isEdit == true) {
                                HomeScreenController.editTask(
                                    key: currentKey,
                                    title: titlecontroller.text);
                              } else {
                                if (titlecontroller.text.isNotEmpty) {
                                  await HomeScreenController.addTask(
                                      title: titlecontroller.text);
                                } else {
                                  SizedBox();
                                }
                              }
                              Navigator.pop(context);
                              setState(() {});
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.yellowAccent[400])),
                            child: Text(
                              isEdit == true ? "Edit" : "Add",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            )),
                        SizedBox(width: 10),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.yellowAccent[400])),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
