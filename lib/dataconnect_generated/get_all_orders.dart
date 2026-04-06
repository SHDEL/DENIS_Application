part of 'generated.dart';

class GetAllOrdersVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetAllOrdersVariablesBuilder(this._dataConnect, );
  Deserializer<GetAllOrdersData> dataDeserializer = (dynamic json)  => GetAllOrdersData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetAllOrdersData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetAllOrdersData, void> ref() {
    
    return _dataConnect.query("GetAllOrders", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class GetAllOrdersOrders {
  final String id;
  final Timestamp orderDate;
  final int totalQty;
  final String status;
  final GetAllOrdersOrdersUser user;
  GetAllOrdersOrders.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  orderDate = Timestamp.fromJson(json['orderDate']),
  totalQty = nativeFromJson<int>(json['totalQty']),
  status = nativeFromJson<String>(json['status']),
  user = GetAllOrdersOrdersUser.fromJson(json['user']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetAllOrdersOrders otherTyped = other as GetAllOrdersOrders;
    return id == otherTyped.id && 
    orderDate == otherTyped.orderDate && 
    totalQty == otherTyped.totalQty && 
    status == otherTyped.status && 
    user == otherTyped.user;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, orderDate.hashCode, totalQty.hashCode, status.hashCode, user.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['orderDate'] = orderDate.toJson();
    json['totalQty'] = nativeToJson<int>(totalQty);
    json['status'] = nativeToJson<String>(status);
    json['user'] = user.toJson();
    return json;
  }

  GetAllOrdersOrders({
    required this.id,
    required this.orderDate,
    required this.totalQty,
    required this.status,
    required this.user,
  });
}

@immutable
class GetAllOrdersOrdersUser {
  final String username;
  final String email;
  GetAllOrdersOrdersUser.fromJson(dynamic json):
  
  username = nativeFromJson<String>(json['username']),
  email = nativeFromJson<String>(json['email']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetAllOrdersOrdersUser otherTyped = other as GetAllOrdersOrdersUser;
    return username == otherTyped.username && 
    email == otherTyped.email;
    
  }
  @override
  int get hashCode => Object.hashAll([username.hashCode, email.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['username'] = nativeToJson<String>(username);
    json['email'] = nativeToJson<String>(email);
    return json;
  }

  GetAllOrdersOrdersUser({
    required this.username,
    required this.email,
  });
}

@immutable
class GetAllOrdersData {
  final List<GetAllOrdersOrders> orders;
  GetAllOrdersData.fromJson(dynamic json):
  
  orders = (json['orders'] as List<dynamic>)
        .map((e) => GetAllOrdersOrders.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetAllOrdersData otherTyped = other as GetAllOrdersData;
    return orders == otherTyped.orders;
    
  }
  @override
  int get hashCode => orders.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['orders'] = orders.map((e) => e.toJson()).toList();
    return json;
  }

  GetAllOrdersData({
    required this.orders,
  });
}

