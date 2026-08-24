library dataconnect_generated;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'get_cart_by_user_id.dart';

part 'create_cart.dart';

part 'add_item_to_cart.dart';

part 'update_cart_item.dart';

part 'check_item_in_cart.dart';

part 'get_my_full_cart.dart';

part 'create_order.dart';

part 'create_order_item.dart';

part 'clear_cart_items.dart';

part 'delete_cart_item.dart';

part 'get_category_carousel.dart';

part 'get_all_instruments_and_categories.dart';

part 'get_instruments_by_category_id.dart';

part 'get_my_orders.dart';

part 'get_order_details.dart';

part 'get_all_orders.dart';

part 'update_order_status.dart';

part 'update_stock.dart';

part 'get_user_by_id.dart';

part 'get_role_by_id.dart';

part 'create_user.dart';







class ExampleConnector {
  
  
  GetCartByUserIdVariablesBuilder getCartByUserId ({required String userId, }) {
    return GetCartByUserIdVariablesBuilder(dataConnect, userId: userId,);
  }
  
  
  CreateCartVariablesBuilder createCart ({required String userId, required int quantity, }) {
    return CreateCartVariablesBuilder(dataConnect, userId: userId,quantity: quantity,);
  }
  
  
  AddItemToCartVariablesBuilder addItemToCart ({required String cartId, required String instrumentId, required int quantity, }) {
    return AddItemToCartVariablesBuilder(dataConnect, cartId: cartId,instrumentId: instrumentId,quantity: quantity,);
  }
  
  
  UpdateCartItemVariablesBuilder updateCartItem ({required String cartItemId, required int quantity, }) {
    return UpdateCartItemVariablesBuilder(dataConnect, cartItemId: cartItemId,quantity: quantity,);
  }
  
  
  CheckItemInCartVariablesBuilder checkItemInCart ({required String cartId, required String instrumentId, }) {
    return CheckItemInCartVariablesBuilder(dataConnect, cartId: cartId,instrumentId: instrumentId,);
  }
  
  
  GetMyFullCartVariablesBuilder getMyFullCart ({required String userId, }) {
    return GetMyFullCartVariablesBuilder(dataConnect, userId: userId,);
  }
  
  
  CreateOrderVariablesBuilder createOrder ({required String userId, required int totalQty, required String status, }) {
    return CreateOrderVariablesBuilder(dataConnect, userId: userId,totalQty: totalQty,status: status,);
  }
  
  
  CreateOrderItemVariablesBuilder createOrderItem ({required String orderId, required String instrumentId, required int qty, }) {
    return CreateOrderItemVariablesBuilder(dataConnect, orderId: orderId,instrumentId: instrumentId,qty: qty,);
  }
  
  
  ClearCartItemsVariablesBuilder clearCartItems ({required String cartId, }) {
    return ClearCartItemsVariablesBuilder(dataConnect, cartId: cartId,);
  }
  
  
  DeleteCartItemVariablesBuilder deleteCartItem ({required String cartItemId, }) {
    return DeleteCartItemVariablesBuilder(dataConnect, cartItemId: cartItemId,);
  }
  
  
  GetCategoryCarouselVariablesBuilder getCategoryCarousel () {
    return GetCategoryCarouselVariablesBuilder(dataConnect, );
  }
  
  
  GetAllInstrumentsAndCategoriesVariablesBuilder getAllInstrumentsAndCategories () {
    return GetAllInstrumentsAndCategoriesVariablesBuilder(dataConnect, );
  }
  
  
  GetInstrumentsByCategoryIdVariablesBuilder getInstrumentsByCategoryId ({required String categoryId, }) {
    return GetInstrumentsByCategoryIdVariablesBuilder(dataConnect, categoryId: categoryId,);
  }
  
  
  GetMyOrdersVariablesBuilder getMyOrders ({required String userId, }) {
    return GetMyOrdersVariablesBuilder(dataConnect, userId: userId,);
  }
  
  
  GetOrderDetailsVariablesBuilder getOrderDetails ({required String orderId, }) {
    return GetOrderDetailsVariablesBuilder(dataConnect, orderId: orderId,);
  }
  
  
  GetAllOrdersVariablesBuilder getAllOrders () {
    return GetAllOrdersVariablesBuilder(dataConnect, );
  }
  
  
  UpdateOrderStatusVariablesBuilder updateOrderStatus ({required String orderId, required String newStatus, }) {
    return UpdateOrderStatusVariablesBuilder(dataConnect, orderId: orderId,newStatus: newStatus,);
  }
  
  
  UpdateStockVariablesBuilder updateStock ({required String id, required int inStockQty, required int inUseQty, }) {
    return UpdateStockVariablesBuilder(dataConnect, id: id,inStockQty: inStockQty,inUseQty: inUseQty,);
  }
  
  
  GetUserByIdVariablesBuilder getUserById ({required String id, }) {
    return GetUserByIdVariablesBuilder(dataConnect, id: id,);
  }
  
  
  GetRoleByIdVariablesBuilder getRoleById ({required String id, }) {
    return GetRoleByIdVariablesBuilder(dataConnect, id: id,);
  }
  
  
  CreateUserVariablesBuilder createUser ({required String id, required String username, required String email, required String role, }) {
    return CreateUserVariablesBuilder(dataConnect, id: id,username: username,email: email,role: role,);
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'asia-southeast1',
    'example',
    'denis-2771b-service',
  );

  ExampleConnector({required this.dataConnect});
  static ExampleConnector get instance {
    
    return ExampleConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}
