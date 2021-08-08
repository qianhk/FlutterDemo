// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_dart_syntax.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    json['street'] as String?,
    json['city'] as String?,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'street': instance.street,
      'city': instance.city,
    };

User2 _$User2FromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id']);
  return User2(
    json['id'] as int?,
    json['name'] as String?,
    json['email'] as String?,
    json['isAdult'] as bool? ?? true,
    json['date_millis'] as int?,
    json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$User2ToJson(User2 instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'isAdult': instance.isAdult,
      'date_millis': instance.registrationDateMillis,
      'address': instance.address?.toJson(),
    };
