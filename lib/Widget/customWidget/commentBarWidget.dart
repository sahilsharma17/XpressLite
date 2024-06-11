import 'package:flutter/material.dart';

class CommentBottomBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  CommentBottomBar({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10.0,
            spreadRadius: 5.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Write a comment...',
                border: InputBorder.none,
              ),
              onSubmitted: (value) {
                onSend();
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.orange),
            onPressed: onSend,
          ),
        ],
      ),
    );
  }
}
