part of 'generated.dart';

class GetOrderDetailsVariablesBuilder {
  String orderId;

  final FirebaseDataConnect _dataConnect;
  GetOrderDetailsVariablesBuilder(this._dataConnect, {required  this.orderId,});
  Deserializer<GetOrderDetailsData> dataDeserializer = (dynamic json)  => GetOrderDetailsData.fromJson(jsonDecode(json));
  Serializer<GetOrderDetailsVariables> varsSerializer = (GetOrderDetailsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetOrderDetailsData, GetOrderDetailsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetOrderDetailsData, GetOrderDetailsVariables> ref() {
    GetOrderDetailsVariables vars= GetOrderDetailsVariables(orderId: orderId,);
    return _dataConnect.query("GetOrderDetails", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetOrderDetailsOrder {
  final String id;
  final Timestamp orderDate;
  final String status;
  final int totalQty;
  final List<GetOrderDetailsOrderOrderItemsOnOrder> orderItems_on_order;
  GetOrderDetailsOrder.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  orderDate = Timestamp.fromJson(json['orderDate']),
  status = nativeFromJson<String>(json['status']),
  totalQty = nativeFromJson<int>(json['totalQty']),
  orderItems_on_order = (json['orderItems_on_order'] as List<dynamic>)
        .map((e) => GetOrderDetailsOrderOrderItemsOnOrder.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetOrderDetailsOrder otherTyped = other as GetOrderDetailsOrder;
    return id == otherTyped.id && 
    orderDate == otherTyped.orderDate && 
    status == otherTyped.status && 
    totalQty == otherTyped.totalQty && 
    orderItems_on_order == otherTyped.orderItems_on_order;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, orderDate.hashCode, status.hashCode, totalQty.hashCode, orderItems_on_order.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['orderDate'] = orderDate.toJson();
    json['status'] = nativeToJson<String>(status);
    json['totalQty'] = nativeToJson<int>(totalQty);
    json['orderItems_on_order'] = orderItems_on_order.map((e) => e.toJson()).toList();
    return json;
  }

  GetOrderDetailsOrder({
    required this.id,
    required this.orderDate,
    required this.status,
    required this.totalQty,
    required this.orderItems_on_order,
  });
}

@immutable
class GetOrderDetailsOrderOrderItemsOnOrder {
  final String id;
  final int qty;
  final GetOrderDetailsOrderOrderItemsOnOrderInstrument instrument;
  GetOrderDetailsOrderOrderItemsOnOrder.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  qty = nativeFromJson<int>(json['qty']),
  instrument = GetOrderDetailsOrderOrderItemsOnOrderInstrument.fromJson(json['instrument']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetOrderDetailsOrderOrderItemsOnOrder otherTyped = other as GetOrderDetailsOrderOrderItemsOnOrder;
    return id == otherTyped.id && 
    qty == otherTyped.qty && 
    instrument == otherTyped.instrument;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, qty.hashCode, instrument.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['qty'] = nativeToJson<int>(qty);
    json['instrument'] = instrument.toJson();
    return json;
  }

  GetOrderDetailsOrderOrderItemsOnOrder({
    required this.id,
    required this.qty,
    required this.instrument,
  });
}

@immutable
class GetOrderDetailsOrderOrderItemsOnOrderInstrument {
  final String name;
  final String imageUrl;
  final List<GetOrderDetailsOrderOrderItemsOnOrderInstrumentStocksOnInstrument> stocks_on_instrument;
  GetOrderDetailsOrderOrderItemsOnOrderInstrument.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']),
  imageUrl = nativeFromJson<String>(json['imageUrl']),
  stocks_on_instrument = (json['stocks_on_instrument'] as List<dynamic>)
        .map((e) => GetOrderDetailsOrderOrderItemsOnOrderInstrumentStocksOnInstrument.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetOrderDetailsOrderOrderItemsOnOrderInstrument otherTyped = other as GetOrderDetailsOrderOrderItemsOnOrderInstrument;
    return name == otherTyped.name && 
    imageUrl == otherTyped.imageUrl && 
    stocks_on_instrument == otherTyped.stocks_on_instrument;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, imageUrl.hashCode, stocks_on_instrument.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['imageUrl'] = nativeToJson<String>(imageUrl);
    json['stocks_on_instrument'] = stocks_on_instrument.map((e) => e.toJson()).toList();
    return json;
  }

  GetOrderDetailsOrderOrderItemsOnOrderInstrument({
    required this.name,
    required this.imageUrl,
    required this.stocks_on_instrument,
  });
}

@immutable
class GetOrderDetailsOrderOrderItemsOnOrderInstrumentStocksOnInstrument {
  final String id;
  final String shelf;
  final int inStockQty;
  final int inUseQty;
  GetOrderDetailsOrderOrderItemsOnOrderInstrumentStocksOnInstrument.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  shelf = nativeFromJson<String>(json['shelf']),
  inStockQty = nativeFromJson<int>(json['inStockQty']),
  inUseQty = nativeFromJson<int>(json['inUseQty']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetOrderDetailsOrderOrderItemsOnOrderInstrumentStocksOnInstrument otherTyped = other as GetOrderDetailsOrderOrderItemsOnOrderInstrumentStocksOnInstrument;
    return id == otherTyped.id && 
    shelf == otherTyped.shelf && 
    inStockQty == otherTyped.inStockQty && 
    inUseQty == otherTyped.inUseQty;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, shelf.hashCode, inStockQty.hashCode, inUseQty.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['shelf'] = nativeToJson<String>(shelf);
    json['inStockQty'] = nativeToJson<int>(inStockQty);
    json['inUseQty'] = nativeToJson<int>(inUseQty);
    return json;
  }

  GetOrderDetailsOrderOrderItemsOnOrderInstrumentStocksOnInstrument({
    required this.id,
    required this.shelf,
    required this.inStockQty,
    required this.inUseQty,
  });
}

@immutable
class GetOrderDetailsData {
  final GetOrderDetailsOrder? order;
  GetOrderDetailsData.fromJson(dynamic json):
  
  order = json['order'] == null ? null : GetOrderDetailsOrder.fromJson(json['order']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetOrderDetailsData otherTyped = other as GetOrderDetailsData;
    return order == otherTyped.order;
    
  }
  @override
  int get hashCode => order.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (order != null) {
      json['order'] = order!.toJson();
    }
    return json;
  }

  GetOrderDetailsData({
    this.order,
  });
}

@immutable
class GetOrderDetailsVariables {
  final String orderId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetOrderDetailsVariables.fromJson(Map<String, dynamic> json):
  
  orderId = nativeFromJson<String>(json['orderId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetOrderDetailsVariables otherTyped = other as GetOrderDetailsVariables;
    return orderId == otherTyped.orderId;
    
  }
  @override
  int get hashCode => orderId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['orderId'] = nativeToJson<String>(orderId);
    return json;
  }

  GetOrderDetailsVariables({
    required this.orderId,
  });
}

