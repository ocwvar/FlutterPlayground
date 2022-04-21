import 'dart:typed_data';

import 'package:dio/dio.dart';

class RemoteImageModel {

  final Dio _client = Dio();
  final String _imageUrl = "https://storage.googleapis.com/cms-storage-bucket/c823e53b3a1a7b0d36a9.png";

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