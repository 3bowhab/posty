import 'package:flutter/material.dart';
import 'package:posty/features/main/drawer/custom_drawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(''),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(
                'Welcome to Posty!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}