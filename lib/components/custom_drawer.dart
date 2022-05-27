import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';

class CustomDrawer{
	static Drawer get(BuildContext context){
		return Drawer(
			
			child: TextButton(child:Text("Logout"), onPressed: () {
				
				Provider.of<AppStateManager>(context, listen:false).logout();
			
			})
		
		);
	}
} 
  