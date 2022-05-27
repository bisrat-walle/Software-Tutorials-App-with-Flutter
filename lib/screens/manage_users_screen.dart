import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:softwaretutorials/models/models.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen();
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<bool> selected = List<bool>.generate(20, (int index) => false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin")),
      drawer: Drawer(
        backgroundColor: Colors.teal,
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
                        child: Image(
                      image: AssetImage(
                        "assets/images/img.png",
                      ),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text("Ethio Tutorial"),
                        Text("Admin")
                      ],
                    )
                  ],
                )),
            ListTile(
                title: TextButton(
                  child: Text("Manage Users",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {},
                ),
                leading: Icon(Icons.people)),
            ListTile(
                title: TextButton(
                  child: Text("Manage Tutorials",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {},
                ),
                leading: Icon(Icons.school)),
            ListTile(
                title: TextButton(
                  child: Text(
                    "Statistics",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {},
                ),
                leading: Icon(Icons.numbers))
          ],
        ),
      ),
      body: Stack(children: [
        Container(
            child: SvgPicture.asset("assets/images/admin_bg.svg",
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover)),
        Container(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 10, top: 30, right: 10),
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Username"),
                      SizedBox(width: 30),
                      IconButton(
                        icon: Icon(Icons.arrow_drop_up),
                        onPressed: () {},
                      ),
                      Text("Actions")
                    ],
                  )),
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(left: 10, right: 10),
                padding: EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "search",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {},
                      )),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 150, left: 10, right: 10),
          padding: EdgeInsets.only(left: 10, right: 10),
          color: Colors.white,
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text('All Tutorials'),
                  ),
                ],
                rows: List<DataRow>.generate(
                  20,
                  (int index) => DataRow(
                    color: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      // All rows will have the same selected color.
                      if (states.contains(MaterialState.selected)) {
                        return Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.08);
                      }
                      // Even rows will have a grey color.
                      if (index.isEven) {
                        return Colors.grey.withOpacity(0.3);
                      }
                      return null; // Use default value for other states and odd rows.
                    }),
                    cells: <DataCell>[
                      DataCell(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tutorial$index'),
                            IconButton(
                              icon: Icon(Icons.more_horiz_outlined),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      )
                    ],
                    selected: selected[index],
                    onSelectChanged: (bool? value) {
                      setState(() {
                        selected[index] = value!;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
