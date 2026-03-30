library dataconnect_generated;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'get_cart_by_user_id.dart';

part 'create_cart.dart';

part 'add_item_to_cart.dart';

part 'update_cart_item.dart';

part 'get_category_carousel.dart';

part 'get_all_instruments_and_categories.dart';

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
  
  
  GetCategoryCarouselVariablesBuilder getCategoryCarousel () {
    return GetCategoryCarouselVariablesBuilder(dataConnect, );
  }
  
  
  GetAllInstrumentsAndCategoriesVariablesBuilder getAllInstrumentsAndCategories () {
    return GetAllInstrumentsAndCategoriesVariablesBuilder(dataConnect, );
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
