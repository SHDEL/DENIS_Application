# dataconnect_generated SDK

## Installation
```sh
flutter pub get firebase_data_connect
flutterfire configure
```
For more information, see [Flutter for Firebase installation documentation](https://firebase.google.com/docs/data-connect/flutter-sdk#use-core).

## Data Connect instance
Each connector creates a static class, with an instance of the `DataConnect` class that can be used to connect to your Data Connect backend and call operations.

### Connecting to the emulator

```dart
String host = 'localhost'; // or your host name
int port = 9399; // or your port number
ExampleConnector.instance.dataConnect.useDataConnectEmulator(host, port);
```

You can also call queries and mutations by using the connector class.
## Queries

### GetCartByUserId
#### Required Arguments
```dart
String userId = ...;
ExampleConnector.instance.getCartByUserId(
  userId: userId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetCartByUserIdData, GetCartByUserIdVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getCartByUserId(
  userId: userId,
);
GetCartByUserIdData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;

final ref = ExampleConnector.instance.getCartByUserId(
  userId: userId,
).ref();
ref.execute();

ref.subscribe(...);
```


### CheckItemInCart
#### Required Arguments
```dart
String cartId = ...;
String instrumentId = ...;
ExampleConnector.instance.checkItemInCart(
  cartId: cartId,
  instrumentId: instrumentId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<CheckItemInCartData, CheckItemInCartVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.checkItemInCart(
  cartId: cartId,
  instrumentId: instrumentId,
);
CheckItemInCartData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String cartId = ...;
String instrumentId = ...;

final ref = ExampleConnector.instance.checkItemInCart(
  cartId: cartId,
  instrumentId: instrumentId,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetMyFullCart
#### Required Arguments
```dart
String userId = ...;
ExampleConnector.instance.getMyFullCart(
  userId: userId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetMyFullCartData, GetMyFullCartVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getMyFullCart(
  userId: userId,
);
GetMyFullCartData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;

final ref = ExampleConnector.instance.getMyFullCart(
  userId: userId,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetCategoryCarousel
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.getCategoryCarousel().execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetCategoryCarouselData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getCategoryCarousel();
GetCategoryCarouselData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.getCategoryCarousel().ref();
ref.execute();

ref.subscribe(...);
```


### GetAllInstrumentsAndCategories
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.getAllInstrumentsAndCategories().execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetAllInstrumentsAndCategoriesData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getAllInstrumentsAndCategories();
GetAllInstrumentsAndCategoriesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.getAllInstrumentsAndCategories().ref();
ref.execute();

ref.subscribe(...);
```


### GetInstrumentsByCategoryId
#### Required Arguments
```dart
String categoryId = ...;
ExampleConnector.instance.getInstrumentsByCategoryId(
  categoryId: categoryId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetInstrumentsByCategoryIdData, GetInstrumentsByCategoryIdVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getInstrumentsByCategoryId(
  categoryId: categoryId,
);
GetInstrumentsByCategoryIdData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String categoryId = ...;

final ref = ExampleConnector.instance.getInstrumentsByCategoryId(
  categoryId: categoryId,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetMyOrders
#### Required Arguments
```dart
String userId = ...;
ExampleConnector.instance.getMyOrders(
  userId: userId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetMyOrdersData, GetMyOrdersVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getMyOrders(
  userId: userId,
);
GetMyOrdersData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;

final ref = ExampleConnector.instance.getMyOrders(
  userId: userId,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetOrderDetails
#### Required Arguments
```dart
String orderId = ...;
ExampleConnector.instance.getOrderDetails(
  orderId: orderId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetOrderDetailsData, GetOrderDetailsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getOrderDetails(
  orderId: orderId,
);
GetOrderDetailsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String orderId = ...;

final ref = ExampleConnector.instance.getOrderDetails(
  orderId: orderId,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetAllOrders
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.getAllOrders().execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetAllOrdersData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getAllOrders();
GetAllOrdersData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.getAllOrders().ref();
ref.execute();

ref.subscribe(...);
```


### GetUserById
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.getUserById(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetUserByIdData, GetUserByIdVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getUserById(
  id: id,
);
GetUserByIdData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.getUserById(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetRoleById
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.getRoleById(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetRoleByIdData, GetRoleByIdVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getRoleById(
  id: id,
);
GetRoleByIdData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.getRoleById(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```

## Mutations

### CreateCart
#### Required Arguments
```dart
String userId = ...;
int quantity = ...;
ExampleConnector.instance.createCart(
  userId: userId,
  quantity: quantity,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateCartData, CreateCartVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createCart(
  userId: userId,
  quantity: quantity,
);
CreateCartData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;
int quantity = ...;

final ref = ExampleConnector.instance.createCart(
  userId: userId,
  quantity: quantity,
).ref();
ref.execute();
```


### addItemToCart
#### Required Arguments
```dart
String cartId = ...;
String instrumentId = ...;
int quantity = ...;
ExampleConnector.instance.addItemToCart(
  cartId: cartId,
  instrumentId: instrumentId,
  quantity: quantity,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<addItemToCartData, addItemToCartVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.addItemToCart(
  cartId: cartId,
  instrumentId: instrumentId,
  quantity: quantity,
);
addItemToCartData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String cartId = ...;
String instrumentId = ...;
int quantity = ...;

final ref = ExampleConnector.instance.addItemToCart(
  cartId: cartId,
  instrumentId: instrumentId,
  quantity: quantity,
).ref();
ref.execute();
```


### updateCartItem
#### Required Arguments
```dart
String cartItemId = ...;
int quantity = ...;
ExampleConnector.instance.updateCartItem(
  cartItemId: cartItemId,
  quantity: quantity,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<updateCartItemData, updateCartItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.updateCartItem(
  cartItemId: cartItemId,
  quantity: quantity,
);
updateCartItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String cartItemId = ...;
int quantity = ...;

final ref = ExampleConnector.instance.updateCartItem(
  cartItemId: cartItemId,
  quantity: quantity,
).ref();
ref.execute();
```


### CreateOrder
#### Required Arguments
```dart
String userId = ...;
int totalQty = ...;
String status = ...;
ExampleConnector.instance.createOrder(
  userId: userId,
  totalQty: totalQty,
  status: status,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateOrderData, CreateOrderVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createOrder(
  userId: userId,
  totalQty: totalQty,
  status: status,
);
CreateOrderData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;
int totalQty = ...;
String status = ...;

final ref = ExampleConnector.instance.createOrder(
  userId: userId,
  totalQty: totalQty,
  status: status,
).ref();
ref.execute();
```


### CreateOrderItem
#### Required Arguments
```dart
String orderId = ...;
String instrumentId = ...;
int qty = ...;
ExampleConnector.instance.createOrderItem(
  orderId: orderId,
  instrumentId: instrumentId,
  qty: qty,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateOrderItemData, CreateOrderItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createOrderItem(
  orderId: orderId,
  instrumentId: instrumentId,
  qty: qty,
);
CreateOrderItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String orderId = ...;
String instrumentId = ...;
int qty = ...;

final ref = ExampleConnector.instance.createOrderItem(
  orderId: orderId,
  instrumentId: instrumentId,
  qty: qty,
).ref();
ref.execute();
```


### ClearCartItems
#### Required Arguments
```dart
String cartId = ...;
ExampleConnector.instance.clearCartItems(
  cartId: cartId,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<ClearCartItemsData, ClearCartItemsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.clearCartItems(
  cartId: cartId,
);
ClearCartItemsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String cartId = ...;

final ref = ExampleConnector.instance.clearCartItems(
  cartId: cartId,
).ref();
ref.execute();
```


### DeleteCartItem
#### Required Arguments
```dart
String cartItemId = ...;
ExampleConnector.instance.deleteCartItem(
  cartItemId: cartItemId,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteCartItemData, DeleteCartItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.deleteCartItem(
  cartItemId: cartItemId,
);
DeleteCartItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String cartItemId = ...;

final ref = ExampleConnector.instance.deleteCartItem(
  cartItemId: cartItemId,
).ref();
ref.execute();
```


### UpdateOrderStatus
#### Required Arguments
```dart
String orderId = ...;
String newStatus = ...;
ExampleConnector.instance.updateOrderStatus(
  orderId: orderId,
  newStatus: newStatus,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateOrderStatusData, UpdateOrderStatusVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.updateOrderStatus(
  orderId: orderId,
  newStatus: newStatus,
);
UpdateOrderStatusData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String orderId = ...;
String newStatus = ...;

final ref = ExampleConnector.instance.updateOrderStatus(
  orderId: orderId,
  newStatus: newStatus,
).ref();
ref.execute();
```


### updateStock
#### Required Arguments
```dart
String id = ...;
int inStockQty = ...;
int inUseQty = ...;
ExampleConnector.instance.updateStock(
  id: id,
  inStockQty: inStockQty,
  inUseQty: inUseQty,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<updateStockData, updateStockVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.updateStock(
  id: id,
  inStockQty: inStockQty,
  inUseQty: inUseQty,
);
updateStockData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
int inStockQty = ...;
int inUseQty = ...;

final ref = ExampleConnector.instance.updateStock(
  id: id,
  inStockQty: inStockQty,
  inUseQty: inUseQty,
).ref();
ref.execute();
```


### CreateUser
#### Required Arguments
```dart
String id = ...;
String username = ...;
String email = ...;
String role = ...;
ExampleConnector.instance.createUser(
  id: id,
  username: username,
  email: email,
  role: role,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateUserData, CreateUserVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createUser(
  id: id,
  username: username,
  email: email,
  role: role,
);
CreateUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
String username = ...;
String email = ...;
String role = ...;

final ref = ExampleConnector.instance.createUser(
  id: id,
  username: username,
  email: email,
  role: role,
).ref();
ref.execute();
```

