import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class MySql{

  static Database? _database;
   Future<Database?> get db async{
    if(_database == null){
      _database=await initialDb();
      return _database;
    }else{
      return _database;
    }
  }
   initialDb()async{
    String dataBasePath= await getDatabasesPath();
    // using path.dart to make pat like it    dataBasePath/kinany.db
    String path=join(dataBasePath,'kinany.db');
    Database myDb=await openDatabase(path,onCreate:_onCreate,version: 2,onUpgrade: _onUpgrade);
    return myDb;
  }

  _onUpgrade(Database db,int oldVersion,int newVersion){
     print('Upgreade===========');
     //db.execute("ALTER TABLE notes ADD COLUMN color TEXT ");
  }
    _onCreate(Database db,int version)async{
     await db.execute('''
    CREATE TABLE "notes" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
    "note" TEXT NOT NULL ,
    "title" TEXT NOT NULL ,
    "color" TEXT NOT NULL
    ) 
    ''');

     print('create DataBase and table ============');
  }

  readData(String sql)async{
    Database? myDb=await db;
    List<Map> response=await myDb!.rawQuery(sql);
    return response;
  }
  insertData(String sql)async{
    Database? myDb=await db;
    int response=await myDb!.rawInsert(sql);
    print('insert data==========');
    return response;
  }
  upDateData(String sql)async{
    Database? myDb=await db;
    int response=await myDb!.rawUpdate(sql);
    return response;
  }
  deleteData(String sql)async{
    Database? myDb=await db;
    int response=await myDb!.rawDelete(sql);
    return response;
  }
  myDeleteDataBase()async{
    String dataBasePath= await getDatabasesPath();
    String path=join(dataBasePath,'kinany.db');
     await deleteDatabase(path);
  }


  read(String table)async{
    Database? myDb=await db;
    List<Map> response=await myDb!.query(table);
    return response;
  }
  insert(String table,Map<String,Object?> values)async{
    Database? myDb=await db;
    int response=await myDb!.insert(table, values);
    print('insert data==========');
    return response;
  }
  upDate(String table,Map<String,Object?>values,String where)async{
    Database? myDb=await db;
    int response=await myDb!.update(table,values,where: where);
    return response;
  }
  delete(String table,String where)async{
    Database? myDb=await db;
    int response=await myDb!.delete(table,where:where );
    return response;
  }
}
