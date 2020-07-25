import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:qirana_app/model/product_model.dart';

class SQLiteDbProvider {
  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "ProductDB.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE Product ("
            "productId TEXT PRIMARY KEY,"
            "name TEXT,"
            "metaDescription TEXT,"
            "price INTEGER,"
            "imageOne TEXT,"
            "size TEXT,"
            "quantity TEXT,"
            "cart INTEGER,"
            "fav INTEGER"
            ")");
      },
    );
  }

  Future<List<ProductModel>> getAllProducts() async {
    final db = await database;
    List<Map> results =
        await db.query("Product", columns: ProductModel.columns);
    List<ProductModel> products = new List();
    results.forEach((result) {
      ProductModel product = ProductModel.fromMap(result);
      products.add(product);
    });
    return products;
  }

  insert(ProductModel product, int cart, int fav, int quantity) async {
    final db = await database;
//    var maxIdResult = await db.rawQuery("SELECT MAX(primaryId)+1 as last_inserted_primaryId FROM Product");
//    var id = maxIdResult.first["last_inserted_primaryId"];
    var result = await db.rawInsert(
        "INSERT Into Product (productId, name, metaDescription, price, imageOne,cart,fav,quantity,size)"
        " VALUES (?, ?, ?, ?, ?,?,?,?,?)",
        [
          product.productId,
          product.name,
          product.metaDescription,
          product.price,
          product.imageOne,
          cart,
          fav,
          quantity,
          product.size
        ]);
    return result;
  }

  update(ProductModel product) async {
    final db = await database;
    var result = await db.update("Product", product.toMap(),
        where: "productId = ?", whereArgs: [product.productId]);
    return result;
  }

  delete(String id) async {
    final db = await database;
    db.delete("Product", where: "productId = ?", whereArgs: [id]);
  }

  Future<List<ProductModel>> getCart() async {
    final db = await database;
    List<Map> results = await db.query("Product",
        columns: ProductModel.columns, where: '"cart"=?', whereArgs: [1]);
    List<ProductModel> products = new List();
    results.forEach((result) {
      ProductModel product = ProductModel.fromMap(result);
      products.add(product);
    });
    return products;
  }

  Future<List<ProductModel>> getFav() async {
    final db = await database;
    List<Map> results = await db.query("Product",
        columns: ProductModel.columns, where: '"fav"=?', whereArgs: [1]);
    List<ProductModel> products = new List();
    results.forEach((result) {
      ProductModel product = ProductModel.fromMap(result);
      products.add(product);
    });
    return products;
  }
}
