part of 'generated.dart';

class GetMyOrdersVariablesBuilder {
  String userId;

  final FirebaseDataConnect _dataConnect;
  GetMyOrdersVariablesBuilder(this._dataConnect, {required  this.userId,});
  Deserializer<GetMyOrdersData> dataDeserializer = (dynamic json)  => GetMyOrdersData.fromJson(jsonDecode(json));
  Serializer<GetMyOrdersVariables> varsSerializer = (GetMyOrdersVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetMyOrdersData, GetMyOrdersVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetMyOrdersData, GetMyOrdersVariables> ref() {
    GetMyOrdersVariables vars= GetMyOrdersVariables(userId: userId,);
    return _dataConnect.query("GetMyOrders", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetMyOrdersOrders {
  final String id;
  final Timestamp orderDate;
  final int totalQty;
  final String status;
  GetMyOrdersOrders.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  orderDate = Timestamp.fromJson(json['orderDate']),
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

    final GetMyOrdersOrders otherTyped = other as GetMyOrdersOrders;
    return id == otherTyped.id && 
    orderDate == otherTyped.orderDate && 
    totalQty == otherTyped.totalQty && 
    status == otherTyped.status;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, orderDate.hashCode, totalQty.hashCode, status.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['orderDate'] = orderDate.toJson();
    json['totalQty'] = nativeToJson<int>(totalQty);
    json['status'] = nativeToJson<String>(status);
    return json;
  }

  GetMyOrdersOrders({
    required this.id,
    required this.orderDate,
    required this.totalQty,
    required this.status,
  });
}

@immutable
class GetMyOrdersData {
  final List<GetMyOrdersOrders> orders;
  GetMyOrdersData.fromJson(dynamic json):
  
  orders = (json['orders'] as List<dynamic>)
        .map((e) => GetMyOrdersOrders.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyOrdersData otherTyped = other as GetMyOrdersData;
    return orders == otherTyped.orders;
    
  }
  @override
  int get hashCode => orders.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['orders'] = orders.map((e) => e.toJson()).toList();
    return json;
  }

  GetMyOrdersData({
    required this.orders,
  });
}

@immutable
class GetMyOrdersVariables {
  final String userId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetMyOrdersVariables.fromJson(Map<String, dynamic> json):
  
  userId = nativeFromJson<String>(json['userId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyOrdersVariables otherTyped = other as GetMyOrdersVariables;
    return userId == otherTyped.userId;
    
  }
  @override
  int get hashCode => userId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  GetMyOrdersVariables({
    required this.userId,
  });
}

