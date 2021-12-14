import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practica1/src/utils/color_settings.dart';

class Opcion1Screen extends StatelessWidget {
  const Opcion1Screen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    TextEditingController txtPropina = TextEditingController();
    int propina = 10;

    TextFormField txtPropinas = TextFormField(
      controller: txtPropina,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: 'Introduce la cantidad a pagar',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)
      ),
    );

    ElevatedButton btnCalcular = ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: ColorSettings.colorButton
        ),
        onPressed: (){
          double valint = double.parse(txtPropina.text);
          double totalp = (valint*propina)/100;
          double total = totalp + valint;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: Text('Tu total a pagar es: '),
              content: Text(
                  'Conceptos: ' + '\n\n' +
                   'Total de la cuenta: ' + valint.toString() + '\n\n' +
                   'Porcentaje de propina: ' + propina.toString() +'%\n\n' +
                    'TOTAL: ' + total.toString(),
              ),

              actions: <Widget> [
                FlatButton(
                    child: Text('PAGAR CUENTA'),
                    color: ColorSettings.colorPrimary,
                    onPressed: (){
                      Navigator.of(context).pop('Ok');
                      txtPropina.clear();
                    },
                ),
              ],
            )
          );

        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.monetization_on),
            Text('CALCULAR TOTAL')
          ],
        )
    );

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: ColorSettings.colorPrimary,
              title: Text('PROPINAS'),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 500),
          color: Colors.white60,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Text('INGRESA LA CANTIDAD A PAGAR'),
                SizedBox(height: 15,),
                txtPropinas,
                SizedBox(height: 5,),
                btnCalcular
              ],
            ),
          ),
        )
      ],
    );
  }
}