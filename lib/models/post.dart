import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String uid;
  final String username;
  final String description;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;
  final likes;

  Post({
    required this.uid,
    required this.username,
    required this.description,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'username': username,
    'description': description,
    'postId': postId,
    'datePublished': datePublished,
    'postUrl': postUrl,
    'profImage': profImage,
    'likes': likes,
  };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      uid: snapshot['uid'],
      username: snapshot['username'],
      description: snapshot['description'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      postUrl: snapshot['postUrl'],
      profImage: snapshot['profImage'],
      likes: snapshot['likes'],
    );
  }
}
