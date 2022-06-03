import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen();
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(height: 10, color: Colors.red,);
                },
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
