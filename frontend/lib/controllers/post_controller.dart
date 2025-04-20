import 'dart:convert';

import 'package:frontend/constants/constants.dart';
import 'package:get/get.dart';
import 'package:frontend/models/post_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PostController extends GetxController {
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);
  final isLoading = true.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    getAllPosts();
  }

  Future getAllPosts() async {
    try {
      isLoading.value = true;
      var response = await http.get(
        Uri.parse('${url}feeds'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        }
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        for (var item in jsonDecode(response.body)['feeds']) {
          posts.value.add(PostModel.fromJson(item));
        }
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }
}