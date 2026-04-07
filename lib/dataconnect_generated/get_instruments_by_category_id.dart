part of 'generated.dart';

class GetInstrumentsByCategoryIdVariablesBuilder {
  String categoryId;

  final FirebaseDataConnect _dataConnect;
  GetInstrumentsByCategoryIdVariablesBuilder(this._dataConnect, {required  this.categoryId,});
  Deserializer<GetInstrumentsByCategoryIdData> dataDeserializer = (dynamic json)  => GetInstrumentsByCategoryIdData.fromJson(jsonDecode(json));
  Serializer<GetInstrumentsByCategoryIdVariables> varsSerializer = (GetInstrumentsByCategoryIdVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetInstrumentsByCategoryIdData, GetInstrumentsByCategoryIdVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetInstrumentsByCategoryIdData, GetInstrumentsByCategoryIdVariables> ref() {
    GetInstrumentsByCategoryIdVariables vars= GetInstrumentsByCategoryIdVariables(categoryId: categoryId,);
    return _dataConnect.query("GetInstrumentsByCategoryId", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetInstrumentsByCategoryIdInstruments {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final GetInstrumentsByCategoryIdInstrumentsCategory category;
  final List<GetInstrumentsByCategoryIdInstrumentsStocksOnInstrument> stocks_on_instrument;
  GetInstrumentsByCategoryIdInstruments.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  description = nativeFromJson<String>(json['description']),
  imageUrl = nativeFromJson<String>(json['imageUrl']),
  category = GetInstrumentsByCategoryIdInstrumentsCategory.fromJson(json['category']),
  stocks_on_instrument = (json['stocks_on_instrument'] as List<dynamic>)
        .map((e) => GetInstrumentsByCategoryIdInstrumentsStocksOnInstrument.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetInstrumentsByCategoryIdInstruments otherTyped = other as GetInstrumentsByCategoryIdInstruments;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    description == otherTyped.description && 
    imageUrl == otherTyped.imageUrl && 
    category == otherTyped.category && 
    stocks_on_instrument == otherTyped.stocks_on_instrument;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, description.hashCode, imageUrl.hashCode, category.hashCode, stocks_on_instrument.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['description'] = nativeToJson<String>(description);
    json['imageUrl'] = nativeToJson<String>(imageUrl);
    json['category'] = category.toJson();
    json['stocks_on_instrument'] = stocks_on_instrument.map((e) => e.toJson()).toList();
    return json;
  }

  GetInstrumentsByCategoryIdInstruments({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.stocks_on_instrument,
  });
}

@immutable
class GetInstrumentsByCategoryIdInstrumentsCategory {
  final String name;
  GetInstrumentsByCategoryIdInstrumentsCategory.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetInstrumentsByCategoryIdInstrumentsCategory otherTyped = other as GetInstrumentsByCategoryIdInstrumentsCategory;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  GetInstrumentsByCategoryIdInstrumentsCategory({
    required this.name,
  });
}

@immutable
class GetInstrumentsByCategoryIdInstrumentsStocksOnInstrument {
  final String id;
  final int inStockQty;
  final int inUseQty;
  final String shelf;
  GetInstrumentsByCategoryIdInstrumentsStocksOnInstrument.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  inStockQty = nativeFromJson<int>(json['inStockQty']),
  inUseQty = nativeFromJson<int>(json['inUseQty']),
  shelf = nativeFromJson<String>(json['shelf']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetInstrumentsByCategoryIdInstrumentsStocksOnInstrument otherTyped = other as GetInstrumentsByCategoryIdInstrumentsStocksOnInstrument;
    return id == otherTyped.id && 
    inStockQty == otherTyped.inStockQty && 
    inUseQty == otherTyped.inUseQty && 
    shelf == otherTyped.shelf;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, inStockQty.hashCode, inUseQty.hashCode, shelf.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['inStockQty'] = nativeToJson<int>(inStockQty);
    json['inUseQty'] = nativeToJson<int>(inUseQty);
    json['shelf'] = nativeToJson<String>(shelf);
    return json;
  }

  GetInstrumentsByCategoryIdInstrumentsStocksOnInstrument({
    required this.id,
    required this.inStockQty,
    required this.inUseQty,
    required this.shelf,
  });
}

@immutable
class GetInstrumentsByCategoryIdData {
  final List<GetInstrumentsByCategoryIdInstruments> instruments;
  GetInstrumentsByCategoryIdData.fromJson(dynamic json):
  
  instruments = (json['instruments'] as List<dynamic>)
        .map((e) => GetInstrumentsByCategoryIdInstruments.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetInstrumentsByCategoryIdData otherTyped = other as GetInstrumentsByCategoryIdData;
    return instruments == otherTyped.instruments;
    
  }
  @override
  int get hashCode => instruments.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['instruments'] = instruments.map((e) => e.toJson()).toList();
    return json;
  }

  GetInstrumentsByCategoryIdData({
    required this.instruments,
  });
}

@immutable
class GetInstrumentsByCategoryIdVariables {
  final String categoryId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetInstrumentsByCategoryIdVariables.fromJson(Map<String, dynamic> json):
  
  categoryId = nativeFromJson<String>(json['categoryId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetInstrumentsByCategoryIdVariables otherTyped = other as GetInstrumentsByCategoryIdVariables;
    return categoryId == otherTyped.categoryId;
    
  }
  @override
  int get hashCode => categoryId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['categoryId'] = nativeToJson<String>(categoryId);
    return json;
  }

  GetInstrumentsByCategoryIdVariables({
    required this.categoryId,
  });
}

