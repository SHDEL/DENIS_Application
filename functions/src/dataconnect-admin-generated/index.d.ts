import { ConnectorConfig, DataConnect, OperationOptions, ExecuteOperationResponse } from 'firebase-admin/data-connect';

export const connectorConfig: ConnectorConfig;

export type TimestampString = string;
export type UUIDString = string;
export type Int64String = string;
export type DateString = string;


export interface AddItemToCartData {
  cartItem_insert: {
    id: UUIDString;
  };
}

export interface AddItemToCartVariables {
  cartId: UUIDString;
  instrumentId: UUIDString;
  quantity: number;
}

export interface CartItem_Key {
  id: UUIDString;
  __typename?: 'CartItem_Key';
}

export interface Cart_Key {
  id: UUIDString;
  __typename?: 'Cart_Key';
}

export interface CheckItemInCartData {
  cartItems: ({
    id: UUIDString;
    qty: number;
  } & CartItem_Key)[];
}

export interface CheckItemInCartVariables {
  cartId: UUIDString;
  instrumentId: UUIDString;
}

export interface ClearCartItemsData {
  cartItem_deleteMany: number;
}

export interface ClearCartItemsVariables {
  cartId: UUIDString;
}

export interface CreateCartData {
  cart_insert: {
    id: UUIDString;
  };
}

export interface CreateCartVariables {
  userId: string;
  quantity: number;
}

export interface CreateOrderData {
  order_insert: {
    id: UUIDString;
  };
}

export interface CreateOrderItemData {
  orderItem_insert: {
    id: UUIDString;
  };
}

export interface CreateOrderItemVariables {
  orderId: UUIDString;
  instrumentId: UUIDString;
  qty: number;
}

export interface CreateOrderVariables {
  userId: string;
  totalQty: number;
  status: string;
}

export interface CreateUserData {
  user_insert: {
    id: string;
  };
}

export interface CreateUserVariables {
  id: string;
  username: string;
  email: string;
  role: string;
}

export interface DeleteCartItemData {
  cartItem_delete?: {
    id: UUIDString;
  };
}

export interface DeleteCartItemVariables {
  cartItemId: UUIDString;
}

export interface GetAllInstrumentsAndCategoriesData {
  instrumentCategories: ({
    id: UUIDString;
    name: string;
  } & InstrumentCategory_Key)[];
    instruments: ({
      id: UUIDString;
      name: string;
      imageUrl: string;
      category: {
        id: UUIDString;
        name: string;
      } & InstrumentCategory_Key;
        description: string;
        stocks_on_instrument: ({
          id: UUIDString;
          inStockQty: number;
          inUseQty: number;
          shelf: string;
        } & Stock_Key)[];
    } & Instrument_Key)[];
}

export interface GetAllOrdersData {
  orders: ({
    id: UUIDString;
    orderDate: TimestampString;
    totalQty: number;
    status: string;
    user: {
      username: string;
      email: string;
    };
  } & Order_Key)[];
}

export interface GetCartByUserIdData {
  carts: ({
    id: UUIDString;
    userId: string;
    totalQty: number;
  } & Cart_Key)[];
}

export interface GetCartByUserIdVariables {
  userId: string;
}

export interface GetCategoryCarouselData {
  instrumentCategories: ({
    id: UUIDString;
    name: string;
    instruments_on_category: ({
      imageUrl: string;
    })[];
  } & InstrumentCategory_Key)[];
}

export interface GetInstrumentsByCategoryIdData {
  instruments: ({
    id: UUIDString;
    name: string;
    description: string;
    imageUrl: string;
    category: {
      name: string;
    };
      stocks_on_instrument: ({
        id: UUIDString;
        inStockQty: number;
        inUseQty: number;
        shelf: string;
      } & Stock_Key)[];
  } & Instrument_Key)[];
}

export interface GetInstrumentsByCategoryIdVariables {
  categoryId: UUIDString;
}

export interface GetMyFullCartData {
  carts: ({
    id: UUIDString;
    cartItems_on_cart: ({
      id: UUIDString;
      qty: number;
      instrument: {
        id: UUIDString;
        name: string;
        imageUrl: string;
        stocks_on_instrument: ({
          id: UUIDString;
          shelf: string;
          inStockQty: number;
          inUseQty: number;
        } & Stock_Key)[];
      } & Instrument_Key;
    } & CartItem_Key)[];
  } & Cart_Key)[];
}

export interface GetMyFullCartVariables {
  userId: string;
}

export interface GetMyOrdersData {
  orders: ({
    id: UUIDString;
    orderDate: TimestampString;
    totalQty: number;
    status: string;
  } & Order_Key)[];
}

export interface GetMyOrdersVariables {
  userId: string;
}

export interface GetOrderDetailsData {
  order?: {
    id: UUIDString;
    orderDate: TimestampString;
    status: string;
    totalQty: number;
    orderItems_on_order: ({
      id: UUIDString;
      qty: number;
      instrument: {
        name: string;
        imageUrl: string;
        stocks_on_instrument: ({
          id: UUIDString;
          shelf: string;
          inStockQty: number;
          inUseQty: number;
        } & Stock_Key)[];
      };
    } & OrderItem_Key)[];
  } & Order_Key;
}

export interface GetOrderDetailsVariables {
  orderId: UUIDString;
}

export interface GetRoleByIdData {
  user?: {
    role: string;
  };
}

export interface GetRoleByIdVariables {
  id: string;
}

export interface GetUserByIdData {
  user?: {
    id: string;
    role: string;
  } & User_Key;
}

export interface GetUserByIdVariables {
  id: string;
}

export interface InstrumentCategory_Key {
  id: UUIDString;
  __typename?: 'InstrumentCategory_Key';
}

export interface Instrument_Key {
  id: UUIDString;
  __typename?: 'Instrument_Key';
}

export interface OrderItem_Key {
  id: UUIDString;
  __typename?: 'OrderItem_Key';
}

export interface Order_Key {
  id: UUIDString;
  __typename?: 'Order_Key';
}

export interface Stock_Key {
  id: UUIDString;
  __typename?: 'Stock_Key';
}

export interface UpdateCartItemData {
  cartItem_update?: {
    id: UUIDString;
  };
}

export interface UpdateCartItemVariables {
  cartItemId: UUIDString;
  quantity: number;
}

export interface UpdateOrderStatusData {
  order_update?: {
    id: UUIDString;
  };
}

export interface UpdateOrderStatusVariables {
  orderId: UUIDString;
  newStatus: string;
}

export interface UpdateStockData {
  stock_update?: {
    id: UUIDString;
  };
}

export interface UpdateStockVariables {
  id: UUIDString;
  inStockQty: number;
  inUseQty: number;
}

export interface User_Key {
  id: string;
  __typename?: 'User_Key';
}

/** Generated Node Admin SDK operation action function for the 'GetCategoryCarousel' Query. Allow users to execute without passing in DataConnect. */
export function getCategoryCarousel(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<GetCategoryCarouselData>>;
/** Generated Node Admin SDK operation action function for the 'GetCategoryCarousel' Query. Allow users to pass in custom DataConnect instances. */
export function getCategoryCarousel(options?: OperationOptions): Promise<ExecuteOperationResponse<GetCategoryCarouselData>>;

/** Generated Node Admin SDK operation action function for the 'GetAllInstrumentsAndCategories' Query. Allow users to execute without passing in DataConnect. */
export function getAllInstrumentsAndCategories(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<GetAllInstrumentsAndCategoriesData>>;
/** Generated Node Admin SDK operation action function for the 'GetAllInstrumentsAndCategories' Query. Allow users to pass in custom DataConnect instances. */
export function getAllInstrumentsAndCategories(options?: OperationOptions): Promise<ExecuteOperationResponse<GetAllInstrumentsAndCategoriesData>>;

/** Generated Node Admin SDK operation action function for the 'GetInstrumentsByCategoryId' Query. Allow users to execute without passing in DataConnect. */
export function getInstrumentsByCategoryId(dc: DataConnect, vars: GetInstrumentsByCategoryIdVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetInstrumentsByCategoryIdData>>;
/** Generated Node Admin SDK operation action function for the 'GetInstrumentsByCategoryId' Query. Allow users to pass in custom DataConnect instances. */
export function getInstrumentsByCategoryId(vars: GetInstrumentsByCategoryIdVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetInstrumentsByCategoryIdData>>;

/** Generated Node Admin SDK operation action function for the 'GetMyOrders' Query. Allow users to execute without passing in DataConnect. */
export function getMyOrders(dc: DataConnect, vars: GetMyOrdersVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetMyOrdersData>>;
/** Generated Node Admin SDK operation action function for the 'GetMyOrders' Query. Allow users to pass in custom DataConnect instances. */
export function getMyOrders(vars: GetMyOrdersVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetMyOrdersData>>;

/** Generated Node Admin SDK operation action function for the 'GetOrderDetails' Query. Allow users to execute without passing in DataConnect. */
export function getOrderDetails(dc: DataConnect, vars: GetOrderDetailsVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetOrderDetailsData>>;
/** Generated Node Admin SDK operation action function for the 'GetOrderDetails' Query. Allow users to pass in custom DataConnect instances. */
export function getOrderDetails(vars: GetOrderDetailsVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetOrderDetailsData>>;

/** Generated Node Admin SDK operation action function for the 'GetAllOrders' Query. Allow users to execute without passing in DataConnect. */
export function getAllOrders(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<GetAllOrdersData>>;
/** Generated Node Admin SDK operation action function for the 'GetAllOrders' Query. Allow users to pass in custom DataConnect instances. */
export function getAllOrders(options?: OperationOptions): Promise<ExecuteOperationResponse<GetAllOrdersData>>;

/** Generated Node Admin SDK operation action function for the 'UpdateOrderStatus' Mutation. Allow users to execute without passing in DataConnect. */
export function updateOrderStatus(dc: DataConnect, vars: UpdateOrderStatusVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateOrderStatusData>>;
/** Generated Node Admin SDK operation action function for the 'UpdateOrderStatus' Mutation. Allow users to pass in custom DataConnect instances. */
export function updateOrderStatus(vars: UpdateOrderStatusVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateOrderStatusData>>;

/** Generated Node Admin SDK operation action function for the 'UpdateStock' Mutation. Allow users to execute without passing in DataConnect. */
export function updateStock(dc: DataConnect, vars: UpdateStockVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateStockData>>;
/** Generated Node Admin SDK operation action function for the 'UpdateStock' Mutation. Allow users to pass in custom DataConnect instances. */
export function updateStock(vars: UpdateStockVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateStockData>>;

/** Generated Node Admin SDK operation action function for the 'GetUserById' Query. Allow users to execute without passing in DataConnect. */
export function getUserById(dc: DataConnect, vars: GetUserByIdVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetUserByIdData>>;
/** Generated Node Admin SDK operation action function for the 'GetUserById' Query. Allow users to pass in custom DataConnect instances. */
export function getUserById(vars: GetUserByIdVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetUserByIdData>>;

/** Generated Node Admin SDK operation action function for the 'GetRoleById' Query. Allow users to execute without passing in DataConnect. */
export function getRoleById(dc: DataConnect, vars: GetRoleByIdVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetRoleByIdData>>;
/** Generated Node Admin SDK operation action function for the 'GetRoleById' Query. Allow users to pass in custom DataConnect instances. */
export function getRoleById(vars: GetRoleByIdVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetRoleByIdData>>;

/** Generated Node Admin SDK operation action function for the 'CreateUser' Mutation. Allow users to execute without passing in DataConnect. */
export function createUser(dc: DataConnect, vars: CreateUserVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateUserData>>;
/** Generated Node Admin SDK operation action function for the 'CreateUser' Mutation. Allow users to pass in custom DataConnect instances. */
export function createUser(vars: CreateUserVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateUserData>>;

/** Generated Node Admin SDK operation action function for the 'GetCartByUserId' Query. Allow users to execute without passing in DataConnect. */
export function getCartByUserId(dc: DataConnect, vars: GetCartByUserIdVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetCartByUserIdData>>;
/** Generated Node Admin SDK operation action function for the 'GetCartByUserId' Query. Allow users to pass in custom DataConnect instances. */
export function getCartByUserId(vars: GetCartByUserIdVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetCartByUserIdData>>;

/** Generated Node Admin SDK operation action function for the 'CreateCart' Mutation. Allow users to execute without passing in DataConnect. */
export function createCart(dc: DataConnect, vars: CreateCartVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateCartData>>;
/** Generated Node Admin SDK operation action function for the 'CreateCart' Mutation. Allow users to pass in custom DataConnect instances. */
export function createCart(vars: CreateCartVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateCartData>>;

/** Generated Node Admin SDK operation action function for the 'AddItemToCart' Mutation. Allow users to execute without passing in DataConnect. */
export function addItemToCart(dc: DataConnect, vars: AddItemToCartVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<AddItemToCartData>>;
/** Generated Node Admin SDK operation action function for the 'AddItemToCart' Mutation. Allow users to pass in custom DataConnect instances. */
export function addItemToCart(vars: AddItemToCartVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<AddItemToCartData>>;

/** Generated Node Admin SDK operation action function for the 'UpdateCartItem' Mutation. Allow users to execute without passing in DataConnect. */
export function updateCartItem(dc: DataConnect, vars: UpdateCartItemVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateCartItemData>>;
/** Generated Node Admin SDK operation action function for the 'UpdateCartItem' Mutation. Allow users to pass in custom DataConnect instances. */
export function updateCartItem(vars: UpdateCartItemVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateCartItemData>>;

/** Generated Node Admin SDK operation action function for the 'CheckItemInCart' Query. Allow users to execute without passing in DataConnect. */
export function checkItemInCart(dc: DataConnect, vars: CheckItemInCartVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CheckItemInCartData>>;
/** Generated Node Admin SDK operation action function for the 'CheckItemInCart' Query. Allow users to pass in custom DataConnect instances. */
export function checkItemInCart(vars: CheckItemInCartVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CheckItemInCartData>>;

/** Generated Node Admin SDK operation action function for the 'GetMyFullCart' Query. Allow users to execute without passing in DataConnect. */
export function getMyFullCart(dc: DataConnect, vars: GetMyFullCartVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetMyFullCartData>>;
/** Generated Node Admin SDK operation action function for the 'GetMyFullCart' Query. Allow users to pass in custom DataConnect instances. */
export function getMyFullCart(vars: GetMyFullCartVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetMyFullCartData>>;

/** Generated Node Admin SDK operation action function for the 'CreateOrder' Mutation. Allow users to execute without passing in DataConnect. */
export function createOrder(dc: DataConnect, vars: CreateOrderVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateOrderData>>;
/** Generated Node Admin SDK operation action function for the 'CreateOrder' Mutation. Allow users to pass in custom DataConnect instances. */
export function createOrder(vars: CreateOrderVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateOrderData>>;

/** Generated Node Admin SDK operation action function for the 'CreateOrderItem' Mutation. Allow users to execute without passing in DataConnect. */
export function createOrderItem(dc: DataConnect, vars: CreateOrderItemVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateOrderItemData>>;
/** Generated Node Admin SDK operation action function for the 'CreateOrderItem' Mutation. Allow users to pass in custom DataConnect instances. */
export function createOrderItem(vars: CreateOrderItemVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateOrderItemData>>;

/** Generated Node Admin SDK operation action function for the 'ClearCartItems' Mutation. Allow users to execute without passing in DataConnect. */
export function clearCartItems(dc: DataConnect, vars: ClearCartItemsVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<ClearCartItemsData>>;
/** Generated Node Admin SDK operation action function for the 'ClearCartItems' Mutation. Allow users to pass in custom DataConnect instances. */
export function clearCartItems(vars: ClearCartItemsVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<ClearCartItemsData>>;

/** Generated Node Admin SDK operation action function for the 'DeleteCartItem' Mutation. Allow users to execute without passing in DataConnect. */
export function deleteCartItem(dc: DataConnect, vars: DeleteCartItemVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeleteCartItemData>>;
/** Generated Node Admin SDK operation action function for the 'DeleteCartItem' Mutation. Allow users to pass in custom DataConnect instances. */
export function deleteCartItem(vars: DeleteCartItemVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeleteCartItemData>>;

