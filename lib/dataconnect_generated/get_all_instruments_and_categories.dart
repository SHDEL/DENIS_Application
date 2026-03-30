part of 'generated.dart';

class GetAllInstrumentsAndCategoriesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetAllInstrumentsAndCategoriesVariablesBuilder(this._dataConnect, );
  Deserializer<GetAllInstrumentsAndCategoriesData> dataDeserializer = (dynamic json)  => GetAllInstrumentsAndCategoriesData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetAllInstrumentsAndCategoriesData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetAllInstrumentsAndCategoriesData, void> ref() {
    
    return _dataConnect.query("GetAllInstrumentsAndCategories", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class GetAllInstrumentsAndCategoriesInstrumentCategories {
  final String id;
  final String name;
  GetAllInstrumentsAndCategoriesInstrumentCategories.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetAllInstrumentsAndCategoriesInstrumentCategories otherTyped = other as GetAllInstrumentsAndCategoriesInstrumentCategories;
    return id == otherTyped.id && 
    name == otherTyped.name;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  GetAllInstrumentsAndCategoriesInstrumentCategories({
    required this.id,
    required this.name,
  });
}

@immutable
class GetAllInstrumentsAndCategoriesInstruments {
  final String id;
  final String name;
  final String imageUrl;
  final GetAllInstrumentsAndCategoriesInstrumentsCategory category;
  final String description;
  final List<GetAllInstrumentsAndCategoriesInstrumentsStocksOnInstrument> stocks_on_instrument;
  GetAllInstrumentsAndCategoriesInstruments.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  imageUrl = nativeFromJson<String>(json['imageUrl']),
  category = GetAllInstrumentsAndCategoriesInstrumentsCategory.fromJson(json['category']),
  description = nativeFromJson<String>(json['description']),
  stocks_on_instrument = (json['stocks_on_instrument'] as List<dynamic>)
        .map((e) => GetAllInstrumentsAndCategoriesInstrumentsStocksOnInstrument.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetAllInstrumentsAndCategoriesInstruments otherTyped = other as GetAllInstrumentsAndCategoriesInstruments;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    imageUrl == otherTyped.imageUrl && 
    category == otherTyped.category && 
    description == otherTyped.description && 
    stocks_on_instrument == otherTyped.stocks_on_instrument;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, imageUrl.hashCode, category.hashCode, description.hashCode, stocks_on_instrument.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['imageUrl'] = nativeToJson<String>(imageUrl);
    json['category'] = category.toJson();
    json['description'] = nativeToJson<String>(description);
    json['stocks_on_instrument'] = stocks_on_instrument.map((e) => e.toJson()).toList();
    return json;
  }

  GetAllInstrumentsAndCategoriesInstruments({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.description,
    required this.stocks_on_instrument,
  });
}

@immutable
class GetAllInstrumentsAndCategoriesInstrumentsCategory {
  final String id;
  final String name;
  GetAllInstrumentsAndCategoriesInstrumentsCategory.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetAllInstrumentsAndCategoriesInstrumentsCategory otherTyped = other as GetAllInstrumentsAndCategoriesInstrumentsCategory;
    return id == otherTyped.id && 
    name == otherTyped.name;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  GetAllInstrumentsAndCategoriesInstrumentsCategory({
    required this.id,
    required this.name,
  });
}

@immutable
class GetAllInstrumentsAndCategoriesInstrumentsStocksOnInstrument {
  final String id;
  final int inStockQty;
  final int inUseQty;
  final String shelf;
  GetAllInstrumentsAndCategoriesInstrumentsStocksOnInstrument.fromJson(dynamic json):
  
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

    final GetAllInstrumentsAndCategoriesInstrumentsStocksOnInstrument otherTyped = other as GetAllInstrumentsAndCategoriesInstrumentsStocksOnInstrument;
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

  GetAllInstrumentsAndCategoriesInstrumentsStocksOnInstrument({
    required this.id,
    required this.inStockQty,
    required this.inUseQty,
    required this.shelf,
  });
}

@immutable
class GetAllInstrumentsAndCategoriesData {
  final List<GetAllInstrumentsAndCategoriesInstrumentCategories> instrumentCategories;
  final List<GetAllInstrumentsAndCategoriesInstruments> instruments;
  GetAllInstrumentsAndCategoriesData.fromJson(dynamic json):
  
  instrumentCategories = (json['instrumentCategories'] as List<dynamic>)
        .map((e) => GetAllInstrumentsAndCategoriesInstrumentCategories.fromJson(e))
        .toList(),
  instruments = (json['instruments'] as List<dynamic>)
        .map((e) => GetAllInstrumentsAndCategoriesInstruments.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetAllInstrumentsAndCategoriesData otherTyped = other as GetAllInstrumentsAndCategoriesData;
    return instrumentCategories == otherTyped.instrumentCategories && 
    instruments == otherTyped.instruments;
    
  }
  @override
  int get hashCode => Object.hashAll([instrumentCategories.hashCode, instruments.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['instrumentCategories'] = instrumentCategories.map((e) => e.toJson()).toList();
    json['instruments'] = instruments.map((e) => e.toJson()).toList();
    return json;
  }

  GetAllInstrumentsAndCategoriesData({
    required this.instrumentCategories,
    required this.instruments,
  });
}

