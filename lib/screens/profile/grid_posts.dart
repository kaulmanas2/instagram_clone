import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GridPosts extends StatefulWidget {
  final List<dynamic> postsList;

  GridPosts({this.postsList});

  @override
  _GridPostsState createState() => _GridPostsState();
}

class _GridPostsState extends State<GridPosts> {
  @override
  Widget build(BuildContext context) {
    var postList = widget.postsList;

    return postList.isEmpty
        ? Container(
            child: Center(
              child: Text(
                "No posts uploaded",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          )
        : Container(
            child: GridView.count(
              crossAxisCount: 3,
              children: postList.map(
                (post) {
                  return CachedNetworkImage(
                    imageUrl: post.downURL,
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
                      child: Image.asset("assets/images/no_profile_pic.png"),
                    ),
                  );
                },
              ).toList(),
            ),
          );
  }
}
