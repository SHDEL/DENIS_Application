part of 'generated.dart';

class GetMyFullCartVariablesBuilder {
  String userId;

  final FirebaseDataConnect _dataConnect;
  GetMyFullCartVariablesBuilder(this._dataConnect, {required  this.userId,});
  Deserializer<GetMyFullCartData> dataDeserializer = (dynamic json)  => GetMyFullCartData.fromJson(jsonDecode(json));
  Serializer<GetMyFullCartVariables> varsSerializer = (GetMyFullCartVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetMyFullCartData, GetMyFullCartVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetMyFullCartData, GetMyFullCartVariables> ref() {
    GetMyFullCartVariables vars= GetMyFullCartVariables(userId: userId,);
    return _dataConnect.query("GetMyFullCart", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetMyFullCartCarts {
  final String id;
  final List<GetMyFullCartCartsCartItemsOnCart> cartItems_on_cart;
  GetMyFullCartCarts.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  cartItems_on_cart = (json['cartItems_on_cart'] as List<dynamic>)
        .map((e) => GetMyFullCartCartsCartItemsOnCart.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyFullCartCarts otherTyped = other as GetMyFullCartCarts;
    return id == otherTyped.id && 
    cartItems_on_cart == otherTyped.cartItems_on_cart;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, cartItems_on_cart.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['cartItems_on_cart'] = cartItems_on_cart.map((e) => e.toJson()).toList();
    return json;
  }

  GetMyFullCartCarts({
    required this.id,
    required this.cartItems_on_cart,
  });
}

@immutable
class GetMyFullCartCartsCartItemsOnCart {
  final String id;
  final int qty;
  final GetMyFullCartCartsCartItemsOnCartInstrument instrument;
  GetMyFullCartCartsCartItemsOnCart.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  qty = nativeFromJson<int>(json['qty']),
  instrument = GetMyFullCartCartsCartItemsOnCartInstrument.fromJson(json['instrument']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyFullCartCartsCartItemsOnCart otherTyped = other as GetMyFullCartCartsCartItemsOnCart;
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

  GetMyFullCartCartsCartItemsOnCart({
    required this.id,
    required this.qty,
    required this.instrument,
  });
}

@immutable
class GetMyFullCartCartsCartItemsOnCartInstrument {
  final String id;
  final String name;
  final String imageUrl;
  final List<GetMyFullCartCartsCartItemsOnCartInstrumentStocksOnInstrument> stocks_on_instrument;
  GetMyFullCartCartsCartItemsOnCartInstrument.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  imageUrl = nativeFromJson<String>(json['imageUrl']),
  stocks_on_instrument = (json['stocks_on_instrument'] as List<dynamic>)
        .map((e) => GetMyFullCartCartsCartItemsOnCartInstrumentStocksOnInstrument.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyFullCartCartsCartItemsOnCartInstrument otherTyped = other as GetMyFullCartCartsCartItemsOnCartInstrument;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    imageUrl == otherTyped.imageUrl && 
    stocks_on_instrument == otherTyped.stocks_on_instrument;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, imageUrl.hashCode, stocks_on_instrument.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['imageUrl'] = nativeToJson<String>(imageUrl);
    json['stocks_on_instrument'] = stocks_on_instrument.map((e) => e.toJson()).toList();
    return json;
  }

  GetMyFullCartCartsCartItemsOnCartInstrument({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.stocks_on_instrument,
  });
}

@immutable
class GetMyFullCartCartsCartItemsOnCartInstrumentStocksOnInstrument {
  final String id;
  final String shelf;
  final int inStockQty;
  final int inUseQty;
  GetMyFullCartCartsCartItemsOnCartInstrumentStocksOnInstrument.fromJson(dynamic json):
  
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

    final GetMyFullCartCartsCartItemsOnCartInstrumentStocksOnInstrument otherTyped = other as GetMyFullCartCartsCartItemsOnCartInstrumentStocksOnInstrument;
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

  GetMyFullCartCartsCartItemsOnCartInstrumentStocksOnInstrument({
    required this.id,
    required this.shelf,
    required this.inStockQty,
    required this.inUseQty,
  });
}

@immutable
class GetMyFullCartData {
  final List<GetMyFullCartCarts> carts;
  GetMyFullCartData.fromJson(dynamic json):
  
  carts = (json['carts'] as List<dynamic>)
        .map((e) => GetMyFullCartCarts.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyFullCartData otherTyped = other as GetMyFullCartData;
    return carts == otherTyped.carts;
    
  }
  @override
  int get hashCode => carts.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['carts'] = carts.map((e) => e.toJson()).toList();
    return json;
  }

  GetMyFullCartData({
    required this.carts,
  });
}

@immutable
class GetMyFullCartVariables {
  final String userId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetMyFullCartVariables.fromJson(Map<String, dynamic> json):
  
  userId = nativeFromJson<String>(json['userId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyFullCartVariables otherTyped = other as GetMyFullCartVariables;
    return userId == otherTyped.userId;
    
  }
  @override
  int get hashCode => userId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  GetMyFullCartVariables({
    required this.userId,
  });
}

