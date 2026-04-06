part of 'generated.dart';

class UpdateStockVariablesBuilder {
  String id;
  int inStockQty;
  int inUseQty;

  final FirebaseDataConnect _dataConnect;
  UpdateStockVariablesBuilder(this._dataConnect, {required  this.id,required  this.inStockQty,required  this.inUseQty,});
  Deserializer<UpdateStockData> dataDeserializer = (dynamic json)  => UpdateStockData.fromJson(jsonDecode(json));
  Serializer<UpdateStockVariables> varsSerializer = (UpdateStockVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateStockData, UpdateStockVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateStockData, UpdateStockVariables> ref() {
    UpdateStockVariables vars= UpdateStockVariables(id: id,inStockQty: inStockQty,inUseQty: inUseQty,);
    return _dataConnect.mutation("updateStock", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateStockStockUpdate {
  final String id;
  UpdateStockStockUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateStockStockUpdate otherTyped = other as UpdateStockStockUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateStockStockUpdate({
    required this.id,
  });
}

@immutable
class UpdateStockData {
  final UpdateStockStockUpdate? stock_update;
  UpdateStockData.fromJson(dynamic json):
  
  stock_update = json['stock_update'] == null ? null : UpdateStockStockUpdate.fromJson(json['stock_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateStockData otherTyped = other as UpdateStockData;
    return stock_update == otherTyped.stock_update;
    
  }
  @override
  int get hashCode => stock_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (stock_update != null) {
      json['stock_update'] = stock_update!.toJson();
    }
    return json;
  }

  UpdateStockData({
    this.stock_update,
  });
}

@immutable
class UpdateStockVariables {
  final String id;
  final int inStockQty;
  final int inUseQty;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateStockVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  inStockQty = nativeFromJson<int>(json['inStockQty']),
  inUseQty = nativeFromJson<int>(json['inUseQty']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateStockVariables otherTyped = other as UpdateStockVariables;
    return id == otherTyped.id && 
    inStockQty == otherTyped.inStockQty && 
    inUseQty == otherTyped.inUseQty;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, inStockQty.hashCode, inUseQty.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['inStockQty'] = nativeToJson<int>(inStockQty);
    json['inUseQty'] = nativeToJson<int>(inUseQty);
    return json;
  }

  UpdateStockVariables({
    required this.id,
    required this.inStockQty,
    required this.inUseQty,
  });
}

