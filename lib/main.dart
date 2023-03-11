import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Model> dataList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPhotos();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Rest API_json_place holder")),
      ),
      body: dataList.isEmpty? const Center(child: CircularProgressIndicator()):Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: dataList.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 170,
            mainAxisExtent: 150,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) => Container(
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children:  [
                Text(dataList[index].id.toString()),
                SizedBox(
                  height: 120,
                    child: Image(image: NetworkImage(dataList[index].url.toString(),))),

              ],
            ),
          ),
        ),
      ),
    );
  }

  getPhotos()async{
    var response= await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data=jsonDecode(response.body);
    var datasList=data;
    for(var item in datasList){
     Model model=Model();
     model.id=item["id"];
     model.url=item["url"];
     dataList.add(model);
    }

  }
}

class Model{
  int? id;
  String? url;
}