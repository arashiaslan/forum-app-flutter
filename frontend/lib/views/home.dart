import 'package:flutter/material.dart';
import 'package:frontend/controllers/post_controller.dart';
import 'package:frontend/views/widgets/post_data.dart';
import 'package:frontend/views/widgets/post_field_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PostController _postController = Get.put(PostController());
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forum App', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightBlue,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostField(
                  hintText: 'Whats on Ur Brainzs!?',
                  controller: _textController),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {},
                child: Text('Post', style: GoogleFonts.poppins(color: Colors.white),),
              ),
              const SizedBox(height: 30),
              Text('Posts'),
              const SizedBox(height: 20),
              Obx(() {
                return _postController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _postController.posts.value.length,
                      itemBuilder: (context, index) {
                        return PostData(
                            post: _postController.posts.value[index],
                        );
                      }
                    );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
