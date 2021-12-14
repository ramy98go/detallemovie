
class ActorsModel{

  String? name;
  int? id;
  String? profilepath;
  String? character;

  ActorsModel({
    this.name,
    this.id,
    this.character,
    this.profilepath
  });

  factory ActorsModel.fromMap(Map<String, dynamic> map){
    return ActorsModel(
        name                : map['name'] ?? "",
        id                  : map['id'],
        character           : map['character'],
        profilepath        : map['profile_path'] ?? "",
    );
  }

}