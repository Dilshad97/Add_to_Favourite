import 'package:app/favourite.dart';
import 'package:app/home_screen.dart';
import 'package:app/Provider/provider.dart';
import 'package:badges/badges.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Tab Bar
class Bar extends StatefulWidget {
  const Bar({Key? key}) : super(key: key);

  @override
  State<Bar> createState() => _BarState();
}

class _BarState extends State<Bar> {
  @override
  Widget build(BuildContext context) {
    var bookmarkBloc = Provider.of<BookmarkBloc>(context);
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: TextButton(
                  child:
                      const Text("Sort", style: TextStyle(color: Colors.blue)),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const MyDialog();
                      },
                    );
                  },
                ),
              )
            ],
            bottom: TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              tabs: [
                const Tab(text: "All"),
                Badge(
                    badgeContent: Text(bookmarkBloc.count.toString()),
                    child: const Tab(text: "Favourite"))
              ],
            ),
          ),
          body: const TabBarView(
            children: [HomeScreen(), Favourite()],
          ),
        ),
      ),
    );
  }
}

class MyDialog extends StatefulWidget {
  const MyDialog({Key? key}) : super(key: key);

  @override
  _MyDialogState createState() => _MyDialogState();
}

//Diologue box for sorting radiobutton extends statefull class
class _MyDialogState extends State<MyDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: fList
            .map(
              (data) => RadioListTile(
                title: Text(data.name),
                groupValue: id,
                value: data.index,
                onChanged: (val) {
                  setState(() {
                    radioItem = data.name;
                    id = data.index;
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }

  String radioItem = 'Price low to high';
  int id = 1;

  List<FruitsList> fList = [
    FruitsList(
      index: 1,
      name: "Price high to low",
    ),
    FruitsList(
      index: 2,
      name: "Price low to high",
    ),
    FruitsList(
      index: 3,
      name: "Rating 5-1",
    ),
  ];
}

class FruitsList {
  String name;
  int index;

  FruitsList({required this.name, required this.index});
}
