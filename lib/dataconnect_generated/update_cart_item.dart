part of 'generated.dart';

class UpdateCartItemVariablesBuilder {
  String cartItemId;
  int quantity;

  final FirebaseDataConnect _dataConnect;
  UpdateCartItemVariablesBuilder(this._dataConnect, {required  this.cartItemId,required  this.quantity,});
  Deserializer<UpdateCartItemData> dataDeserializer = (dynamic json)  => UpdateCartItemData.fromJson(jsonDecode(json));
  Serializer<UpdateCartItemVariables> varsSerializer = (UpdateCartItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateCartItemData, UpdateCartItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateCartItemData, UpdateCartItemVariables> ref() {
    UpdateCartItemVariables vars= UpdateCartItemVariables(cartItemId: cartItemId,quantity: quantity,);
    return _dataConnect.mutation("updateCartItem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateCartItemCartItemUpdate {
  final String id;
  UpdateCartItemCartItemUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateCartItemCartItemUpdate otherTyped = other as UpdateCartItemCartItemUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateCartItemCartItemUpdate({
    required this.id,
  });
}

@immutable
class UpdateCartItemData {
  final UpdateCartItemCartItemUpdate? cartItem_update;
  UpdateCartItemData.fromJson(dynamic json):
  
  cartItem_update = json['cartItem_update'] == null ? null : UpdateCartItemCartItemUpdate.fromJson(json['cartItem_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateCartItemData otherTyped = other as UpdateCartItemData;
    return cartItem_update == otherTyped.cartItem_update;
    
  }
  @override
  int get hashCode => cartItem_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (cartItem_update != null) {
      json['cartItem_update'] = cartItem_update!.toJson();
    }
    return json;
  }

  UpdateCartItemData({
    this.cartItem_update,
  });
}

@immutable
class UpdateCartItemVariables {
  final String cartItemId;
  final int quantity;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateCartItemVariables.fromJson(Map<String, dynamic> json):
  
  cartItemId = nativeFromJson<String>(json['cartItemId']),
  quantity = nativeFromJson<int>(json['quantity']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateCartItemVariables otherTyped = other as UpdateCartItemVariables;
    return cartItemId == otherTyped.cartItemId && 
    quantity == otherTyped.quantity;
    
  }
  @override
  int get hashCode => Object.hashAll([cartItemId.hashCode, quantity.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['cartItemId'] = nativeToJson<String>(cartItemId);
    json['quantity'] = nativeToJson<int>(quantity);
    return json;
  }

  UpdateCartItemVariables({
    required this.cartItemId,
    required this.quantity,
  });
}

