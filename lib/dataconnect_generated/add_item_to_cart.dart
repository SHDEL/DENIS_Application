part of 'generated.dart';

class AddItemToCartVariablesBuilder {
  String cartId;
  String instrumentId;
  int quantity;

  final FirebaseDataConnect _dataConnect;
  AddItemToCartVariablesBuilder(this._dataConnect, {required  this.cartId,required  this.instrumentId,required  this.quantity,});
  Deserializer<AddItemToCartData> dataDeserializer = (dynamic json)  => AddItemToCartData.fromJson(jsonDecode(json));
  Serializer<AddItemToCartVariables> varsSerializer = (AddItemToCartVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AddItemToCartData, AddItemToCartVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AddItemToCartData, AddItemToCartVariables> ref() {
    AddItemToCartVariables vars= AddItemToCartVariables(cartId: cartId,instrumentId: instrumentId,quantity: quantity,);
    return _dataConnect.mutation("addItemToCart", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AddItemToCartCartItemInsert {
  final String id;
  AddItemToCartCartItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddItemToCartCartItemInsert otherTyped = other as AddItemToCartCartItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AddItemToCartCartItemInsert({
    required this.id,
  });
}

@immutable
class AddItemToCartData {
  final AddItemToCartCartItemInsert cartItem_insert;
  AddItemToCartData.fromJson(dynamic json):
  
  cartItem_insert = AddItemToCartCartItemInsert.fromJson(json['cartItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddItemToCartData otherTyped = other as AddItemToCartData;
    return cartItem_insert == otherTyped.cartItem_insert;
    
  }
  @override
  int get hashCode => cartItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['cartItem_insert'] = cartItem_insert.toJson();
    return json;
  }

  AddItemToCartData({
    required this.cartItem_insert,
  });
}

@immutable
class AddItemToCartVariables {
  final String cartId;
  final String instrumentId;
  final int quantity;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AddItemToCartVariables.fromJson(Map<String, dynamic> json):
  
  cartId = nativeFromJson<String>(json['cartId']),
  instrumentId = nativeFromJson<String>(json['instrumentId']),
  quantity = nativeFromJson<int>(json['quantity']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddItemToCartVariables otherTyped = other as AddItemToCartVariables;
    return cartId == otherTyped.cartId && 
    instrumentId == otherTyped.instrumentId && 
    quantity == otherTyped.quantity;
    
  }
  @override
  int get hashCode => Object.hashAll([cartId.hashCode, instrumentId.hashCode, quantity.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['cartId'] = nativeToJson<String>(cartId);
    json['instrumentId'] = nativeToJson<String>(instrumentId);
    json['quantity'] = nativeToJson<int>(quantity);
    return json;
  }

  AddItemToCartVariables({
    required this.cartId,
    required this.instrumentId,
    required this.quantity,
  });
}

