import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  Account(this.uName, this.passwrodHash, this.email, this.role);
  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);

  final String? uName;
  final String? passwrodHash;
  final String? email;
  final String? role;
}
