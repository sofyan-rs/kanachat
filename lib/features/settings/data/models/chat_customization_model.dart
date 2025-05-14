import 'package:kanachat/features/settings/domain/entities/chat_customization_entity.dart';

class ChatCustomizationModel extends ChatCustomizationEntity {
  const ChatCustomizationModel({
    super.name,
    super.occupation,
    super.traits,
    super.additionalInfo,
  });

  factory ChatCustomizationModel.fromJson(Map<String, dynamic> json) {
    return ChatCustomizationModel(
      name: json['name'] as String?,
      occupation: json['occupation'] as String?,
      traits: json['traits'] as String?,
      additionalInfo: json['additional_info'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'occupation': occupation,
      'traits': traits,
      'additional_info': additionalInfo,
    };
  }

  factory ChatCustomizationModel.fromEntity(ChatCustomizationEntity entity) {
    return ChatCustomizationModel(
      name: entity.name,
      occupation: entity.occupation,
      traits: entity.traits,
      additionalInfo: entity.additionalInfo,
    );
  }
}
