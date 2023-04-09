// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Adoption _$AdoptionFromJson(Map<String, dynamic> json) => Adoption(
      petId: json['petId'] as String,
      adoptedTime: DateTime.parse(json['adoptedTime'] as String),
    );

Map<String, dynamic> _$AdoptionToJson(Adoption instance) => <String, dynamic>{
      'petId': instance.petId,
      'adoptedTime': instance.adoptedTime.toIso8601String(),
    };
