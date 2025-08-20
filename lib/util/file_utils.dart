import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class FileUtils {
  static Future<FileData?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        withData: true,
        allowMultiple: false,
        allowedExtensions: ["pdf", "png", "jpeg", "jpg"],
        type: FileType.custom);

    String base64String;

    if (result != null) {
      File file = File(result.files.single.path!);
      base64String = _convertToBase64(file);
      return FileData(
          base64String: base64String,
          file: file,
          fileName: result.files.first.name,
          fileExt: result.files.first.extension!);
    } else {
      // User canceled the picker
    }
    return null;
  }

  static String _convertToBase64(File file) {
    List<int> fileByte = file.readAsBytesSync();
    String base64Image = base64Encode(fileByte);
    return base64Image;
  }

  Future downloadFiles(String fileAddress) async {
    String? directory = await getDownloadPath();
    String name = fileAddress.split('/').last;
    final file = File('${directory}/$name');
    print(fileAddress);
    print(directory);

    EasyLoading.show();
    var response;
    try {
      response = await download(fileAddress, directory.toString());
    } catch (e) {
      EasyLoading.dismiss();
    }

    // var decodeVal = base64.decode(response.data.toString());
    final ref = file.openSync(mode: FileMode.write);
    // var respuesta = Base64Codec().decode();
    // Uint8List decodedbytes1 = base64Decode(bs4str);
    print(response.data);
    ref.writeFromSync(response.data);
    await ref.close();
    print(response.data);
    EasyLoading.dismiss();
    await openFile(file);
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getApplicationDocumentsDirectory();
        // directory = Directory('/storage/emulated/0/Download');
        // // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // // ignore: avoid_slow_async_io
        // if (!await directory.exists()) directory = await getExternalStorageDirectory();
      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    return directory?.path;
  }

  Future download(String path, String directory) async {
    Dio dio = Dio();
    // await dio.download(path, directory,onReceiveProgress: (r,t){
    //   progress.value=r/t;
    // },deleteOnError: true);
    print(path + ">>>>>>_____");
    final response = await Dio().get(path,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ));
    return response;
  }

  openFile(File f) async {
    // print(f.path);
    await OpenFilex.open(f.path);
    //    await OpenDocument.openDocument(filePath: f.path);  }
  }
}

class FileData {
  String base64String;
  File file;
  String fileName;
  String fileExt;

  FileData(
      {required this.base64String,
      required this.file,
      required this.fileName,
      required this.fileExt});
}
