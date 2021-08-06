import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tik_tok_ui/constant/data_json.dart';
import 'package:tik_tok_ui/services/data.dart';
import 'package:tik_tok_ui/services/database_service.dart';
import 'package:tik_tok_ui/theme/colors.dart';
import 'package:tik_tok_ui/widgets/header_home_page.dart';
// import 'package:tik_tok_ui/widgets/column_social_icon.dart';
import 'package:tik_tok_ui/widgets/left_panel.dart';
import 'package:tik_tok_ui/widgets/right_panel.dart';
// import 'package:tik_tok_ui/widgets/tik_tok_icons.dart';
import 'package:video_player/video_player.dart';
import 'package:delayed_display/delayed_display.dart';

//controls the video outlook
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var videoUrl =
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: items.length, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return DelayedDisplay(
      delay: Duration(milliseconds: 1),
      child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Device')
              .doc('hayanfe09@gmail.com')
              .snapshots(),
          builder: (context, snapshot) {
            return RotatedBox(
              quarterTurns: 1,
              child: TabBarView(
                controller: _tabController,
                children: List.generate(items.length, (index) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return VideoPlayerItem(
                      // videoUrl:
                      //     "",
                      size: size,
                      name: snapshot.data["name"],
                      caption: snapshot.data["caption"],
                      songName: snapshot.data["songName"],
                      profileImg: snapshot.data["profileImg"],
                      likes: snapshot.data["likes"].toString(),
                      comments: snapshot.data["comments"].toString(),
                      shares: snapshot.data["shares"].toString(),
                      albumImg: snapshot.data["albumImg"],
                      //snapshot.data["videoUrl"]
                      //items[index]['albumImg']
                    );
                  }
                }),
              ),
            );
          }),
    );
  }
}

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  final String name;
  final String caption;
  final String songName;
  final String profileImg;
  final String likes;
  final String comments;
  final String shares;
  final String albumImg;
  VideoPlayerItem(
      {Key key,
      @required this.size,
      this.name,
      this.caption,
      this.songName,
      this.profileImg,
      this.likes,
      this.comments,
      this.shares,
      this.albumImg,
      this.videoUrl})
      : super(key: key);

  final Size size;

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  VideoPlayerController _videoController;
  bool isShowPlaying = false;

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.network(_HomePageState().videoUrl)
      ..initialize().then((value) {
        _videoController.play();
        setState(() {
          isShowPlaying = false;
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

  Widget isPlaying() {
    return _videoController.value.isPlaying && !isShowPlaying
        ? Container()
        : Icon(
            Icons.play_arrow,
            size: 80,
            color: white.withOpacity(0.5),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          setState(() {
            _videoController.value.isPlaying
                ? _videoController.pause()
                : _videoController.play();
          });
        },
        child: RotatedBox(
          quarterTurns: -1,
          child: Container(
              height: widget.size.height,
              width: widget.size.width,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: widget.size.height,
                    width: widget.size.width,
                    decoration: BoxDecoration(color: black),
                    child: Stack(
                      children: <Widget>[
                        VideoPlayer(_videoController),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(),
                            child: isPlaying(),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: widget.size.height,
                    width: widget.size.width,
                    child: Padding(
                      padding:
                          //controls placement of all icons/ bottons on the screen
                          const EdgeInsets.only(left: 15, top: 20, bottom: 10),
                      child: SafeArea(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            HeaderHomePage(),
                            Expanded(
                                child: Row(
                              children: <Widget>[
                                LeftPanel(
                                  size: widget.size,
                                  caption: "${widget.caption}",
                                  name: "${widget.name}",
                                  songName: "${widget.songName}",
                                ),
                                RightPanel(
                                  size: widget.size,
                                  likes: "${widget.likes}",
                                  comments: "${widget.comments}",
                                  shares: "${widget.shares}",
                                  profileImg: "${widget.profileImg}",
                                  albumImg: "${widget.albumImg}",
                                )
                              ],
                            ))
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
