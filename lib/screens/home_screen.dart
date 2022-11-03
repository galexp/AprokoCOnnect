import 'dart:convert';
import 'package:aproko_connect/models/photo.dart';
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
    final response = await http
        .get(fetchUserFunc("https://jsonplaceholder.typicode.com/users"));

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

  Future getPhotos() async {
    final response = await http
        .get(fetchUserFunc("https://jsonplaceholder.typicode.com/photos"));

    List<Photo> photos = [];

    if (response.statusCode == 200) {
      var jsons = jsonDecode(response.body);

      for (var json in jsons) {
        photos.add(Photo.fromJson(json));
      }
    } else {
      throw Exception('Failed to load user');
    }

    return photos;
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
          Container(
            margin: const EdgeInsets.only(right: 10),
            clipBehavior: Clip.none,
            width: 25,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add_box_sharp,
                size: 30,
              ),
            ),
          ),
          Container(
            clipBehavior: Clip.none,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.chat_bubble,
                size: 30,
              ),
            ),
          ),
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 10),
              child: textInfo("Favorites", FontWeight.w700, Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              clipBehavior: Clip.none,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              // width: double.infinity,
              height: 120,
              child: FutureBuilder(
                  future: getPhotos(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.only(right: 10),
                              clipBehavior: Clip.none,
                              child: Column(
                                children: [
                                  profileImage(snapshot.data[index].url),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  textInfo(snapshot.data[index].id.toString(),
                                      FontWeight.w700, Colors.white),
                                ],
                              ),
                            );
                          });
                    } else {
                      return loaderCircle();
                    }
                  }),

              // SingleChildScrollView(
              //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: [
              //       Column(
              //         children: [
              //           profileImage("https://picsum.photos/250?image=9"),
              //           const SizedBox(
              //             height: 5,
              //           ),
              //           textInfo("Marc", FontWeight.w700, Colors.white),
              //         ],
              //       ),
              //       const SizedBox(
              //         width: 20,
              //       ),
              //       Column(
              //         children: [
              //           profileImage("https://picsum.photos/250?image=9"),
              //           const SizedBox(
              //             height: 5,
              //           ),
              //           textInfo("Marc", FontWeight.w700, Colors.white),
              //         ],
              //       )
              //     ],
              //   ),
              // ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 500,
              width: double.infinity,
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
                            return Container(
                              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: ListTile(
                                leading: profileImage(
                                    "https://picsum.photos/250?image=9"),
                                title: textInfo(snapshot.data[index].name,
                                    FontWeight.w400, Colors.black),
                                subtitle: textInfo(
                                    snapshot.data[index].username,
                                    FontWeight.w400,
                                    Colors.grey),
                                trailing: const Icon(
                                  Icons.circle,
                                  size: 15,
                                  color: Colors.green,
                                ),
                              ),
                            );
                          });
                    } else {
                      return loaderCircle();
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
