part of 'generated.dart';

class GetUserByEmailVariablesBuilder {
  String email;
  String password;

  final FirebaseDataConnect _dataConnect;
  GetUserByEmailVariablesBuilder(this._dataConnect, {required  this.email,required  this.password,});
  Deserializer<GetUserByEmailData> dataDeserializer = (dynamic json)  => GetUserByEmailData.fromJson(jsonDecode(json));
  Serializer<GetUserByEmailVariables> varsSerializer = (GetUserByEmailVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetUserByEmailData, GetUserByEmailVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetUserByEmailData, GetUserByEmailVariables> ref() {
    GetUserByEmailVariables vars= GetUserByEmailVariables(email: email,password: password,);
    return _dataConnect.query("GetUserByEmail", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetUserByEmailUsers {
  final String id;
  final String role;
  GetUserByEmailUsers.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  role = nativeFromJson<String>(json['role']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserByEmailUsers otherTyped = other as GetUserByEmailUsers;
    return id == otherTyped.id && 
    role == otherTyped.role;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, role.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['role'] = nativeToJson<String>(role);
    return json;
  }

  GetUserByEmailUsers({
    required this.id,
    required this.role,
  });
}

@immutable
class GetUserByEmailData {
  final List<GetUserByEmailUsers> users;
  GetUserByEmailData.fromJson(dynamic json):
  
  users = (json['users'] as List<dynamic>)
        .map((e) => GetUserByEmailUsers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserByEmailData otherTyped = other as GetUserByEmailData;
    return users == otherTyped.users;
    
  }
  @override
  int get hashCode => users.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['users'] = users.map((e) => e.toJson()).toList();
    return json;
  }

  GetUserByEmailData({
    required this.users,
  });
}

@immutable
class GetUserByEmailVariables {
  final String email;
  final String password;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetUserByEmailVariables.fromJson(Map<String, dynamic> json):
  
  email = nativeFromJson<String>(json['email']),
  password = nativeFromJson<String>(json['password']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserByEmailVariables otherTyped = other as GetUserByEmailVariables;
    return email == otherTyped.email && 
    password == otherTyped.password;
    
  }
  @override
  int get hashCode => Object.hashAll([email.hashCode, password.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['email'] = nativeToJson<String>(email);
    json['password'] = nativeToJson<String>(password);
    return json;
  }

  GetUserByEmailVariables({
    required this.email,
    required this.password,
  });
}

