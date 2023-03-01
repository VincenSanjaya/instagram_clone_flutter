import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/screens/add_post_screen.dart';
import 'package:instagram_clone_flutter/screens/feed_screen.dart';

const webScreenSize= 600;


const homeScreenItems = [
  FeedScreen(),
  Text("Search"),
  AddPostScreen(),
  Text("Favorite"),
  Text("Profile"),
];