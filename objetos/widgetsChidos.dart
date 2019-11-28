import 'package:flutter/material.dart';
import 'package:proyecto/main.dart';

Widget logoUpiiz(altura,ancho){
  return Container(
    height: altura*.25,
    width: ancho*.8,
    child: Image.asset('assets/upiiz.png', fit: BoxFit.contain,),
  );
}

// Alertas
void mostrarAlerta({BuildContext context, String mensaje}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: new Text("Error."),

        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(mensaje),
          ],
        ),
        //
        actions: <Widget>[
          FlatButton(
            child: Text("Aceptar"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

void AlertaExitoR({BuildContext context, String mensaje, int vista}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: new Text("Éxito."),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(mensaje),
          ],
        ),
        //
        actions: <Widget>[
          FlatButton(
            child: Text("Aceptar"),
            onPressed: () {
              if(vista == 1){
                Navigator.pop(context);
                final route = MaterialPageRoute(
                  builder: (context)=>Login(),
                );
                Navigator.push(context, route);
              }if(vista == 2){
                Navigator.pop(context);

              }
            },
          ),
        ],
      );
    },
  );
}
