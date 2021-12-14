import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica1/src/database/database_helperf.dart';
import 'package:practica1/src/models/profile_model.dart';

class FileScreen extends StatefulWidget {
  const FileScreen({Key? key}) : super(key: key);

  @override
  _FileScreenState createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {

  late DatabaseHelper3 _databaseHelper;

  TextEditingController _controllerNom = TextEditingController();
  TextEditingController _controllerAp = TextEditingController();
  TextEditingController _controllerAm = TextEditingController();
  TextEditingController _controllerTel = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();

  ImagePicker image = ImagePicker();
  File? file;
  String url="";

  getImage() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });
  }

  getImagen() async {
    var img = await image.pickImage(source: ImageSource.camera);
    setState(() {
      file = File(img!.path);
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _databaseHelper = DatabaseHelper3();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _databaseHelper.getUser(),
        builder: (_, AsyncSnapshot<ProfileModel?> snapshot)
        {
          final perfil = snapshot.hasData ? snapshot.data : null;
          _controllerNom.text = (perfil == null ? '' : perfil.nombre)!;
          _controllerAp.text = (perfil == null ? '' : perfil.apellidop)!;
          _controllerAm.text = (perfil == null ? '' : perfil.apellidom)!;
          _controllerTel.text = (perfil == null ? '' : perfil.telefono)!;
          _controllerEmail.text = (perfil == null ? '' : perfil.email)!;

          return Scaffold(
            appBar: AppBar(
              title: Text("MIS DATOS"),
            ),
            body: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      imageProfile(),
                      SizedBox(height: 20,),
                      _TextFieldNom(),
                      SizedBox(height: 20,),
                      _TextFieldAp(),
                      SizedBox(height: 20,),
                      _TextFieldAm(),
                      SizedBox(height: 20,),
                      _TextFieldTel(),
                      SizedBox(height: 20,),
                      _TextFieldEmail(),
                      SizedBox(height: 20,),
                      SizedBox(
                          width: 225,
                          height: 50,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            color: Colors.lightBlue,
                            child: Text('ACTUALIZAR PERFIL'),
                            onPressed: (){
                              if (_formKey.currentState!.validate()){
                                ProfileModel profile = ProfileModel(
                                  nombre: _controllerNom.text,
                                  apellidop: _controllerAp.text,
                                  apellidom: _controllerAm.text,
                                  telefono: _controllerTel.text,
                                  email: _controllerEmail.text
                                );
                                _databaseHelper.perfilUser(profile.toMap()).then((value)
                                {
                                  if(value > 0){
                                    var nav = Navigator.of(context);
                                    nav.pop();
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('La solicitud no se completo'))
                                    );
                                  }
                                });
                              }
                            },
                          )
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  Widget imageProfile(){
   return FutureBuilder(
        future: _databaseHelper.getUser(),
        builder: (_, AsyncSnapshot<ProfileModel?> snapshot)
        {
          final perfil = snapshot.hasData ? snapshot.data : null;
          return Center(
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 60.0,
                  backgroundImage: file == null ?
                  AssetImage("assets/logoitc.png"):
                  FileImage(File(perfil!.photo!)) as ImageProvider,
                  child: InkWell(
                    onTap: (){
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet()),
                      );
                    },
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.blueAccent,
                      size: 25.0,
                    ),
                  ),
                )
              ],
            ),
          );
       }
    );
    
  }

  Widget bottomSheet(){
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            Text("Elige una foto de perfil", style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton.icon(
                    icon: Icon(Icons.camera_alt),
                  onPressed: (){
                      getImagen();
                  },
                  label: Text("Camara"),
                ),
                FlatButton.icon(
                  icon: Icon(Icons.image),
                  onPressed: (){
                    getImage();
                  },
                  label: Text("Gallery"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _TextFieldNom(){
    return TextFormField(
      controller: _controllerNom,
      validator: (val) => val!.isEmpty ?  "Campo Obligatorio" : null,
      autofocus: true,
      autocorrect: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nombre Usuario",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  Widget _TextFieldAp(){
    return TextFormField(
      controller: _controllerAp,
      validator: (val) => val!.isEmpty ?  "Campo Obligatorio" : null,
      autofocus: true,
      autocorrect: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Apellido Paterno",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  Widget _TextFieldAm(){
    return TextFormField(
      controller: _controllerAm,
      validator: (val) => val!.isEmpty ?  "Campo Obligatorio" : null,
      autofocus: true,
      autocorrect: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Apellido Materno",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  Widget _TextFieldTel(){
    return TextFormField(
      controller: _controllerTel,
      validator: (val) => val!.isEmpty ?  "Campo Obligatorio" : null,
      autofocus: true,
      autocorrect: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Telefono",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  Widget _TextFieldEmail(){
    return TextFormField(
      controller: _controllerEmail,
      validator: (val) => val!.isEmpty ?  "Campo Obligatorio" : null,
      autofocus: true,
      autocorrect: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }


}

