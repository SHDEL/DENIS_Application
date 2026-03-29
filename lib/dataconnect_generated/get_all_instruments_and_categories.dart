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
  GetAllInstrumentsAndCategoriesInstruments.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  imageUrl = nativeFromJson<String>(json['imageUrl']),
  category = GetAllInstrumentsAndCategoriesInstrumentsCategory.fromJson(json['category']);
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
    category == otherTyped.category;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, imageUrl.hashCode, category.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['imageUrl'] = nativeToJson<String>(imageUrl);
    json['category'] = category.toJson();
    return json;
  }

  GetAllInstrumentsAndCategoriesInstruments({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
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

