import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:instagram_clone/models/posts.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/shared/loading.dart';

class ListPosts extends StatefulWidget {
  final UserData userData;
  final List<dynamic> postsList;

  ListPosts({this.userData, this.postsList});

  @override
  _ListPostsState createState() => _ListPostsState();
}

class _ListPostsState extends State<ListPosts> {
  @override
  Widget build(BuildContext context) {
    var userData = widget.userData;
    var postList = widget.postsList;

    return Container(
      child: ListView.builder(
        itemCount: postList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              listPostsTop(context, index, userData, postList),
              listPostsMid(context, index, userData, postList),
              listPostsBottom(context, index, userData, postList),
            ],
          );
        },
      ),
    );
  }
}

Container listPostsTop(
    BuildContext context, int index, UserData userData, List<Posts> postsList) {
  return Container(
    padding: EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 0.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CachedNetworkImage(
              imageUrl: userData.profile_pic,
              imageBuilder: (context, imageProvider) => CircleAvatar(
                backgroundImage: imageProvider,
                radius: 15.0,
              ),
              placeholder: (context, url) => CircleAvatar(
                backgroundImage: AssetImage("assets/images/no_profile_pic.png"),
                radius: 15.0,
              ),
              errorWidget: (context, url, error) => CircleAvatar(
                backgroundImage: AssetImage("assets/images/no_profile_pic.png"),
                radius: 15.0,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    userData.username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                postsList[index].location == ""
                    ? Container()
                    : Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(postsList[index].location),
                      ),
              ],
            ),
          ],
        ),
        Container(
          child: IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => print("More clicked"),
          ),
        ),
      ],
    ),
  );
}

Container listPostsMid(
    BuildContext context, int index, UserData userData, List<Posts> postsList) {
  if (postsList.isEmpty) {
    return Container(child: Loading());
  } else {
    return Container(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(1.0),
      child: CachedNetworkImage(
        imageUrl: postsList[index].downURL,
        imageBuilder: (context, imageProvider) => Container(
          padding: EdgeInsets.all(1.0),
          child: Image(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
        placeholder: (context, url) => Container(
          padding: EdgeInsets.all(1.0),
          color: Colors.grey[100],
        ),
        errorWidget: (context, url, error) => Container(
          padding: EdgeInsets.all(1.0),
          child: Center(
            child: Text("Error Loading Post"),
          ),
        ),
      ),
    );
  }
}

Container listPostsBottom(
    BuildContext context, int index, UserData userData, List<Posts> postsList) {
  return Container(
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      AntDesign.hearto,
                    ),
                    onPressed: () => print("Like Post"),
                  ),
                  IconButton(
                    icon: Icon(
                      Octicons.comment,
                    ),
                    onPressed: () => print("Comment Post"),
                  ),
                  IconButton(
                    icon: Icon(
                      FontAwesome.send_o,
                    ),
                    onPressed: () => print("Send Post"),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: IconButton(
                icon: Icon(Icons.save_alt),
                onPressed: () => print("More clicked"),
              ),
            ),
          ],
        ),
        postsList[index].caption == ""
            ? Container()
            : Container(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${userData.username} ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "${postsList[index].caption}",
                      ),
                    ],
                  ),
                ),
              ),
        Container(
          padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 15.0),
          alignment: Alignment.centerLeft,
          child: Text(
            "${postsList[index].timestamp.day}/${postsList[index].timestamp.month}/${postsList[index].timestamp.year}",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    ),
  );
}
