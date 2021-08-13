import 'package:flutter/material.dart';
import 'package:topicowebflutter3/interfaces/horarioMedico.dart';
import 'package:topicowebflutter3/providers/medico.provider.dart';

class MisHorariosMedico extends StatefulWidget {
  const MisHorariosMedico({ Key key }) : super(key: key);

  @override
  _MisHorariosMedicoState createState() => _MisHorariosMedicoState();
}

_listaExpandible( List<HorarioElement> listaHorarios ){

    List<Widget> columnContent =[];

    columnContent.add( new ListTile(
         title: new Text(
            "HORA",
            style: new TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic)
         ),
         trailing:  new Text(
             "ACCION",
             style: new TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic)   
           ),
    ));

    for (HorarioElement horarioElement in listaHorarios){
         print(horarioElement.activo);
          columnContent.add(
               new ListTile(
                   title:  Text(horarioElement.horario.horaFijada , style: new TextStyle(fontSize: 18.0) ),
                   trailing : ElevatedButton(onPressed: (){}, child: Text(  horarioElement.activo == "0" ? "Inactivar" : "Activar"    ) )
               )
          );
    }

    columnContent.add(
        Container(
          height: 60,
          width: 300,
          color: Colors.red,
          child: new ElevatedButton(onPressed: (){}, child: Text("INACTIVAR DIA COMPLETO")  ))
    );

    return columnContent;

}

class _MisHorariosMedicoState extends State<MisHorariosMedico> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
         future: MedicoProvider.obtainMedicoHorario(8154167),
          builder: ( BuildContext con , AsyncSnapshot<HorariosMedico> asyncSnapshot ) {
               
                if( asyncSnapshot.hasData ){
                     if( asyncSnapshot.data.status ){
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: asyncSnapshot.data.data.length,
                            itemBuilder: ( _ , i ){
                                   return ExpansionTile(
                                         backgroundColor: Colors.white,
                                         title: Container(
                                           color: Colors.white,
                                           child: Text( asyncSnapshot.data.data[i].dia.nombre , style: TextStyle( fontSize: 22 ) ,  )),
                                         children: _listaExpandible( asyncSnapshot.data.data[i].dia.horarios ),
                                      );
                            }
                           );
                     }else{
                       return Center(child: CircularProgressIndicator());
                     }
                }else{
                   return Center(child: CircularProgressIndicator());
                }
              
          }
        );
  }
}