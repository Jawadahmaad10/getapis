import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/Models/posts_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModel> postList = []; //create a name of array json  //1
  // it is a custom list

  Future<List<PostsModel>> getPostApi() async {
    //2

    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts')); //3

    var data = jsonDecode(response.body.toString()); //4

    if (response.statusCode == 200) {
      //5
      for (Map i in data) {
        //6
        postList.add(PostsModel.fromJson(i)); //7
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Course'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  postList.clear(); //custom list in json
                  return Text('Loading');
                } else {
                  return ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Title",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(postList[index].title.toString()),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Description",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(postList[index].body.toString()),
                              ],
                            ),
                          ),
                        );
                      });
                }
              }, //builder
            ),
          ),
        ],
      ),
    );
  }
}
