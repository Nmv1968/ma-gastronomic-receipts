// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xym/service/user.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:core';
import '../info/generalinfo.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Activity();
  }
}

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Activity createState() => _Activity();
}

class _Activity extends State<Activity> {
  final UserService userService = UserService();

  dynamic objetive = '';

  Map allactivities = {};
  Map activitiesforage = {};
  String activitytime = '';
  String video = '';
  List<String> activitiestodo = [];
  String activity = '';
  @override
  void initState() {
    loadObjetives();
    super.initState();
  }

  loadObjetives() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var agevalidation = prefs.getString('agevalidation') ?? '';
    setState(() {
      activity = prefs.getString('activity') ?? '';
      allactivities = activities;
      activitiesforage = allactivities[agevalidation][activity];
      activitytime = activitiesforage['Tiempo'].toString();
      video = activitiesforage['video'].toString();
      activitiestodo = activitiesforage['Actividades'].split('; ').toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(activity),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(); // Para volver atrás
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Actividades a realizar',
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                'Tiempo estimado $activitytime',
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    ListView(
                        shrinkWrap: true,
                        children: activitiestodo.map((String activity) {
                          return ListTile(
                            title: Text(activity),
                          );
                        }).toList()),
                    if (video != '')
                      YoutubePlayer(
                        controller: YoutubePlayerController(
                          initialVideoId: _getVideoIdFromUrl(video),
                          flags: YoutubePlayerFlags(
                            autoPlay: false,
                            mute: false,
                          ),
                        ),
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.blueAccent,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  String _getVideoIdFromUrl(String url) {
    Uri uri = Uri.parse(url);
    String videoId = uri.queryParameters['v']!;
    return videoId;
  }
}
