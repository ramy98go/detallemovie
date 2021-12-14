class ProfileModel{

  int? id;
  String? nombre;
  String? apellidop;
  String? apellidom;
  String? telefono;
  String? email;
  String? photo;

/*NotasModel(int id, String titulo, String detalle){
  this.id = id;
  this.titulo = titulo;
  this.detalle = detalle;
}*/

  ProfileModel({this.id,this.nombre,this.apellidop,this.apellidom,this.telefono,this.email,this.photo});

//Map -> Object
  factory ProfileModel.fromMap(Map<String,dynamic> map){
    return ProfileModel(
        id            :  map['id'],
        nombre        :  map['nombre'],
        apellidop     :  map['apellidop'],
        apellidom     :  map['apellidom'],
        telefono      :  map['telefono'],
        email         :  map['email'],
        photo         :  map['photo']
    );
  }

//Object -> Map
  Map<String,dynamic> toMap(){
    return{
      'id'              : id,
      'nombre'          : nombre,
      'apellidop'       : apellidop,
      'apellidom'       : apellidom,
      'telefono'        : telefono,
      'email'           : email,
      'photo'           : photo
    };
  }



}