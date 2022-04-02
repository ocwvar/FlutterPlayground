import 'package:flutter_playground/base/base_remote_view_model.dart';

import 'model.dart';

class RemoteImageViewModel extends BaseRemoteViewModel {

  final RemoteImageModel _model = RemoteImageModel();

  Future? _fetchJob;

  RemoteImageModelData? _data;
  RemoteImageModelData? get data => _data;

  /// begin to fetch image
  void fetch() {
    _data = null;
    super.setStatus(Status.loading);

    /// ignore last fetch job's result
    _fetchJob?.ignore();

    /// begin new fetch job
    _fetchJob = _model.fetch()
    .then((value){
      _data = value;
      super.setStatus(Status.finished);
    })
    .onError((error, stackTrace){
      super.setStatus(Status.error);
    });
  }

}