import 'dart:convert';

import 'package:flutter/material.dart';
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
      var response = await http.get(Uri.parse('${url}feeds'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}'
      });
      if (response.statusCode == 200) {
        isLoading.value = false;
        var feeds = jsonDecode(response.body)['feeds'] as List;
        posts.value = feeds.map((item) => PostModel.fromJson(item)).toList();
      } else {
        isLoading.value = false;
        Get.snackbar('Error', jsonDecode(response.body)['message'],
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future createPost({required String content}) async {
    try {
      var data = {'content': content};

      var response = await http.post(
        Uri.parse('${url}feeds'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        },
        body: data,
      );

      if (response.statusCode == 201) {
        Get.snackbar('Success', jsonDecode(response.body)['message'],
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar('Error', jsonDecode(response.body)['message'],
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {}
  }
}
