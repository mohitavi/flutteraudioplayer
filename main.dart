import 'package:audioplayers';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String currentTime = "00:00";
  String completeTime = "00:00";

  @override
  void initState() {
    super.initState();

    _audioPlayer.onAudioPositionChanged.listen((Duration duration) {
      setState(() {
        currentTime = duration.toString().split(".")[0];
      });
    });

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        completeTime = duration.toString().split(".")[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.settings,
                  size: 26.0,
                ),
              )),
        ],
        backgroundColor: Colors.black,
        title: Text('Music Player'),
        centerTitle: false,
      ),
      body: Stack(
        children: <Widget>[
          //Image.asset(
          //"assets/adamaSmusic.jpg",
          //fit: BoxFit.contain,
          //),
          Image.asset('images/1.gif'),
          Container(
            width: MediaQuery.of(context).size.width * 0.70,
            height: 48,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.55,
                left: MediaQuery.of(context).size.width * 0.15),
            decoration: BoxDecoration(
                color: Colors.deepPurpleAccent[400],
                borderRadius: BorderRadius.circular(80)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                IconButton(
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: () {
                    if (isPlaying) {
                      _audioPlayer.pause();

                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      _audioPlayer.resume();

                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                ),
                SizedBox(
                  width: 12,
                ),
                IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: () {
                    _audioPlayer.stop();

                    setState(() {
                      isPlaying = false;
                    });
                  },
                ),
                Text(
                  currentTime,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(" | "),
                Text(
                  completeTime,
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                BottomNavigationBar(
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), title: Text('Home')),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.library_music), title: Text('Songs')),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.album), title: Text('Albums')),
                    //BottomNavigationBarItem(
                    //icon: Icon(Icons.art_track), title: Text('Artists')),
                    //BottomNavigationBarItem(
                    //  icon: Icon(Icons.favorite), title: Text('Playlists')),
                  ],
                  selectedItemColor: Colors.deepPurpleAccent[400],
                  unselectedItemColor: Colors.white,
                  backgroundColor: Colors.black,
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: Container(
        width: double.infinity,
        // padding: EdgeInsets.only(bottom: 100.0),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment(1, 0.8),
              child: FloatingActionButton.extended(
                onPressed: () async {
                  String filepath = await FilePicker.getFilePath();
                  int status = await _audioPlayer.play(filepath, isLocal: true);
                  if (status == 1) {
                    setState(() {
                      isPlaying = true;
                    });
                  }
                },
                icon: Icon(Icons.music_note),
                heroTag: "Local",
                label: Text("Choose Audio"),
                backgroundColor: Colors.deepPurpleAccent[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
