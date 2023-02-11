import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:rest_api/Models/user_model.dart';

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<UserModel> userList = []; //1

  Future<List<UserModel>> getUserApi() async {
    ///
    //2

    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/users')); //3
    var data = jsonDecode(response.body.toString()); //4

    if (response.statusCode == 200) {
      //5

      for (Map i in data) {
        //6

        userList.add(UserModel.fromJson(i)); //7

        // print(i['name']);    //only for single key value pairs
      }
      return userList;
    } else {
      return userList;
    }
  }

  ///

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Course'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              //1
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                //2

                if (!snapshot.hasData) {
                  //3
                  return CircularProgressIndicator();
                } else {
                  return ListView.builder(
                      //4
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ReusableRow(
                                    title: 'Name',
                                    value:
                                        snapshot.data![index].name.toString()),
                                ReusableRow(
                                    title: 'username',
                                    value: snapshot.data![index].username
                                        .toString()),
                                ReusableRow(
                                    title: 'email',
                                    value:
                                        snapshot.data![index].email.toString()),

                                //this one adress is itself an object
                                ReusableRow(
                                    title: 'Adresss',
                                    value: snapshot.data![index].address!.city
                                        .toString()),

                                //adress geo in with lat
                                ReusableRow(
                                    title: 'Geo',
                                    value: snapshot
                                        .data![index].address!.geo!.lat
                                        .toString()),
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

//making a compononet of row to reuse it

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}


/** 
 * This is the json api of above code
 * [
  {
    "id": 1,
    "name": "Leanne Graham",
    "username": "Bret",
    "email": "Sincere@april.biz",
    "address": {
      "street": "Kulas Light",
      "suite": "Apt. 556",
      "city": "Gwenborough",
      "zipcode": "92998-3874",
      "geo": {
        "lat": "-37.3159",
        "lng": "81.1496"
      }
    },
    "phone": "1-770-736-8031 x56442",
    "website": "hildegard.org",
    "company": {
      "name": "Romaguera-Crona",
      "catchPhrase": "Multi-layered client-server neural-net",
      "bs": "harness real-time e-markets"
    }
  },
 * 
 * 
*/


