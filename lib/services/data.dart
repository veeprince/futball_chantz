class Data {
  String name;
  String caption;
  String videoUrl;
  String songName;
  String profileImg;
  int likes;
  int shares;
  int comments;
  String albumImg;

  Data({
    this.name,
    this.caption,
    this.videoUrl,
    this.songName,
    this.profileImg,
    this.likes,
    this.shares,
    this.comments,
    this.albumImg,
  });
}

// class Data {
//   String name;
//   String caption;
//   String videoUrl;
//   String songName;
//   String profileImg;
//   int likes;
//   int shares;
//   int comments;
//   String albumImg;

//   Data(
//     this.name,
//     this.caption,
//     this.videoUrl,
//     this.songName,
//     this.profileImg,
//     this.likes,
//     this.shares,
//     this.comments,
//     this.albumImg,
//   );

//   factory Data.fromJSON(Map<String, dynamic> json) {
//     return Data(
//         json["name"],
//         json["caption"],
//         json["videoUrl"],
//         json["songName"],
//         json["profileImg"],
//         json["likes"],
//         json["shares"],
//         json["comments"],
//         json["albumImg"]);
//   }

//   Map<String, dynamic> toJSON() {
//     return {
//       "name": name,
//       "caption": caption,
//       "videoUrl": videoUrl,
//       "songName": songName,
//       "profileImg": profileImg,
//       "likes": likes,
//       "shares": shares,
//       "comments": comments,
//       "albumImg": albumImg,
//     };
//   }
// }
