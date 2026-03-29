part of 'generated.dart';

class GetCategoryCarouselVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetCategoryCarouselVariablesBuilder(this._dataConnect, );
  Deserializer<GetCategoryCarouselData> dataDeserializer = (dynamic json)  => GetCategoryCarouselData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetCategoryCarouselData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetCategoryCarouselData, void> ref() {
    
    return _dataConnect.query("GetCategoryCarousel", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class GetCategoryCarouselInstrumentCategories {
  final String id;
  final String name;
  final List<GetCategoryCarouselInstrumentCategoriesInstrumentsOnCategory> instruments_on_category;
  GetCategoryCarouselInstrumentCategories.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  instruments_on_category = (json['instruments_on_category'] as List<dynamic>)
        .map((e) => GetCategoryCarouselInstrumentCategoriesInstrumentsOnCategory.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetCategoryCarouselInstrumentCategories otherTyped = other as GetCategoryCarouselInstrumentCategories;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    instruments_on_category == otherTyped.instruments_on_category;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, instruments_on_category.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['instruments_on_category'] = instruments_on_category.map((e) => e.toJson()).toList();
    return json;
  }

  GetCategoryCarouselInstrumentCategories({
    required this.id,
    required this.name,
    required this.instruments_on_category,
  });
}

@immutable
class GetCategoryCarouselInstrumentCategoriesInstrumentsOnCategory {
  final String imageUrl;
  GetCategoryCarouselInstrumentCategoriesInstrumentsOnCategory.fromJson(dynamic json):
  
  imageUrl = nativeFromJson<String>(json['imageUrl']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetCategoryCarouselInstrumentCategoriesInstrumentsOnCategory otherTyped = other as GetCategoryCarouselInstrumentCategoriesInstrumentsOnCategory;
    return imageUrl == otherTyped.imageUrl;
    
  }
  @override
  int get hashCode => imageUrl.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['imageUrl'] = nativeToJson<String>(imageUrl);
    return json;
  }

  GetCategoryCarouselInstrumentCategoriesInstrumentsOnCategory({
    required this.imageUrl,
  });
}

@immutable
class GetCategoryCarouselData {
  final List<GetCategoryCarouselInstrumentCategories> instrumentCategories;
  GetCategoryCarouselData.fromJson(dynamic json):
  
  instrumentCategories = (json['instrumentCategories'] as List<dynamic>)
        .map((e) => GetCategoryCarouselInstrumentCategories.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetCategoryCarouselData otherTyped = other as GetCategoryCarouselData;
    return instrumentCategories == otherTyped.instrumentCategories;
    
  }
  @override
  int get hashCode => instrumentCategories.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['instrumentCategories'] = instrumentCategories.map((e) => e.toJson()).toList();
    return json;
  }

  GetCategoryCarouselData({
    required this.instrumentCategories,
  });
}

