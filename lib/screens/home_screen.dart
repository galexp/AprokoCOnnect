import 'dart:convert';

import 'package:aproko_connect/models/user.dart';
import 'package:aproko_connect/util/utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future fetchUser() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    List<User> users = [];

    if (response.statusCode == 200) {
      var jsons = jsonDecode(response.body);

      for (var json in jsons) {
        User user = User.fromJson(json);
        users.add(user);
      }
    } else {
      throw Exception('Failed to load user');
    }

    return users;
  }
   late Future futureUser;
  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            "Contacts",
            style:
                TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w700),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_box_sharp),
            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              clipBehavior: Clip.none,
              child: const TextField(
                  style: TextStyle(color: Color.fromARGB(160, 255, 255, 255)),
                  decoration: InputDecoration(
                      labelStyle:
                          TextStyle(color: Color.fromARGB(160, 255, 255, 255)),
                      fillColor: Color.fromARGB(70, 255, 255, 255),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color.fromARGB(160, 255, 255, 255),
                      ),
                      hintText: "Search",
                      hintStyle: TextStyle(
                          fontFamily: "Poppins",
                          color: Color.fromARGB(160, 255, 255, 255)))),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: textInfo("Favorites", FontWeight.w700, Colors.white),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Column(
                    children: [
                      profileImage("https://via.placeholder.com/600/92c952"),
                      const SizedBox(
                        height: 5,
                      ),
                      textInfo("Marc", FontWeight.w700, Colors.white),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      profileImage("https://via.placeholder.com/600/92c952"),
                      const SizedBox(
                        height: 5,
                      ),
                      textInfo("Marc", FontWeight.w700, Colors.white),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 500,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35))),
              child: FutureBuilder(
                  future: futureUser,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: textInfo(snapshot.data[index].name, FontWeight.w400, Colors.black),
                            );
                          });
                    } else {
                      return const Center(
                        child: Text("No User found!"),
                      );
                    }
                   
                  }),
            )
          ],
        ),
      ),
    );
  }
}
