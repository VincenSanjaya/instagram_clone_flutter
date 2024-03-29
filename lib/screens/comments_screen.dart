import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/resources/firestore_method.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:instagram_clone_flutter/widgets/comment_card.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../provider/user_provider.dart';

class CommentsScreen extends StatefulWidget {
  final snap;
  const CommentsScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Comments'),
        centerTitle: false,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .doc(widget.snap['postId'])
              .collection('comments')
          .orderBy('datePublished', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
                itemBuilder: (context, index) =>CommentCard(
                  snap: (snapshot.data! as dynamic).docs[index].data(),
                )

            );
          }),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  user.photoUrl,
                ),
                radius: 18,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: "Comment as ${user.username}",
                    border: InputBorder.none,
                  ),
                ),
              )),
              InkWell(
                  onTap: () async {
                    await FirestroreMethods().postComment(
                        widget.snap['postId'],
                        _commentController.text,
                        user.uid,
                        user.username,
                        user.photoUrl);
                    setState(() {
                      _commentController.clear();
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: const Text(
                        "Post",
                        style: TextStyle(color: blueColor),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
