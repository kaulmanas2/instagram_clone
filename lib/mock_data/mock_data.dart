import 'package:instagram_clone/models/posts.dart';
import 'package:instagram_clone/models/user.dart';

List<String> profPics = [
  "https://images.unsplash.com/photo-1557296387-5358ad7997bb?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=694&q=80",
  "https://images.unsplash.com/photo-1558507652-2d9626c4e67a?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
  "https://images.unsplash.com/photo-1527082395-e939b847da0d?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=675&q=80",
  "https://images.unsplash.com/photo-1521117660421-ce701ed42966?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
  "https://images.unsplash.com/photo-1601582589907-f92af5ed9db8?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=80",
  "https://images.unsplash.com/photo-1535579710123-3c0f261c474e?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80"
];

List<String> posts = [
  "https://images.unsplash.com/photo-1600031830097-10d2791a3b83?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=2134&q=80",
  "https://images.unsplash.com/photo-1587500451320-9d59709c8b0f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
  "https://images.unsplash.com/photo-1586020969217-9b2296b53ffe?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
  "https://images.unsplash.com/photo-1527720404586-62e0e58fe307?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
  "https://images.unsplash.com/photo-1511164194573-d3fc6e29e1ef?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=700&q=80",
  "https://images.unsplash.com/photo-1563462645987-7f85352a2dfa?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1353&q=80",
  "https://images.unsplash.com/photo-1478695605156-f64b0ee877f4?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80",
  "https://images.unsplash.com/photo-1588143140627-b6ea0f65448b?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
  "https://images.unsplash.com/photo-1532581291347-9c39cf10a73c?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1350&q=80",
];

List<UserData> homeFeedUserData = [
  UserData(
      username: "test_user_1",
      profile_pic: profPics[0],
      bio: "",
      followers: [],
      following: []),
  UserData(
      username: "test_user_2",
      profile_pic: profPics[1],
      bio: "",
      followers: [],
      following: []),
  UserData(
      username: "test_user_3",
      profile_pic: profPics[2],
      bio: "",
      followers: [],
      following: []),
  UserData(
      username: "test_user_4",
      profile_pic: profPics[3],
      bio: "",
      followers: [],
      following: []),
  UserData(
      username: "test_user_5",
      profile_pic: profPics[4],
      bio: "",
      followers: [],
      following: []),
  UserData(
      username: "test_user_6",
      profile_pic: profPics[5],
      bio: "",
      followers: [],
      following: []),
  UserData(
      username: "test_user_7",
      profile_pic: profPics[3],
      bio: "",
      followers: [],
      following: []),
  UserData(
      username: "test_user_8",
      profile_pic: profPics[2],
      bio: "",
      followers: [],
      following: []),
  UserData(
      username: "test_user_9",
      profile_pic: profPics[4],
      bio: "",
      followers: [],
      following: []),
];

List<Posts> homeFeedPostsData = [
  Posts(
      downURL: posts[0],
      ownerID: "",
      caption: "Apple is love",
      location: "",
      timestamp: DateTime.parse("2020-01-01 20:18:04Z")),
  Posts(
      downURL: posts[1],
      ownerID: "",
      caption: "Lit",
      location: "Backyard",
      timestamp: DateTime.parse("2019-08-04 20:18:04Z")),
  Posts(
      downURL: posts[2],
      ownerID: "",
      caption: "",
      location: "Between Stars",
      timestamp: DateTime.parse("2019-07-28 20:18:04Z")),
  Posts(
      downURL: posts[3],
      ownerID: "",
      caption: "",
      location: "",
      timestamp: DateTime.parse("2019-07-16 20:18:04Z")),
  Posts(
      downURL: posts[4],
      ownerID: "",
      caption: "Nature is Love",
      location: "",
      timestamp: DateTime.parse("2019-06-10 20:18:04Z")),
  Posts(
      downURL: posts[5],
      ownerID: "",
      caption: "",
      location: "",
      timestamp: DateTime.parse("2019-07-10 20:18:04Z")),
  Posts(
      downURL: posts[6],
      ownerID: "",
      caption: "",
      location: "Garden",
      timestamp: DateTime.parse("2019-07-09 20:18:04Z")),
  Posts(
      downURL: posts[7],
      ownerID: "",
      caption: "",
      location: "",
      timestamp: DateTime.parse("2019-06-16 20:18:04Z")),
  Posts(
      downURL: posts[8],
      ownerID: "",
      caption: "",
      location: "In the wild",
      timestamp: DateTime.parse("2019-05-18 20:18:04Z")),
];
