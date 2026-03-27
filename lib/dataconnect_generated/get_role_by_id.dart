part of 'generated.dart';

class GetRoleByIdVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetRoleByIdVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetRoleByIdData> dataDeserializer = (dynamic json)  => GetRoleByIdData.fromJson(jsonDecode(json));
  Serializer<GetRoleByIdVariables> varsSerializer = (GetRoleByIdVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetRoleByIdData, GetRoleByIdVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetRoleByIdData, GetRoleByIdVariables> ref() {
    GetRoleByIdVariables vars= GetRoleByIdVariables(id: id,);
    return _dataConnect.query("GetRoleById", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetRoleByIdUser {
  final String role;
  GetRoleByIdUser.fromJson(dynamic json):
  
  role = nativeFromJson<String>(json['role']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetRoleByIdUser otherTyped = other as GetRoleByIdUser;
    return role == otherTyped.role;
    
  }
  @override
  int get hashCode => role.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['role'] = nativeToJson<String>(role);
    return json;
  }

  GetRoleByIdUser({
    required this.role,
  });
}

@immutable
class GetRoleByIdData {
  final GetRoleByIdUser? user;
  GetRoleByIdData.fromJson(dynamic json):
  
  user = json['user'] == null ? null : GetRoleByIdUser.fromJson(json['user']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetRoleByIdData otherTyped = other as GetRoleByIdData;
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

  GetRoleByIdData({
    this.user,
  });
}

@immutable
class GetRoleByIdVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetRoleByIdVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetRoleByIdVariables otherTyped = other as GetRoleByIdVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetRoleByIdVariables({
    required this.id,
  });
}

