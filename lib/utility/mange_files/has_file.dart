import 'dart:io';

Future<bool> HasFile(String name,Directory  directory)async{
  try{
    return await directory.list().any((element) => element.path.split('/').last==name);
  }catch(e){
    print("hasfile is error" +e.toString());
    return false;
  }

}