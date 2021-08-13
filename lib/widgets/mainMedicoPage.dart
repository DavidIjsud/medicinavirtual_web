import 'package:change_notifier_builder/change_notifier_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:topicowebflutter3/interfaces/diasEleccion.dart';
import 'package:topicowebflutter3/interfaces/horarioEleccion.dart';
import 'package:topicowebflutter3/providers/medico.provider.dart';
import 'package:topicowebflutter3/providers/widgetChange.Notifier.dart';
import 'package:topicowebflutter3/widgets/widgetsMEdicoPage/misHorariosMedicoWidget.dart';

class HorarioRegisterMedico extends StatefulWidget {
  HorarioRegisterMedico({Key key, this.title, this.tipoCuenta }) : super(key: key);

  final String title;
  final String tipoCuenta;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<HorarioRegisterMedico> {

  
  WidgetChangeMedicoHorarios _widgetChangeMedicoHorarios;
  int idDia,idHora;
  var progress;

  Color color;

  @override
    void initState() {
      // TODO: implement initState
      super.initState();

      this.idDia = this.idHora = 0;
      this._widgetChangeMedicoHorarios = new WidgetChangeMedicoHorarios();
      color = Colors.orange;

    }


    Widget _btnMisHorarios(){
       return Container(
              width: 250 ,
              height: 50,
              child: ElevatedButton(
               child: Text('Mis horarios'),
                onPressed: (){
                     this._widgetChangeMedicoHorarios.changeWidget( MisHorariosMedico() );
                }
              ),
            );
    }

    Widget _btnAgregarHorario(){
        return Container(
              width: 250 ,
              height: 50,
              child: ElevatedButton(
               child: Text('Agregar horario'),
                onPressed: (){
                      _showMyDialog();
                }
              ),
            );
    }

    Future<void> _showMyDialog() async {
      showDialog(
  context: context,
  builder: (_) => new AlertDialog(
  shape: RoundedRectangleBorder(
    borderRadius:
      BorderRadius.all(
        Radius.circular(10.0))),
    content: ProgressHUD(
      child: Builder(
        builder: (x) {
           this.progress = ProgressHUD.of(x);
          // Get available height and width of the build area of this widget. Make a choice depending on the size.                              
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;

          return Container(
            height: height - 400,
            width: width - 400,
            child:  Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                     Expanded(
                       child:  Column(
                            children: [
                                Text("Elegir Dia"),
                                Expanded(
                                  child: FutureBuilder(
                         future:  MedicoProvider.obtenerDiasAEleccion() ,
                         builder:  ( _ , AsyncSnapshot<DiasEleccion> asyncSnapshot ){

                              if( asyncSnapshot.hasData ){
                                     if( asyncSnapshot.data.status ){
                                        return ListView.builder(
                                          shrinkWrap: true,
                                            itemCount:  asyncSnapshot.data.data.length,
                                            itemBuilder: (_, i){
                                                return GestureDetector(
                                                  onTap: () {
                                                       this.idDia = asyncSnapshot.data.data[i].id;
                                                       
                                                  },
                                                  child: Card(
                                                  color:  this.color,
                                                  elevation: 20.0,
                                                  margin: EdgeInsets.all(10.0),
                                                  child: Text( asyncSnapshot.data.data[i].nombre ),
                                                    ),
                                                );  
                                            }
                                            );
                                     }else{
                                       return Center( child: Text('Cargando Dias...') );
                                     }
                              }else{
                                    return Center( child: Text('Cargando Dias...') );
                              }

                         } ),
                                ),
                                Container(
                                   width: 200,
                                   height: 60,
                                   child: ElevatedButton(onPressed: (){

                                            if(  this.idDia == 0 || this.idHora == 0 ){
                                                   final snackBar = SnackBar(content: Text('Debe seleccionar hora y dia'));
                                                     Navigator.of(context).pop();
                                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                return ;
                                            }

                                          this.progress.showWithText("Enviando nuevo horario");
                                          MedicoProvider.saveNewHorarioMedico(this.idDia, this.idHora)
                                              .then((value) {
                                                  this.progress.dismiss();
                                                    if (value) {
                                                        final snackBar = SnackBar(content: Text('Horario registrado'));

                                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                                        
                                                             Navigator.of(context).pop();
                                                      
                                                       
                                                    } else {
                                                          final snackBar = SnackBar(content: Text('Horario no registrado'));

                                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                                       
                                                             Navigator.of(context).pop();
                                                        
                                                    }
                                              });

                                   }, child: Text("AGREGAR")),
                                ),
                            ],
                       ),
                     ),
                     Expanded(
                       child: Column(
                           children: [
                                Text("Elegir hora"),
                                Expanded(
                                  child: FutureBuilder(
                         future:  MedicoProvider.obtenerHorariosAEleccion() ,
                         builder:  ( _ , AsyncSnapshot<HorariosEleccion> asyncSnapshot ){

                              if( asyncSnapshot.hasData ){
                                     if( asyncSnapshot.data.status ){
                                        return ListView.builder(
                                          shrinkWrap: true,
                                            itemCount:  asyncSnapshot.data.data.length,
                                            itemBuilder: (_, i){
                                                return GestureDetector(
                                                  onTap: () {
                                                       this.idHora = asyncSnapshot.data.data[i].id;
                                                  },
                                                  child: Card(
                                                      color: this.color,
                                                      elevation: 20.0,
                                                      margin: EdgeInsets.all(10.0),
                                                      child: Text( asyncSnapshot.data.data[i].horaFijada ),
                                                  ),
                                                );   
                                            }
                                            );
                                     }else{
                                        return Center( child: Text('Cargando Horarios...') );
                                     }
                              }else{
                                     return Center( child: Text('Cargando Horarios...') );
                              }

                         } ),
                                )
                           ],
                       ),
                     )
                 ],
            ),
          );
        },
      ),
    ),
  )
);
}

  @override
  Widget build(BuildContext context) {

      return Builder(
          builder: (_){
              
               return Column(
         children: [
               SizedBox( height:  40, ),
               Row( 
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                      //ElevetedButton Widget
                       
                      _btnMisHorarios(),
                      SizedBox( width:  70, ),
                      _btnAgregarHorario()
                   ],
                   
                ),
                ChangeNotifierBuilder(
                   notifier: this._widgetChangeMedicoHorarios,
                   builder: ( c, WidgetChangeMedicoHorarios wc , Widget w )  {
                        return wc.widget;
                   },
                ),
         ],
      );
          }
        );
       
  }

  
  
}