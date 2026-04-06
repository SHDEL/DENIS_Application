part of 'generated.dart';

class CreateOrderVariablesBuilder {
  String userId;
  int totalQty;
  String status;

  final FirebaseDataConnect _dataConnect;
  CreateOrderVariablesBuilder(this._dataConnect, {required  this.userId,required  this.totalQty,required  this.status,});
  Deserializer<CreateOrderData> dataDeserializer = (dynamic json)  => CreateOrderData.fromJson(jsonDecode(json));
  Serializer<CreateOrderVariables> varsSerializer = (CreateOrderVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateOrderData, CreateOrderVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateOrderData, CreateOrderVariables> ref() {
    CreateOrderVariables vars= CreateOrderVariables(userId: userId,totalQty: totalQty,status: status,);
    return _dataConnect.mutation("CreateOrder", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateOrderOrderInsert {
  final String id;
  CreateOrderOrderInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateOrderOrderInsert otherTyped = other as CreateOrderOrderInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateOrderOrderInsert({
    required this.id,
  });
}

@immutable
class CreateOrderData {
  final CreateOrderOrderInsert order_insert;
  CreateOrderData.fromJson(dynamic json):
  
  order_insert = CreateOrderOrderInsert.fromJson(json['order_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateOrderData otherTyped = other as CreateOrderData;
    return order_insert == otherTyped.order_insert;
    
  }
  @override
  int get hashCode => order_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['order_insert'] = order_insert.toJson();
    return json;
  }

  CreateOrderData({
    required this.order_insert,
  });
}

@immutable
class CreateOrderVariables {
  final String userId;
  final int totalQty;
  final String status;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateOrderVariables.fromJson(Map<String, dynamic> json):
  
  userId = nativeFromJson<String>(json['userId']),
  totalQty = nativeFromJson<int>(json['totalQty']),
  status = nativeFromJson<String>(json['status']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateOrderVariables otherTyped = other as CreateOrderVariables;
    return userId == otherTyped.userId && 
    totalQty == otherTyped.totalQty && 
    status == otherTyped.status;
    
  }
  @override
  int get hashCode => Object.hashAll([userId.hashCode, totalQty.hashCode, status.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    json['totalQty'] = nativeToJson<int>(totalQty);
    json['status'] = nativeToJson<String>(status);
    return json;
  }

  CreateOrderVariables({
    required this.userId,
    required this.totalQty,
    required this.status,
  });
}

