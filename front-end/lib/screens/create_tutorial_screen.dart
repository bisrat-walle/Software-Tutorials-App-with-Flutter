import 'package:flutter/material.dart';
import 'package:softwaretutorials/api/tutorial_service.dart';
import '../components/components.dart';
import 'package:provider/provider.dart';
import 'package:softwaretutorials/models/models.dart';

class CreateTutorialScreen extends StatefulWidget {
  
	
  CreateTutorialScreen({Key? key}) : super(key: key);
  
  @override
  State<CreateTutorialScreen> createState() => _CreateTutorialScreenState();
}

class _CreateTutorialScreenState extends State<CreateTutorialScreen> {

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AppStateManager>(context, listen:false);
	prov.initializeControllers();
	
    return Align(
			alignment: Alignment.topCenter,
            child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color:Colors.black.withOpacity(.1)),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                constraints: BoxConstraints(maxWidth:600),
                child: Form(
										key: Provider.of<AppStateManager>(context, listen:false).createTutorialFormKey,
										child: SingleChildScrollView(
                  //   controller: controller,
                    child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Container(
                              margin: EdgeInsets.only(top:8, left:8, right:8),
							padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border.all(color:Colors.black.withOpacity(.1)),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [

									Container(
										decoration: BoxDecoration(
											border: Border(bottom:BorderSide(
												width: 1,color:Colors.black.withOpacity(.1))),
										),
										margin: EdgeInsets.only(bottom: 10),
										width: double.infinity,
										child: Text("Enter tutorial title", style: Theme.of(context).textTheme.headline2)
									),

									Container(
										child:TextFormField(
											validator: (value){
												if (value!.isEmpty || value == null || value.length < 15){
													return "Tutorial title is required and must be at least 15 chars";
												}
											},
											controller:prov.titleController,
											decoration: InputDecoration(
												border: OutlineInputBorder(
													borderRadius: BorderRadius.circular(8),
												),
												hintText: "E.g Flutter Widget from Scratch",
											),

										),
									),

									SizedBox(height:20),

									Container(
										decoration: BoxDecoration(
											border: Border(bottom:BorderSide(
												width: 1,color:Colors.black.withOpacity(.1))),
										),
										margin: EdgeInsets.only(bottom: 10),
										width: double.infinity,
										child: Text("Enter tutorial content below", style: Theme.of(context).textTheme.headline2)
									),
									Container(
										constraints:BoxConstraints(maxHeight:300),
										child:TextFormField(
											validator: (value){
												if (value!.isEmpty || value == null || value.length < 500){
													return "Tutorial content is required and must be at least 500 chars";
												}
											},
											decoration: InputDecoration(
												border: OutlineInputBorder(
													borderRadius: BorderRadius.circular(8),
												),
												hintText: "Widgets are the basis for very flutter app. As you might probably heared, everything is a wiget in flutter",

											),
											controller:prov.contentController,
											minLines: 10,
											keyboardType: TextInputType.multiline,
											maxLines: null,
								        ),
									),
								],
							),
                              ),

                          Container(
                              margin: EdgeInsets.all(8),
							padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border.all(color:Colors.black.withOpacity(.1)),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      Container(
									 width: double.infinity,
									 margin: EdgeInsets.only(bottom: 10),
									 child: Text("Project", style: Theme.of(context).textTheme.headline2),
									 decoration: BoxDecoration(
											border: Border(bottom:BorderSide(
												width: 1,color:Colors.black.withOpacity(.1))),
										),
									),
									SizedBox(height:20),
									Container(
									 width: double.infinity,
									 child: Text("Enter project title", style: Theme.of(context).textTheme.headline3),
									 decoration: BoxDecoration(
											border: Border(bottom:BorderSide(
												width: 1,color:Colors.black.withOpacity(.1))),
										),
									),
									SizedBox(height:10),
									Container(
										child:TextFormField(
											validator: (value){
												if (value!.isEmpty || value == null || value.length < 15){
													return "Project title is required and must be at least 15 chars";
												}
											},
											controller:prov.projectTitleController,
											decoration: InputDecoration(
												border: OutlineInputBorder(
													borderRadius: BorderRadius.circular(8),
												),
												hintText: "E.g Simple Login Page",
											),

										),
									),

									SizedBox(height:20),

									Container(
										decoration: BoxDecoration(
											border: Border(bottom:BorderSide(
												width: 1,color:Colors.black.withOpacity(.1))),
										),
										margin: EdgeInsets.only(bottom: 10),
										width: double.infinity,
										child: Text("Briefly state problem statement below", style: Theme.of(context).textTheme.headline3)
									),
									Container(
										constraints: BoxConstraints(maxHeight: 200),
										child:TextFormField(
											validator: (value){
												if (value!.isEmpty || value == null || value.length < 200){
													return "Tutorial title is required and must be at least 200 chars";
												}
											},
											controller:prov.problemStatementController,
											decoration: InputDecoration(
												border: OutlineInputBorder(
													borderRadius: BorderRadius.circular(8),
												),
											hintText: "Dear client, in this project you are expected to ... ",

											),
											minLines: 5,
											keyboardType: TextInputType.multiline,
											maxLines: null,
								        ),
									),
                                  ]
                              )
                          ),
                      ],
                    ),
                  ),
                ),

        ),);
  }
}