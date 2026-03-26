part of 'generated.dart';

class GetUserByIdVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetUserByIdVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetUserByIdData> dataDeserializer = (dynamic json)  => GetUserByIdData.fromJson(jsonDecode(json));
  Serializer<GetUserByIdVariables> varsSerializer = (GetUserByIdVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetUserByIdData, GetUserByIdVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetUserByIdData, GetUserByIdVariables> ref() {
    GetUserByIdVariables vars= GetUserByIdVariables(id: id,);
    return _dataConnect.query("GetUserById", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetUserByIdUser {
  final String id;
  final String role;
  GetUserByIdUser.fromJson(dynamic json):
  
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

    final GetUserByIdUser otherTyped = other as GetUserByIdUser;
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

  GetUserByIdUser({
    required this.id,
    required this.role,
  });
}

@immutable
class GetUserByIdData {
  final GetUserByIdUser? user;
  GetUserByIdData.fromJson(dynamic json):
  
  user = json['user'] == null ? null : GetUserByIdUser.fromJson(json['user']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserByIdData otherTyped = other as GetUserByIdData;
    return user == otherTyped.user;
    
  }
  @override
  int get hashCode => user.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (user != null) {
      json['user'] = user!.toJson();
    }
    return json;
  }

  GetUserByIdData({
    this.user,
  });
}

@immutable
class GetUserByIdVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetUserByIdVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserByIdVariables otherTyped = other as GetUserByIdVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetUserByIdVariables({
    required this.id,
  });
}

