import 'dart:io';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class MyViewModel extends ChangeNotifier {

  MyViewModel(this.url,this.fileName);
  final String url,fileName;
  double _progress = 0;
  get downloadProgress => _progress;

  void startDownloading() async {
    _progress = null;
    notifyListeners();

    // final url ='https://kioxke.000webhostapp.com/economics_to_be_happier.pdf';
    final request = Request('GET', Uri.parse(url));
    final StreamedResponse response = await Client().send(request);

    final contentLength = response.contentLength;
    // final contentLength = double.parse(response.headers['x-decompressed-content-length']);

    _progress = 0;
    notifyListeners();

    List<int> bytes = [];

    final file = await _getFile('$fileName');

    response.stream.listen(
      (List<int> newBytes) {
        bytes.addAll(newBytes);
        final downloadedLength = bytes.length;
        _progress = downloadedLength / contentLength;
        notifyListeners();
      },
      onDone: () async {
        _progress = 0;
        notifyListeners();
        await file.writeAsBytes(bytes);
      },
      onError: (e) {
        print(e);
      },
      cancelOnError: true,
    );
  }

  Future<File> _getFile(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    print(dir.path+"/"+filename);
    return File("${dir.path}/$filename");
  }
  
}