import 'dart:typed_data';

import 'package:dio/dio.dart';

class RemoteImageModel {

  final Dio _client = Dio();
  final String _imageUrl = "https://images.unsplash.com/photo-1559583985-c80d8ad9b29f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MXwxMDY1OTc2fHxlbnwwfHx8fA%3D%3D&w=1000&q=80";

  Future<RemoteImageModelData> fetch() async {
    final Response<List<int>> response = await _client.get<List<int>>(
      _imageUrl,
      options: Options(
        responseType: ResponseType.bytes,
        receiveTimeout: 2000
      )
    );

    final dynamic result = response.data;

    if (response.statusCode != 200) {
      throw Exception("Response status code is ${response.statusCode} != 200");
    } else if (result == null) {
      throw Exception("Response data is NULL");
    }

    return RemoteImageModelData(Uint8List.fromList(result));
  }

}

class RemoteImageModelData {
  final Uint8List bytes;
  RemoteImageModelData(this.bytes);
}