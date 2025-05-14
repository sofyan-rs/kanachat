const _unset = Object();

class ChatCustomizationEntity {
  final String? name;
  final String? occupation;
  final String? traits;
  final String? additionalInfo;

  const ChatCustomizationEntity({
    this.name,
    this.occupation,
    this.traits,
    this.additionalInfo,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'occupation': occupation,
      'traits': traits,
      'additionalInfo': additionalInfo,
    };
  }

  ChatCustomizationEntity copyWith({
    Object? name = _unset,
    Object? occupation = _unset,
    Object? traits = _unset,
    Object? additionalInfo = _unset,
  }) {
    return ChatCustomizationEntity(
      name: name == _unset ? this.name : name as String?,
      occupation:
          occupation == _unset ? this.occupation : occupation as String?,
      traits: traits == _unset ? this.traits : traits as String?,
      additionalInfo:
          additionalInfo == _unset
              ? this.additionalInfo
              : additionalInfo as String?,
    );
  }
}
