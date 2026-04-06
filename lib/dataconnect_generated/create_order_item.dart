part of 'generated.dart';

class CreateOrderItemVariablesBuilder {
  String orderId;
  String instrumentId;
  int qty;

  final FirebaseDataConnect _dataConnect;
  CreateOrderItemVariablesBuilder(this._dataConnect, {required  this.orderId,required  this.instrumentId,required  this.qty,});
  Deserializer<CreateOrderItemData> dataDeserializer = (dynamic json)  => CreateOrderItemData.fromJson(jsonDecode(json));
  Serializer<CreateOrderItemVariables> varsSerializer = (CreateOrderItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateOrderItemData, CreateOrderItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateOrderItemData, CreateOrderItemVariables> ref() {
    CreateOrderItemVariables vars= CreateOrderItemVariables(orderId: orderId,instrumentId: instrumentId,qty: qty,);
    return _dataConnect.mutation("CreateOrderItem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateOrderItemOrderItemInsert {
  final String id;
  CreateOrderItemOrderItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateOrderItemOrderItemInsert otherTyped = other as CreateOrderItemOrderItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateOrderItemOrderItemInsert({
    required this.id,
  });
}

@immutable
class CreateOrderItemData {
  final CreateOrderItemOrderItemInsert orderItem_insert;
  CreateOrderItemData.fromJson(dynamic json):
  
  orderItem_insert = CreateOrderItemOrderItemInsert.fromJson(json['orderItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateOrderItemData otherTyped = other as CreateOrderItemData;
    return orderItem_insert == otherTyped.orderItem_insert;
    
  }
  @override
  int get hashCode => orderItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['orderItem_insert'] = orderItem_insert.toJson();
    return json;
  }

  CreateOrderItemData({
    required this.orderItem_insert,
  });
}

@immutable
class CreateOrderItemVariables {
  final String orderId;
  final String instrumentId;
  final int qty;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateOrderItemVariables.fromJson(Map<String, dynamic> json):
  
  orderId = nativeFromJson<String>(json['orderId']),
  instrumentId = nativeFromJson<String>(json['instrumentId']),
  qty = nativeFromJson<int>(json['qty']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateOrderItemVariables otherTyped = other as CreateOrderItemVariables;
    return orderId == otherTyped.orderId && 
    instrumentId == otherTyped.instrumentId && 
    qty == otherTyped.qty;
    
  }
  @override
  int get hashCode => Object.hashAll([orderId.hashCode, instrumentId.hashCode, qty.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['orderId'] = nativeToJson<String>(orderId);
    json['instrumentId'] = nativeToJson<String>(instrumentId);
    json['qty'] = nativeToJson<int>(qty);
    return json;
  }

  CreateOrderItemVariables({
    required this.orderId,
    required this.instrumentId,
    required this.qty,
  });
}

