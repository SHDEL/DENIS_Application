library dataconnect_generated;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'get_category_carousel.dart';

part 'get_all_instruments_and_categories.dart';

part 'get_user_by_id.dart';

part 'get_role_by_id.dart';

part 'create_user.dart';







class ExampleConnector {
  
  
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
