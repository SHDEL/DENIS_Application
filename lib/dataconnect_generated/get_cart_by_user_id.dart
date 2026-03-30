part of 'generated.dart';

class GetCartByUserIdVariablesBuilder {
  String userId;

  final FirebaseDataConnect _dataConnect;
  GetCartByUserIdVariablesBuilder(this._dataConnect, {required  this.userId,});
  Deserializer<GetCartByUserIdData> dataDeserializer = (dynamic json)  => GetCartByUserIdData.fromJson(jsonDecode(json));
  Serializer<GetCartByUserIdVariables> varsSerializer = (GetCartByUserIdVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetCartByUserIdData, GetCartByUserIdVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetCartByUserIdData, GetCartByUserIdVariables> ref() {
    GetCartByUserIdVariables vars= GetCartByUserIdVariables(userId: userId,);
    return _dataConnect.query("GetCartByUserId", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetCartByUserIdCarts {
  final String id;
  final String userId;
  final int totalQty;
  GetCartByUserIdCarts.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  userId = nativeFromJson<String>(json['userId']),
  totalQty = nativeFromJson<int>(json['totalQty']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetCartByUserIdCarts otherTyped = other as GetCartByUserIdCarts;
    return id == otherTyped.id && 
    userId == otherTyped.userId && 
    totalQty == otherTyped.totalQty;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, userId.hashCode, totalQty.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['userId'] = nativeToJson<String>(userId);
    json['totalQty'] = nativeToJson<int>(totalQty);
    return json;
  }

  GetCartByUserIdCarts({
    required this.id,
    required this.userId,
    required this.totalQty,
  });
}

@immutable
class GetCartByUserIdData {
  final List<GetCartByUserIdCarts> carts;
  GetCartByUserIdData.fromJson(dynamic json):
  
  carts = (json['carts'] as List<dynamic>)
        .map((e) => GetCartByUserIdCarts.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetCartByUserIdData otherTyped = other as GetCartByUserIdData;
    return carts == otherTyped.carts;
    
  }
  @override
  int get hashCode => carts.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['carts'] = carts.map((e) => e.toJson()).toList();
    return json;
  }

  GetCartByUserIdData({
    required this.carts,
  });
}

@immutable
class GetCartByUserIdVariables {
  final String userId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetCartByUserIdVariables.fromJson(Map<String, dynamic> json):
  
  userId = nativeFromJson<String>(json['userId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetCartByUserIdVariables otherTyped = other as GetCartByUserIdVariables;
    return userId == otherTyped.userId;
    
  }
  @override
  int get hashCode => userId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  GetCartByUserIdVariables({
    required this.userId,
  });
}

