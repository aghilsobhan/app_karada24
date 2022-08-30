
import 'package:app_karada24/screen/chat_page/model/model_received_chat.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MessageDataBase{
static final MessageDataBase instance=MessageDataBase._init();
static Database? _database;
MessageDataBase._init();
Future<Database> get dataBase async{
 if(_database!=null) return _database!;
 _database=await _initDB("messageDB.db");
 print(_database);
 return dataBase;

}
Future<Database> _initDB(String filePath)async{


  final dbPatch=await getDatabasesPath();
  final path=join(dbPatch,filePath);
  print(_database);
  return await openDatabase(path,version: 1,onCreate: onCreateDB);

}

Future onCreateDB(Database db,int version) async{
  final idLocal='INTEGER PRIMARY KEY AUTOINCREMENT';
  final idType='INTEGER NOT NULL';
  final boolType='INTEGER';
  final integerType='INTEGER';
  final textType='TEXT';
  await db.execute(''' 
  CREATE TABLE ${tableMessage} (
  ${MessageFields.id} $idLocal, 
  ${MessageFields.senderId} $integerType,
  ${MessageFields.senderUsername} $textType,
  ${MessageFields.senderFullname} $textType,
  ${MessageFields.recieverId} $integerType,
  ${MessageFields.recieverUsername} $textType,
  ${MessageFields.recieverFullname} $textType,
  ${MessageFields.sendDate} $textType,
  ${MessageFields.content} $textType,
  ${MessageFields.senderIsNew} $boolType,
  ${MessageFields.recieverIsNew} $boolType,
  ${MessageFields.senderIsSeen} $boolType,
  ${MessageFields.recieverIsSeen} $boolType,
  ${MessageFields.isSenderDeleted} $boolType,
  ${MessageFields.isRecieverDeleted} $boolType,
  ${MessageFields.status} $textType
  )
  ''');

}
Future<ModelRecivedMessage> create(ModelRecivedMessage messageModel)async{
  try{
    final db=await instance.dataBase;
    final id=await db.insert(tableMessage, messageModel.toJson());
    print(messageModel.toJson());
    return messageModel.copy(id:id);
  }catch(e){
    throw Exception(e);
  }

}
Future<List<ModelRecivedMessage>> readMessage(int senderId,int recieverId)async{
  try{
    final db=await instance.dataBase;
    final maps=await db.query(tableMessage,
        columns: MessageFields.values,
        where: '${MessageFields.senderId}=$senderId and ${MessageFields.recieverId}=$recieverId or ${MessageFields.recieverId}=$senderId and ${MessageFields.senderId}=$recieverId',
      orderBy: '${MessageFields.sendDate}'
    );
    if(maps.isNotEmpty){
     // print(maps[1]);
      // return  maps.map((e) => ModelRecivedMessage.fromJson(e)).toList();
      return List.generate(maps.length, (index) => ModelRecivedMessage.fromJson(maps[index]));
    }else{
      return List.generate(maps.length, (index) => ModelRecivedMessage.fromJson(maps[index]));
    }
  }catch(e){
    throw Exception(e);
  }

}
Future<List<ModelRecivedMessage>> readMessageFailed(int id)async{
  try{
    final db=await instance.dataBase;
    final maps=await db.query(tableMessage,
      columns: MessageFields.values,
      where: '${MessageFields.id}=$id'
    );
    if(maps.isNotEmpty){
      // print(maps[1]);
      // return  maps.map((e) => ModelRecivedMessage.fromJson(e)).toList();
      return List.generate(maps.length, (index) => ModelRecivedMessage.fromJson(maps[index]));
    }else{
      return List.generate(maps.length, (index) => ModelRecivedMessage.fromJson(maps[index]));
    }
  }catch(e){
    throw Exception(e);
  }

}
Future<List<ModelRecivedMessage>> readAllMessage()async{
  try{
    final db=await instance.dataBase;
    //final orderBy='${MessageFields.sendDate} ASC';
    final maps=await db.query(tableMessage);
    return List.generate(maps.length, (index) => ModelRecivedMessage.fromJson(maps[index]));
   // return maps.map((json) => MessageModel.fromJson(json)).toList();
  }catch(e){
    throw Exception(e);
  }

}
Future<int> updateMessage(ModelRecivedMessage modelRecivedMessage)async{
  final db=await instance.dataBase;
  return db.update(tableMessage, modelRecivedMessage.toJson(),
    where: '${MessageFields.id}=?',
    whereArgs: [modelRecivedMessage.id]
  );
}
Future close()async{
  final db=await instance.dataBase;
  db.close();

}
Future delete()async{
  final db=await instance.dataBase;
  db.rawQuery("DELETE FROM ${tableMessage}");
}
}