import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softwaretutorials/presentation/pages/screens/tutorial/bloc/tutorial_bloc.dart';
import '../components/components.dart';

class TutorialListView extends StatefulWidget {
  
  @override
  State<TutorialListView> createState() => _TutorialListViewState();
}

class _TutorialListViewState extends State<TutorialListView> {

  @override
	void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
	return Container(
	width: double.infinity,
	height: double.infinity,
	color: Color(0xff471F7A),
	padding: EdgeInsets.only(top:10, left:10, right:10),
	child: 
		BlocBuilder<TutorialBloc, TutorialState>(
      builder: (context, state) {
        if (state is TutorialLoadedState){
          return ListView.separated(
						itemCount: state.tutorialList.length,
						itemBuilder: (BuildContext context, int index) {
							return TutorialCard(tutorial: state.tutorialList[index]);
						},
						separatorBuilder: (BuildContext context, int index) {
							return SizedBox(height: 20);
						},
					);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
  ));
  }
}