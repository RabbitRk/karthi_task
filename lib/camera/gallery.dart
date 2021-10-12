import 'dart:io';
import 'package:intl/intl.dart';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:karthi_task/video_preview.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  String currentFilePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: _getAllImages(),
        builder: (context, AsyncSnapshot<List<FileSystemEntity>> snapshot) {
          if (!snapshot.hasData || snapshot.data.isEmpty) {
            Text('Sample Text', style: TextStyle(fontSize: 20, color: Colors.white),);

            return Container(
                child: Text('Sample Text', style: TextStyle(fontSize: 20, color: Colors.white),),

            );
          }
          print('${snapshot.data.length} ${snapshot.data}');
          if (snapshot.data.length == 0) {
            return Center(
              child: Text('No images found.'),
            );
          }

          return PageView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              int timeInMillis = 1586348737122;
              var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
              String _timestamp() => DateTime.now().toIso8601String();

              var formattedDate = DateFormat.yMMMd().format(date); // Apr 8, 2020
              currentFilePath = snapshot.data[index].path;
              var extension = path.extension(snapshot.data[index].path);
              if (extension == '.jpeg') {
                Text(_timestamp.toString(), style: TextStyle(fontSize: 20, color: Colors.white),);
              return Container(
                child: new Column(

                children: [
                  new Container(
                    height: 500.0,
                    width: 300.0,

                  child: Image.file(
                    File(snapshot.data[index].path,

                    ),),

                  ),
                  new Container(

                    child: new Text(_timestamp(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Aleo',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.white
                      ),
                    ),
                  ),
                ],
              ));

                //
                //   padding: const EdgeInsets.only(bottom: 8.0),
                // height: 300,
                // child:Text('Sample Text', style: TextStyle(fontSize: 20, color: Colors.white),),
                //


              } else {
                return VideoPreview(
                  videoPath: snapshot.data[index].path,
                );
              }
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 56.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () => _shareFile(),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: _deleteFile,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _shareFile() async {
    var extension = path.extension(currentFilePath);
    await Share.file(
      'image',
      (extension == '.jpeg') ? 'image.jpeg' : '	video.mp4',
      File(currentFilePath).readAsBytesSync(),
      (extension == '.jpeg') ? 'image/jpeg' : '	video/mp4',
    );
  }

  _deleteFile() {
    final dir = Directory(currentFilePath);
    dir.deleteSync(recursive: true);
    print('deleted');
    setState(() {});
  }


  Future<List<FileSystemEntity>> _getAllImages() async {
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/media';
    final myDir = Directory(dirPath);
    List<FileSystemEntity> _images;
    _images = myDir.listSync(recursive: true, followLinks: false);
    _images.sort((a, b) {
      return b.path.compareTo(a.path);
    });
    return _images;
  }
}
