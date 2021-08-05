import 'package:flutter/material.dart';
import 'package:tik_tok_ui/pages/discover_page.dart';
import 'package:tik_tok_ui/pages/home_page.dart';
import 'package:tik_tok_ui/pages/message_page.dart';
import 'package:tik_tok_ui/pages/profile_page.dart';
import 'package:tik_tok_ui/theme/colors.dart';
import 'package:tik_tok_ui/widgets/tik_tok_icons.dart';
import 'package:tik_tok_ui/widgets/upload_icon.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  final _pageOptions = [
    HomePage(),
    DiscoverPage(),
    MessagePage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[pageIndex],
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          primaryColor: Colors.blue,
        ),
        child: new BottomNavigationBar(
          currentIndex: pageIndex,
          showSelectedLabels: true,
          selectedItemColor: Colors.black,
          // fixedColor: Colors.black,
          backgroundColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: black,
                size: 40,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: black,
                size: 40,
              ),
              label: "Discover",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.message_outlined,
                color: black,
                size: 40,
              ),
              label: "Inbox",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_off_outlined,
                color: black,
                size: 40,
              ),
              label: "Profile",
            ),
          ],
          onTap: (index) {
            setState(() {
              pageIndex = index;
            });
          },
        ),
      ),
    );
  }

  // Widget getBody() {
  //   // return Scaffold(

  //   // );
  //   // children: <Widget>[
  //   //   HomePage(),
  //   //   Center(
  //   //     //Everything needed in the discover page

  //   //     // child: IconButton(
  //   //     //   icon: Icon(Icons.expand),
  //   //     //   onPressed: () {
  //   //     //     print('This is the discover page');
  //   //     //   },
  //   //     // ),
  //   //     child: Text(
  //   //       "Discover",
  //   //       style: TextStyle(
  //   //           color: black, fontSize: 20, fontWeight: FontWeight.bold),
  //   //     ),
  //   //   ),
  //   //   Center(
  //   //     child: Text(
  //   //       "Upload",
  //   //       style: TextStyle(
  //   //           color: black, fontSize: 20, fontWeight: FontWeight.bold),
  //   //     ),
  //   //   ),
  //   //   Center(
  //   //     child: Text(
  //   //       "All Activity",
  //   //       style: TextStyle(
  //   //           color: black, fontSize: 20, fontWeight: FontWeight.bold),
  //   //     ),
  //   //   ),
  //   //   Center(
  //   //     child: Text(
  //   //       "Profile",
  //   //       style: TextStyle(
  //   //           color: black, fontSize: 20, fontWeight: FontWeight.bold),
  //   //     ),
  //   //   )
  //   // ],
  // }

  Widget getFooter() {
    List bottomItems = [
      //Icons for the buttom
      {"icon": TikTokIcons.home, "label": "Home", "isIcon": true},
      {"icon": TikTokIcons.search, "label": "Discover", "isIcon": true},
      {"icon": "", "label": "", "isIcon": false},
      {"icon": TikTokIcons.messages, "label": "Inbox", "isIcon": true},
      {"icon": TikTokIcons.profile, "label": "Me", "isIcon": true}
    ];
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(color: appBgColor),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(bottomItems.length, (index) {
            return bottomItems[index]['isIcon']
                ? InkWell(
                    onTap: () {
                      switch (index) {
                        case 4:
                          {
                            // Navigator.of(context).pushReplacement(
                            //     MaterialPageRoute(

                            //         builder: (context) => ProfilePage()));
                          }

                          break;
                        default:
                      }
                      selectedTab(index);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          bottomItems[index]['icon'],
                          color: white,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // Center(
                        //   child: Text(
                        //     bottomItems[index]['label'],
                        //     style: TextStyle(color: white, fontSize: 10),
                        //   ),
                        // )
                      ],
                    ),
                  )
                : InkWell(
                    onTap: () {
                      print(selectedTab(index));
                    },
                    child: UploadIcon());
          }),
        ),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
