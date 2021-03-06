import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:instagram_clone/mock_data/mock_data.dart';
import 'package:instagram_clone/models/posts.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/screens/profile/list_posts.dart';
import 'package:instagram_clone/services/auth.dart';
import 'package:instagram_clone/shared/loading.dart';

class HomeFeed extends StatefulWidget {
  @override
  _HomeFeedState createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  final AuthenticationService _authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
          child: Text(
            "Instagram Clone",
            style: TextStyle(
              fontFamily: "Billabong",
              fontSize: 30.0,
            ),
          ),
        ),
        // backgroundColor: Theme.of(context).primaryColor,
        elevation: 1.0,
        actions: [
          IconButton(
            icon: Icon(
              AntDesign.search1,
              color: Theme.of(context).iconTheme.color,
              size: 30.0,
            ),
            onPressed: () => print("search button"),
          ),
          IconButton(
            icon: Icon(
              Feather.send,
              color: Theme.of(context).iconTheme.color,
              size: 30.0,
            ),
            onPressed: () => print("inbox button"),
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: homeFeedUserData.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                listPostsTop(context, index, homeFeedUserData, homeFeedPostsData),
                listPostsMid(context, index, homeFeedUserData, homeFeedPostsData),
                listPostsBottom(context, index, homeFeedUserData, homeFeedPostsData),
              ],
            );
          },
        ),
      ),
    );
  }
}

Container listPostsTop(
    BuildContext context, int index, List<UserData> userData, List<Posts> postsList) {
  return Container(
    padding: EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 0.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CachedNetworkImage(
              imageUrl: userData[index].profile_pic,
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
                    userData[index].username,
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
    BuildContext context, int index, List<UserData> userData, List<Posts> postsList) {
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
    BuildContext context, int index, List<UserData> userData, List<Posts> postsList) {
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
                  text: "${userData[index].username} ",
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