import 'dart:convert';
import 'dart:io';

Future<bool> newDirectory(String content, String name,Directory directory) async {
  if (await directory.exists()) {
    try {
      if (await directory.exists()) {
        final decodedBytes = base64Decode(content);
        File fileImg = File('${directory.path}/$name');
        fileImg.writeAsBytesSync(List.from(decodedBytes));
        return true;
      } else {
        return false;
        print("e.toString()");
      }
    } catch (e) {
     return false;
    }
  }else{
    return false;
  }
}