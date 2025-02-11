import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Models/photos_model.dart';

//--------------- JSON Data with custom Model--------------------

class PhotosApi extends StatelessWidget {
  List<PhotosModel> photosList = [];

  Future<List<PhotosModel>> getPhotos() async {
    final uri = Uri.parse("https://jsonplaceholder.typicode.com/photos");
    final response = await http.get(uri);
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        PhotosModel photos = PhotosModel(title: i["title"], url: i["url"], id: i["id"]);
        photosList.add(photos);
      }
      return photosList;
    }
    return photosList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text("Flutter API"),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getPhotos(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: photosList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const CircleAvatar(
                          backgroundImage:
                              // NetworkImage(photosList[index].url),
                              NetworkImage("https://images.thedirect.com/media/article_full/kaisen.jpg"),
                        ),
                        title: Text(photosList[index].id.toString()),
                        subtitle: Text(photosList[index].title),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ));
  }
}
