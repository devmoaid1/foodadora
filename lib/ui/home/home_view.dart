import 'package:flutter/material.dart';
import 'package:foodadora/ui/home/home_viewModel.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.logout(),
      builder: (context, model, _) => const Scaffold(
        backgroundColor: Colors.amber,
        body: Center(
          child: Text("This is Home Page"),
        ),
      ),
    );
  }
}
