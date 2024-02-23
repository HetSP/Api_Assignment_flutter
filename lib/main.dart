import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:collection';
import 'dart:core';

void main() {
  runApp(const MyApp());
}

Map mapResponse = new Map();
Map dataResponse = new Map();
List listResponse = [];

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=1"));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = mapResponse['data'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    apicall();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("API Data",style: TextStyle(fontSize: 25),),
          backgroundColor: Colors.redAccent.shade200,
        ),
        body: Center(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        tileColor: Colors.black54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(listResponse[index]['avatar']),
                            ),
                            Text(listResponse[index]['id'].toString(),style: TextStyle(fontSize: 18,color: Colors.white),),
                            Text(listResponse[index]['email'].toString(),style: TextStyle(fontSize: 18,color: Colors.white),),
                            Text(listResponse[index]['first_name'].toString(),style: TextStyle(fontSize: 18,color: Colors.white),),
                            Text(listResponse[index]['last_name'].toString(),style: TextStyle(fontSize: 18,color: Colors.white),),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            itemCount: listResponse == null ? 0 : listResponse.length,
          ),
        ),
      ),
    );
  }
}
