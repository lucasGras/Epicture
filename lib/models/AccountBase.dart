import 'package:json_annotation/json_annotation.dart';

part 'AccountBase.g.dart';

@JsonSerializable()
class AccountBase {
    @JsonKey(name: 'url')
    String name;
    String bio;
    int reputation;

    AccountBase(this.name, this.bio, this.reputation);

    factory AccountBase.fromJson(Map<String, dynamic> json) => _$AccountBaseFromJson(json);

    Map<String, dynamic> toJson() => _$AccountBaseToJson(this);
}