import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:topicowebflutter3/interfaces/list.medicos.dart';
import 'dart:js' as js;

import 'package:topicowebflutter3/providers/medico.provider.dart';

class MedicoPageListWidget extends StatefulWidget {
  MedicoPageListWidget({Key key, this.title, this.tipoCuenta }) : super(key: key);

  final String title;
  final String tipoCuenta;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<MedicoPageListWidget> {
  var progress;

  TextEditingController _textEditingController;


  @override
  initState(){
      this._textEditingController = new TextEditingController( text: "" );
  }

   Future<void> _showDialog(BuildContext context, String mensaje ) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text( mensaje ),
          content: ElevatedButton(onPressed: (){
                Navigator.of(context).pop();
          }, child: Text("OK")) ,
        );
      });
}

  Future<void> _displayTextInputDialog(BuildContext context, int ci , String email ) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Ingrese su mensaje...'),
          content: Wrap(
            children: [
                Column(
                children: [
                    TextField(
                      maxLines: 5,
                      controller: _textEditingController,
                      decoration: InputDecoration(hintText: "Text Field in Dialog"),
                    ),
                    ElevatedButton(onPressed: (){
                        
                        this.progress.showWithText("Validando cuenta, por favor espera");
                        MedicoProvider.validarMedico(ci, email,  this._textEditingController.text )
                              
                              .then((value) {
                                   progress.dismiss();
                                   if( value == true ){
                                        _showDialog(context , "Medico validado");
                                   }else{
                                     _showDialog(context , "Medico no validado");
                                   }
                              });

                    }, 
                          child: Text("Enviar"))
                ],
            ),
            ],
          ),
        );
      });
}

  @override
  Widget build(BuildContext context) {
    
      return ProgressHUD(
        barrierEnabled: false,
        indicatorColor: Colors.red,
        child: Builder(
             builder: (c)  {
                this.progress = ProgressHUD.of(c);
                return Card(
                  child: ListTile(
                     onTap: null,
                     leading: CircleAvatar(
                       backgroundColor: Colors.transparent,
                     ),
                     title: Row(
                         children: <Widget>[
                           Expanded(child: Text("Nombres", style: TextStyle( fontWeight:  FontWeight.bold  ), )),
                           Expanded(child: Text("Apellidos", style: TextStyle( fontWeight:  FontWeight.bold  ),)),
                           Expanded(child: Text("Estado",style: TextStyle( fontWeight:  FontWeight.bold  ),)),
                           Expanded(child: Text("Foto",style: TextStyle( fontWeight:  FontWeight.bold  ),)),
                           Expanded(child: Text("Archivos",style: TextStyle( fontWeight:  FontWeight.bold  ),) ),
                           Expanded(child: Text("Accion",style: TextStyle( fontWeight:  FontWeight.bold  ),)),
                         ]
                     ),
                    
                    subtitle: FutureBuilder(
                    future: MedicoProvider.obtainAllMedicos(),
                    builder:  ( BuildContext contexto , AsyncSnapshot<ListMedicoResponse> asyncSnapshot ){
                        if( asyncSnapshot.hasError   ){
                              return Text("Hubo un problema");
                          }

                          if( asyncSnapshot.hasData ){
                            return ListView.builder(
                                 
                                  shrinkWrap: true,
                                  itemCount: asyncSnapshot.data.data.length ,
                                  scrollDirection: Axis.vertical,  
                                  itemBuilder: (cont,i) {
                                         return Card(
                                   child:  ListTile(
                                         onTap: null,
                                         title: Row(
                                             children: [
                                                 Expanded(
                                                     child: Text( asyncSnapshot.data.data[i].persona.nombres ),
                                                 ),
                                                 Expanded(
                                                     child: Text( asyncSnapshot.data.data[i].persona.apellidos ),
                                                 ),
                                                 Expanded(
                                                     child: Text( asyncSnapshot.data.data[i].estado ? "Inactivo" : "Activo" ),
                                                 ),
                                                 Expanded(
                                                     child:  Image.network(
                                                              asyncSnapshot.data.data[i].persona.foto,
                                                              height: 50,
                                                              width: 50,
                                                              fit: BoxFit.fill,
                                                        ),
                                                 ),
                                                 Expanded(
                                                     child: ElevatedButton(
                                                      onPressed: (){
                                                          
                                                      },
                                                    style:  ButtonStyle(
                                                          
                                                          backgroundColor: MaterialStateProperty.all( Colors.red ),) 
                                                    ,
                                                        child: Text('VER ARCHIVOS'),
                                                    ),
                                                 ),
                                                 SizedBox( width: 50, ),
                                                 Expanded(
                                                     child: ElevatedButton(
                                                          onPressed:  asyncSnapshot.data.data[i].estado == false ? null :  (){
                                                                _displayTextInputDialog(cont , asyncSnapshot.data.data[i].persona.ci , asyncSnapshot.data.data[i].email );
                                                          },
                                                        style:  ButtonStyle(
                                                              
                                                              backgroundColor: MaterialStateProperty.all( Colors.red ),) 
                                                        ,
                                                            child: Text('HABILITAR MEDICO'),
                                                        ),
                                                 ),
                                                 SizedBox( width: 10, ),
                                                 ElevatedButton(
                                                      onPressed: (){
                                                      },
                                                    style:  ButtonStyle(
                                                          
                                                          backgroundColor: MaterialStateProperty.all( Colors.red ),) 
                                                    ,
                                                        child: Text('Ver medico'),
                                                    ),
                                             ],
                                         ),

                                   ) 
                               );
                                  },
                            );
                          }

                        return Center(child: CircularProgressIndicator());  
                    }  ,
                ),
                   ),
                );
                
             } ,
        ),
      
      );
    
  }

    
     
}   