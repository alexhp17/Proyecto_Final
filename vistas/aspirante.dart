import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyecto/objetos/widgetsChidos.dart';
import 'package:proyecto/database/dbaspirante.dart' as asdb;
//Controladores
final controlNombre = TextEditingController();
final controlPaterno = TextEditingController();
final controlMaterno = TextEditingController();
final controledad = TextEditingController();
final controlsexo = TextEditingController();
final controlcorreo = TextEditingController();
final controlmovil = TextEditingController();
final controlprepa = TextEditingController();
final controlop1 = TextEditingController();
final controlop2 = TextEditingController();
final controlop3 = TextEditingController();
final controlfecha = TextEditingController();
String _opc1 = 'Ingeniería en Sistemas';
String _opc2 = 'Ingeniería en Sistemas';
String _opc3 = 'Ingeniería en Sistemas';
int selectRadio =0;
final now = new DateTime.now();
final date = new DateFormat("dd-MM-yyyy").format(now);

//child: Text(new DateFormat("dd-MM-yyyy").format(now)),
class aspiranteScreen extends StatefulWidget {
  @override
  _aspiranteScreenState createState() => _aspiranteScreenState();
}

class _aspiranteScreenState extends State<aspiranteScreen> {
      setSelectRadio(int val){
      setState(() {
        selectRadio = val;
      });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title: Text("Agregar aspirante", style: TextStyle(color: Colors.white),),
            backgroundColor: Color.fromRGBO(118, 41, 51, 1),
            automaticallyImplyLeading: true,

            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white,),
              onPressed: () {
                reset();
                Navigator.pop(context);
              },
            ),
    ),
    body: ListView(
      children: <Widget>[
        titulo(),
        Divider(),
        textoContainer(controlNombre, "Nombre"),
        textoContainer(controlPaterno, "Apellido Paterno"),
        textoContainer(controlMaterno, "Apellido Materno"),
        textoContainer(controledad, "Edad"),
        sexSelector(),
        textoContainer(controlcorreo, "Correo"),
        textoContainer(controlmovil, "Teléfono"),
        textoContainer(controlprepa, "Prepa"),
        opCarreras("Opción 1",_opc1),
        opCarreras("Opción 2",_opc2),
        opCarreras("Opción 3",_opc3),
        registerDate(),
        RaisedButton(
          child: Text("Registrar"),
          onPressed: () async{
            asdb.Aspirante fulano = new asdb.Aspirante(
              id: 0,
              nombre: controlNombre.text+" "+controlPaterno.text+" "+controlMaterno.text,
              edad: controledad.text,
              sexo: selectRadio.toString(),
              correo: controlcorreo.text,
              phone: controlmovil.text,
              escuela: controlprepa.text,
              op1: _opc1,
              op2: _opc2,
              op3: _opc3,
              date: date.toString(),
              sincronizado: 0,
            );
            await asdb.insertAspirante(fulano);
            print(await asdb.aspirantes());
            AlertaExitoR(context: context,mensaje: "¡Aspirante agregado con éxito!",vista: 2);
          },
          
        ),

      ]
    ),
    );
  }
  // Este widget es para el encabezado del formulario
  Widget titulo(){
    var ancho = MediaQuery.of(context).size.width;
    var alto = MediaQuery.of(context).size.height;
    return Row(
          children: <Widget>[
            Container(
              width: ancho*.3,
              height: alto/11,
              child: logoUpiiz(alto, ancho),
            ),
            Container(
              height: alto/11,
              width: ancho*.7,
              alignment: Alignment.center,
              child: Text("Formulario de registro de aspirante",style: TextStyle(fontSize: 22),),
            )

          ],
        );
  }
  // ... termina encabezado.
  //..
  // Widget para la etiqueta de fecha de registro
  Widget registerDate(){
    var ancho = MediaQuery.of(context).size.width;
    var alto = MediaQuery.of(context).size.height;
  return Container(
    padding: EdgeInsets.only(left: ancho*.3),
    height: alto/11,
      child:Row(
        children: <Widget>[
    Container(
      child: Text("Fecha de registro: "),
    ),
    Container(
      child: Text(date.toString()),
    )
    ],
  )
);
}
    // .. termina la etiqueta de fecha de registro
    //.
    // Widget para las opciones de carrera
  Widget opCarreras(opc,select){
    var ancho = MediaQuery.of(context).size.width;
    var alto = MediaQuery.of(context).size.height;
    return Container(
      height: alto/11,
      child: Row(
        children: <Widget>[
          Container(
            width: ancho*.20,
            child: Align(child: Text("$opc: "),alignment: Alignment.center,),
          ),
          SizedBox(width: 100,),
          Container(
            child: DropdownButton(
              value: select,
              items: getOpcionesDropdown(),
              onChanged: (opt){
                switch(opc){
                  case "Opción 1":
                  setState(() {
                  _opc1 = opt;
                });
                    break;
                  case "Opción 2":
                    setState(() {
                  _opc2 = opt;
                });
                    break;
                  case "Opción 3":
                  setState(() {
                  _opc3 = opt;
                });
                    break;
                }
                
              },
            ),
          )
        ],
      ),
    );
  }

  List<String> _carreras = [
                            'Ingeniería en Sistemas', 
                            'Ingeniería en Mecatrónica', 
                            'Ingeniería Metalúrgica', 
                            'Ingeniería Ambiental', 
                            'Ingeniería en Alimentos'
                            ];
  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = new List();
    _carreras.forEach((poder) {
      lista.add(new DropdownMenuItem(
        child: Text(poder), // lo que se muestra
        value: poder,
      ));
    });
    return lista;
  }
//..termina selector de carreras.
//..
//Widget selector de sexo
Widget sexSelector(){
  var alto = MediaQuery.of(context).size.height;
  var ancho = MediaQuery.of(context).size.height;
  return Container(
      height: alto/11,
      child: Row(
      children: <Widget>[
      Container(
        width: ancho*.1,
        child: Text("Sexo: ", textAlign: TextAlign.center,
        ),
    ),
      Radio(value: 1, groupValue: selectRadio, onChanged: (val){ setSelectRadio(val);}),
      Text('Masculino'),
      Radio(value: 2, groupValue: selectRadio, onChanged: (val){setSelectRadio(val);}),
      Text('Femenino'),
      ],
    )
  );
}
//...termina selector de sexo
//..
// Widget para reutilizar container para entradas de textos.
  Widget textoContainer(lecon,tag){
    var ancho = MediaQuery.of(context).size.width;
    var alto = MediaQuery.of(context).size.height;
    var l=30;
    var input = TextInputType.text; 
    if(tag=='Edad'){l=3; input=TextInputType.number;}
    if(tag=='Correo'){l=45;input=TextInputType.emailAddress;}
    if(tag=='Teléfono'){l=10;input=TextInputType.phone;}
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Container(
        height: alto/11,
        child: Row(
          children: <Widget>[
            Container(
              width: ancho*.2,
              child: Text("$tag"),
            ),
            Container(
              width: ancho*.78-8,
              child: TextField(
              maxLength: l,
              keyboardType: input,
              controller: lecon,
              decoration: InputDecoration(
                border: OutlineInputBorder()
              )
            ),
          )

          ],
        ),
      ),
    );
  }
//termina widget de inputs
//
void reset(){
  setState(() {
  controlPaterno.clear();
  controledad.clear();
  controlsexo.clear();
  controlcorreo.clear();
  controlmovil.clear();
  controlprepa.clear();
  controlop1.clear();
  controlop2.clear();
  controlop3.clear();
  controlfecha.clear();
  controlNombre.clear();
  controlMaterno.clear();
  selectRadio=0;
  });
}
}//