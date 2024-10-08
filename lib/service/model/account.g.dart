// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      json['uName'] as String?,
      json['passwrodHash'] as String?,
      json['email'] as String?,
      json['role'] as String?,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'uName': instance.uName,
      'passwrodHash': instance.passwrodHash,
      'email': instance.email,
      'role': instance.role,
    };
