import 'package:flutter/material.dart';
import 'package:scope_ex/viewmodel/home_viewmodel.dart';
import 'package:scope_ex/views/item_of_list.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    viewModel.apiGetUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Architecture Patterns'),
      ),
      body: ScopedModel<HomeViewModel>(
        model: viewModel,
        child: ScopedModelDescendant<HomeViewModel>(
          builder: (context, child, model) =>  Center(
              child: ListView.builder(
                itemCount: viewModel.posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return ItemsOf().itemOf(index,viewModel,context);
                },
              )),
        ),
      ),
    );
  }
  

}
