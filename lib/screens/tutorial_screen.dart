import 'package:flutter/material.dart';
import 'package:softwaretutorials/api/tutorial_service.dart';
import '../components/components.dart';
import 'package:softwaretutorials/models/models.dart';
import 'package:softwaretutorials/screens/screens.dart';
import 'package:provider/provider.dart';

class TutorialScreen extends StatelessWidget {
  TutorialScreen({Key? key}) : super(key: key);
  
  static MaterialPage page() {
	return MaterialPage(
		name: TutorialPages.allTutorialsPath,
		key: ValueKey(TutorialPages.allTutorialsPath),
		child: TutorialScreen(),
		);
	}
  
  @override
  Widget build(BuildContext context)  {
   final prov = Provider.of<AppStateManager>(context, listen:false);
    final role = prov.sharedPreferences.get("role");
	final tab = prov.getSelectedTab;
	return Scaffold(
		appBar: tab == 3 ? AppBar(
		     centerTitle: true,
		     title: Text("Create Tutorial"),
			 actions: [
				Container(
					margin: EdgeInsets.only(right:10),
					child: IconButton(icon:Icon(Icons.check, size:25), onPressed:() async {
					    final key = prov.createTutorialFormKey;
						if (key.currentState!.validate()){
						    if (prov.tutorial != null){
								final res = await TutorialService.updateTutorial(
							        title: prov.titleController.text,
									content: prov.contentController.text, 
									projectTitle: prov.projectTitleController.text,
									problemStatement: prov.problemStatementController.text,
									tutorialId: prov.tutorial!.tutorialId!,
									context: context
								);
							} else {
								final res = await TutorialService.createTutorial(
							        title: prov.titleController.text,
									content: prov.contentController.text, 
									projectTitle: prov.projectTitleController.text,
									problemStatement: prov.problemStatementController.text,
									context: context);
							
							}
							
							prov.tutorial = null;
							prov.destroyControllers();
							prov.goToTab(0);
						}
					})
				),
			],
			 
			 ): CustomAppBar(
		     tit: Text("All Tutorials")),
		drawer: SafeArea(child:CustomDrawer.get(context)),
		body: tab == 3 ? CreateTutorialScreen(): TutorialListView(),
		bottomNavigationBar: BottomNavigationBar(
		    type: BottomNavigationBarType.fixed,
		    currentIndex: Provider.of<AppStateManager>(context).getSelectedTab,
			onTap: (index) {
				if (index != 3){
					prov.tutorial = null;
				}
				prov.goToTab(index);
			},
			items: <BottomNavigationBarItem>[
			const BottomNavigationBarItem(
				icon: Icon(Icons.explore),
				label: 'All Tutorials',
			),
			const BottomNavigationBarItem(
				icon: Icon(Icons.search),
				label: 'Search tutorial',
			),
			if (role == "CLIENT")
			const BottomNavigationBarItem(
				icon: Icon(Icons.book),
				label: 'Enrolled Tutorials',
			),
			if (role == "INSTRUCTOR")
			const BottomNavigationBarItem(
				icon: Icon(Icons.book),
				label: 'My Tutorials',
			),
			if (role == "INSTRUCTOR")
			const BottomNavigationBarItem(
				icon: Icon(Icons.add),
				label: 'Create Tutorial',
			),
			],
			
		),
	);
  }

}