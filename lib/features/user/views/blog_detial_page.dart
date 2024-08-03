import 'package:flutter/material.dart';
import 'package:mind_labify/models/blog_model.dart';
import 'package:mind_labify/utils/gaps.dart';

class BlogDetialPage extends StatefulWidget {
  final BlogModel blog;
  const BlogDetialPage({
    super.key,
    required this.blog,
  });

  @override
  State<BlogDetialPage> createState() => _BlogDetialPageState();
}

class _BlogDetialPageState extends State<BlogDetialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF4F2E9,
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 122,
                  width: double.infinity,
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      widget.blog.image.toString(),
                    ),
                  ),
                ),
                Gaps.hGap20,
                Text(
                  widget.blog.title.toString(),
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Gaps.hGap15,
                Text(
                  widget.blog.description.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(
                      0xff000000,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
