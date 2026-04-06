part of 'generated.dart';

class ClearCartItemsVariablesBuilder {
  String cartId;

  final FirebaseDataConnect _dataConnect;
  ClearCartItemsVariablesBuilder(this._dataConnect, {required  this.cartId,});
  Deserializer<ClearCartItemsData> dataDeserializer = (dynamic json)  => ClearCartItemsData.fromJson(jsonDecode(json));
  Serializer<ClearCartItemsVariables> varsSerializer = (ClearCartItemsVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<ClearCartItemsData, ClearCartItemsVariables>> execute() {
    return ref().execute();
  }

  MutationRef<ClearCartItemsData, ClearCartItemsVariables> ref() {
    ClearCartItemsVariables vars= ClearCartItemsVariables(cartId: cartId,);
    return _dataConnect.mutation("ClearCartItems", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ClearCartItemsData {
  final int cartItem_deleteMany;
  ClearCartItemsData.fromJson(dynamic json):
  
  cartItem_deleteMany = nativeFromJson<int>(json['cartItem_deleteMany']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ClearCartItemsData otherTyped = other as ClearCartItemsData;
    return cartItem_deleteMany == otherTyped.cartItem_deleteMany;
    
  }
  @override
  int get hashCode => cartItem_deleteMany.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['cartItem_deleteMany'] = nativeToJson<int>(cartItem_deleteMany);
    return json;
  }

  ClearCartItemsData({
    required this.cartItem_deleteMany,
  });
}

@immutable
class ClearCartItemsVariables {
  final String cartId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ClearCartItemsVariables.fromJson(Map<String, dynamic> json):
  
  cartId = nativeFromJson<String>(json['cartId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ClearCartItemsVariables otherTyped = other as ClearCartItemsVariables;
    return cartId == otherTyped.cartId;
    
  }
  @override
  int get hashCode => cartId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['cartId'] = nativeToJson<String>(cartId);
    return json;
  }

  ClearCartItemsVariables({
    required this.cartId,
  });
}

