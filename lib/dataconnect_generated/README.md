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

