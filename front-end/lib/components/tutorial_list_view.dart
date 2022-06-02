import 'package:flutter/material.dart';
import 'package:softwaretutorials/api/tutorial_service.dart';
import 'package:softwaretutorials/models/models.dart';
import '../components/components.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';

class TutorialListView extends StatefulWidget {
  
  @override
  State<TutorialListView> createState() => _TutorialListViewState();
}

class _TutorialListViewState extends State<TutorialListView> {
  late Future<List<Tutorial?>> tutorialListFuture;
  late List<Tutorial?> tutorialList;

  @override
	void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tab = Provider.of<AppStateManager>(context, listen:false).getSelectedTab;
	final role = Provider.of<AppStateManager>(context, listen:false).sharedPreferences.get("role");
	if (tab == 0 || tab == 1)
		tutorialListFuture = TutorialService.getAllTutorials(context);
	else if (tab == 2 && role == "INSTRUCTOR")
		tutorialListFuture = TutorialService.getMyTutorials(context);
	else
	    tutorialListFuture = TutorialService.getEnrolledTutorials(context);
	return Container(
	width: double.infinity,
	height: double.infinity,
	color: Color(0xff471F7A),
	padding: EdgeInsets.only(top:10, left:10, right:10),
	child: Stack(
		children: <Widget> [
		Positioned(
			right: 0,
			top: 0,
			child: ClipPath(
            clipper: TopRightClipper(),
            child: Container(
              color: Colors.purple.withOpacity(.8),
            ),
          ),
		),
		FutureBuilder(
			future: tutorialListFuture,
			builder: (context, snapshot) {
		  	if (snapshot.connectionState == ConnectionState.done){
		  		tutorialList = snapshot.data as List<Tutorial>;
		  		print("Snap data "+snapshot.data.toString());

			    return
		  		Column(
		  		  children: [
		  		    Expanded(
		  		      child: ListView.separated(
						itemCount: tutorialList.length,
						itemBuilder: (BuildContext context, int index) {
							return TutorialCard(tutorial: tutorialList[index]!);
						},
						separatorBuilder: (BuildContext context, int index) {
							return SizedBox(height: 20);
						},
					),
		  		    ),
							SizedBox(height: 10,)
		  		  ],
		  		);
				} else{
		  		return Center( child:CircularProgressIndicator());
				}
		},)
		]
	),
	);
  }
}