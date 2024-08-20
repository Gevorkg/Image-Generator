import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';

class PromptRepos {
  static Future<Uint8List?> generateImage(String prompt) async {
    try {
      String url = 'https://api.vyro.ai/v1/imagine/api/generations';
      Map<String, dynamic> headers = {
        'Authorization':
            'Bearer vk-58U0Oc2xDVSk5iQBbF2FEWW3i5TEkwsTp46ne8zRK5Z3eMr',
      };
      Map<String, dynamic> payload = {
        'prompt': prompt,
        'style_id': '29',
        'aspect_ratio': '1:1',
        'cfg': '1',
        'seed': '1',
        'high_res_results': '1',
      };

      FormData formData = FormData.fromMap(payload);

      Dio dio = Dio();
      dio.options = BaseOptions(
        headers: headers,
      );

      final response = await dio.post(
        url,
        data: formData,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        Uint8List uint8List = Uint8List.fromList(response.data);
        return uint8List;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
