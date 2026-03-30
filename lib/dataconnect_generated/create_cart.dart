part of 'generated.dart';

class CreateCartVariablesBuilder {
  String userId;
  int quantity;

  final FirebaseDataConnect _dataConnect;
  CreateCartVariablesBuilder(this._dataConnect, {required  this.userId,required  this.quantity,});
  Deserializer<CreateCartData> dataDeserializer = (dynamic json)  => CreateCartData.fromJson(jsonDecode(json));
  Serializer<CreateCartVariables> varsSerializer = (CreateCartVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateCartData, CreateCartVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateCartData, CreateCartVariables> ref() {
    CreateCartVariables vars= CreateCartVariables(userId: userId,quantity: quantity,);
    return _dataConnect.mutation("CreateCart", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateCartCartInsert {
  final String id;
  CreateCartCartInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateCartCartInsert otherTyped = other as CreateCartCartInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateCartCartInsert({
    required this.id,
  });
}

@immutable
class CreateCartData {
  final CreateCartCartInsert cart_insert;
  CreateCartData.fromJson(dynamic json):
  
  cart_insert = CreateCartCartInsert.fromJson(json['cart_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateCartData otherTyped = other as CreateCartData;
    return cart_insert == otherTyped.cart_insert;
    
  }
  @override
  int get hashCode => cart_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['cart_insert'] = cart_insert.toJson();
    return json;
  }

  CreateCartData({
    required this.cart_insert,
  });
}

@immutable
class CreateCartVariables {
  final String userId;
  final int quantity;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateCartVariables.fromJson(Map<String, dynamic> json):
  
  userId = nativeFromJson<String>(json['userId']),
  quantity = nativeFromJson<int>(json['quantity']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateCartVariables otherTyped = other as CreateCartVariables;
    return userId == otherTyped.userId && 
    quantity == otherTyped.quantity;
    
  }
  @override
  int get hashCode => Object.hashAll([userId.hashCode, quantity.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    json['quantity'] = nativeToJson<int>(quantity);
    return json;
  }

  CreateCartVariables({
    required this.userId,
    required this.quantity,
  });
}

