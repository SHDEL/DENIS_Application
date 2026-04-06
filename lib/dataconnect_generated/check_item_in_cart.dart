part of 'generated.dart';

class CheckItemInCartVariablesBuilder {
  String cartId;
  String instrumentId;

  final FirebaseDataConnect _dataConnect;
  CheckItemInCartVariablesBuilder(this._dataConnect, {required  this.cartId,required  this.instrumentId,});
  Deserializer<CheckItemInCartData> dataDeserializer = (dynamic json)  => CheckItemInCartData.fromJson(jsonDecode(json));
  Serializer<CheckItemInCartVariables> varsSerializer = (CheckItemInCartVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<CheckItemInCartData, CheckItemInCartVariables>> execute() {
    return ref().execute();
  }

  QueryRef<CheckItemInCartData, CheckItemInCartVariables> ref() {
    CheckItemInCartVariables vars= CheckItemInCartVariables(cartId: cartId,instrumentId: instrumentId,);
    return _dataConnect.query("CheckItemInCart", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CheckItemInCartCartItems {
  final String id;
  final int qty;
  CheckItemInCartCartItems.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  qty = nativeFromJson<int>(json['qty']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CheckItemInCartCartItems otherTyped = other as CheckItemInCartCartItems;
    return id == otherTyped.id && 
    qty == otherTyped.qty;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, qty.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['qty'] = nativeToJson<int>(qty);
    return json;
  }

  CheckItemInCartCartItems({
    required this.id,
    required this.qty,
  });
}

@immutable
class CheckItemInCartData {
  final List<CheckItemInCartCartItems> cartItems;
  CheckItemInCartData.fromJson(dynamic json):
  
  cartItems = (json['cartItems'] as List<dynamic>)
        .map((e) => CheckItemInCartCartItems.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CheckItemInCartData otherTyped = other as CheckItemInCartData;
    return cartItems == otherTyped.cartItems;
    
  }
  @override
  int get hashCode => cartItems.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['cartItems'] = cartItems.map((e) => e.toJson()).toList();
    return json;
  }

  CheckItemInCartData({
    required this.cartItems,
  });
}

@immutable
class CheckItemInCartVariables {
  final String cartId;
  final String instrumentId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CheckItemInCartVariables.fromJson(Map<String, dynamic> json):
  
  cartId = nativeFromJson<String>(json['cartId']),
  instrumentId = nativeFromJson<String>(json['instrumentId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CheckItemInCartVariables otherTyped = other as CheckItemInCartVariables;
    return cartId == otherTyped.cartId && 
    instrumentId == otherTyped.instrumentId;
    
  }
  @override
  int get hashCode => Object.hashAll([cartId.hashCode, instrumentId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['cartId'] = nativeToJson<String>(cartId);
    json['instrumentId'] = nativeToJson<String>(instrumentId);
    return json;
  }

  CheckItemInCartVariables({
    required this.cartId,
    required this.instrumentId,
  });
}

