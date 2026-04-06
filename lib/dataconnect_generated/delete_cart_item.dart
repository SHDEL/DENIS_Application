part of 'generated.dart';

class DeleteCartItemVariablesBuilder {
  String cartItemId;

  final FirebaseDataConnect _dataConnect;
  DeleteCartItemVariablesBuilder(this._dataConnect, {required  this.cartItemId,});
  Deserializer<DeleteCartItemData> dataDeserializer = (dynamic json)  => DeleteCartItemData.fromJson(jsonDecode(json));
  Serializer<DeleteCartItemVariables> varsSerializer = (DeleteCartItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteCartItemData, DeleteCartItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteCartItemData, DeleteCartItemVariables> ref() {
    DeleteCartItemVariables vars= DeleteCartItemVariables(cartItemId: cartItemId,);
    return _dataConnect.mutation("DeleteCartItem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteCartItemCartItemDelete {
  final String id;
  DeleteCartItemCartItemDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteCartItemCartItemDelete otherTyped = other as DeleteCartItemCartItemDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteCartItemCartItemDelete({
    required this.id,
  });
}

@immutable
class DeleteCartItemData {
  final DeleteCartItemCartItemDelete? cartItem_delete;
  DeleteCartItemData.fromJson(dynamic json):
  
  cartItem_delete = json['cartItem_delete'] == null ? null : DeleteCartItemCartItemDelete.fromJson(json['cartItem_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteCartItemData otherTyped = other as DeleteCartItemData;
    return cartItem_delete == otherTyped.cartItem_delete;
    
  }
  @override
  int get hashCode => cartItem_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (cartItem_delete != null) {
      json['cartItem_delete'] = cartItem_delete!.toJson();
    }
    return json;
  }

  DeleteCartItemData({
    this.cartItem_delete,
  });
}

@immutable
class DeleteCartItemVariables {
  final String cartItemId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteCartItemVariables.fromJson(Map<String, dynamic> json):
  
  cartItemId = nativeFromJson<String>(json['cartItemId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteCartItemVariables otherTyped = other as DeleteCartItemVariables;
    return cartItemId == otherTyped.cartItemId;
    
  }
  @override
  int get hashCode => cartItemId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['cartItemId'] = nativeToJson<String>(cartItemId);
    return json;
  }

  DeleteCartItemVariables({
    required this.cartItemId,
  });
}

