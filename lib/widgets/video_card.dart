import 'dart:io';
import 'package:better_player/better_player.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vanfly/modals/task_modal.dart';

class VideoCard extends StatefulWidget {
  final List taskList;

  VideoCard({this.taskList});

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  final _key = GlobalKey<ScaffoldState>();

  final Dio dio = Dio();
  bool loading = false;
  double progress = 0;

  Future<bool> saveVideo(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          String newPath = "";
          print(directory);
          List<String> folders = directory.path.split("/");
          for (int x = 1; x < folders.length; x++) {
            String folder = folders[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/Vanfly";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      File saveFile = File(directory.path + "/$fileName");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        await dio.download(url, saveFile.path,
            onReceiveProgress: (value1, value2) {
          setState(() {
            progress = value1 / value2;
          });
        });
        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(saveFile.path,
              isReturnPathOfIOS: true);
        }
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  downloadFile({String videoUrl, String videoName}) async {
    setState(() {
      loading = true;
      progress = 0;
    });
    bool downloaded = await saveVideo(videoUrl, videoName);
    if (downloaded) {
      _key.currentState
          .showSnackBar(SnackBar(content: Text("File Downloaded")));
    } else {
      _key.currentState
          .showSnackBar(SnackBar(content: Text("Problem Downloading File")));
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 280,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.taskList.length,
            itemBuilder: (BuildContext context, int index) {
              TaskModal task = widget.taskList[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.pink[100]),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.pink[100],
                            offset: Offset(-2, -1),
                            blurRadius: 5),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(task.cardlabel,
                              style: TextStyle(
                                fontSize: 20,
                              )),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 150,
                              width: 300,
                              child: BetterPlayer.network(
                                task.url,
                                betterPlayerConfiguration:
                                    BetterPlayerConfiguration(
                                        aspectRatio: 16 / 9,
                                        looping: false,
                                        autoPlay: false),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(90, 0, 90, 0),
                            child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.pinkAccent,
                                child: MaterialButton(
                                  onPressed: () async {
                                    await downloadFile(
                                        videoUrl: task.url,
                                        videoName: task.videoname);
                                  },
                                  child: Text(
                                    'Download',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )),
              );
            }));
  }
}
