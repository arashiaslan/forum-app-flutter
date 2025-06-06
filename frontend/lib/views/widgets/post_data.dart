import 'package:flutter/material.dart';
import 'package:frontend/models/post_model.dart';
import 'package:google_fonts/google_fonts.dart';

class PostData extends StatelessWidget {
  const PostData({
    super.key, required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.user.name,
            style: GoogleFonts.poppins(),
          ),
          Text(
            post.user.email,
            style: GoogleFonts.poppins(fontSize: 12),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            post.content,
            style: GoogleFonts.poppins(),
          ),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.thumb_up)),
              IconButton(onPressed: () {}, icon: Icon(Icons.comment)),
            ],
          )
        ],
      ),
    );
  }
}
