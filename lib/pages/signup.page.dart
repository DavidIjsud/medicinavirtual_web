
import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:topicowebflutter3/pages/login.page.dart';
import 'package:topicowebflutter3/providers/medico.provider.dart';
import 'package:topicowebflutter3/widgets/bezierContainer.dart';



class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

 TextEditingController  controladorRepeatPassword ,controladorEspecialidad  ,controladorValidarPinField , controladorCV , controladorFotoTitulo, controladorContrato, controladorNumeroMatricula ,controladorCorreo, controladorCi , controladorNombres, controladorApellidos, controladorTelefono , controladorDateBirth, controladorPasword, controladorFoto;
  List<int> _selectedFoto , _selectedFotoContrato, _selectedFotoTitulo, _selectedFotocv;
  Uint8List _bytesDataFoto, _bytesDataContrato , _bytesDataTitulo, _bytesDataFotocv;
  html.File tipoFotoFile , tipoContratoFile, tipoTituloFile, tipoFotocvFile;
  @override
  void initState() {
      super.initState();
      inicializarControlers();
  }

  void inicializarControlers(){
      this.controladorCorreo = new TextEditingController(text: "");
      this.controladorCi = new TextEditingController(text: "");
      this.controladorNombres = new TextEditingController(text: "");
      this.controladorApellidos = new TextEditingController(text: "");
      this.controladorTelefono = new TextEditingController(text: "");
      this.controladorDateBirth = new TextEditingController(text: "");
      this.controladorPasword = new TextEditingController(text: "");
      this.controladorFoto = new TextEditingController(text: "");
      this.controladorValidarPinField = new TextEditingController(text: "");
      this.controladorCV = new TextEditingController( text: "" );
      this.controladorFotoTitulo = new TextEditingController( text: "" );
      this.controladorContrato = new TextEditingController( text: "" );
      this.controladorNumeroMatricula = new TextEditingController( text: "" );
      this.controladorEspecialidad = new TextEditingController( text: "" );
      this.controladorRepeatPassword = new TextEditingController( text: "" );
   }

  Widget _backButton() {    
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Atras',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  void _mostrarDate(BuildContext context) {
          
          DateFormat dateFormat = DateFormat("yyyy-MM-dd");
         showDatePicker(
          locale: Locale('es'),
          context: context,
          firstDate: DateTime(1900,0),
          initialDate: DateTime.now(),
          lastDate: new DateTime(2101),
          builder: ( BuildContext contexto , Widget child ) {
              return Theme(
                  data: ThemeData.light().copyWith(
                     buttonTheme: ButtonThemeData(
                          textTheme: ButtonTextTheme.primary
                        ),
                    colorScheme: ColorScheme.light( primary  : Colors.red ),
                    primaryColor: Colors.red,//Head background
                    accentColor: Colors.red//selection color
                    //dialogBackgroundColor: Colors.white,//Background color
                    ),     
                    child: child,
              );
          } 
        ).then( (DateTime fecha){
             if( fecha != null ){
                  String valor =  dateFormat.format(fecha);
                  ///esto se hara solo para mostrar en la vista pero al servidor se manda otro
                  DateFormat formaToVisual = DateFormat("yyyy-MM-dd");
                  String formatoVisualString = formaToVisual.format(fecha);
                  this.controladorDateBirth.text = formatoVisualString;
             }
   
        } );
   }

  Widget _entryField(String title, TextInputType inputType , TextEditingController controller , {bool isPassword = false , bool isBirth = false , BuildContext contexto }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric( horizontal: 100 ),
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric( horizontal: 100 ),
            child: TextField(
                controller:  controller,
                obscureText: isPassword,
                keyboardType:  inputType,
                enableInteractiveSelection: isBirth,
                onTap: () async {
                    if( title == "* Fecha Nacimiento" ){
                      FocusScope.of(contexto).requestFocus(new FocusNode());
                      _mostrarDate(contexto);
                    }

                    if( title == "* Subir Foto" || title == "* Subir Contrato" || title == "* Subir Titulo" || title == "* Subir CV" ){  
                         //FocusScope.of(contexto).requestFocus(new FocusNode());
                        FocusManager.instance.primaryFocus?.unfocus();
                        await _pickFile( title );
                     }
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true)),
          )
        ],
      ),
    );
  }

 

   _pickFile( String from )  async {

     final ImagePicker _picker = ImagePicker();
      
        
          if( from == "* Subir Foto" ){

               html.InputElement uploadInput = html.FileUploadInputElement();
              uploadInput.multiple = false;
              uploadInput.draggable = true;
              uploadInput.click();
              uploadInput.onChange.listen((e) {
                final files = uploadInput.files;
                final file = files[0];
                print("Tipo archivo" + file.type);
                final reader = new html.FileReader();
                this.tipoFotoFile = file;
                reader.onLoadEnd.listen((e) {
                  this.controladorFoto.text = "Foto Lista para enviar"; 
                  _bytesDataFoto = Base64Decoder().convert(reader.result.toString().split(",").last);
                  _selectedFoto = _bytesDataFoto;

                });
                reader.readAsDataUrl(file);
              });

          }      

      if( from == "* Subir Contrato" ){
            
           html.InputElement uploadInput = html.FileUploadInputElement();
              uploadInput.multiple = false;
              uploadInput.draggable = true;
              uploadInput.click();
              uploadInput.onChange.listen((e) {
                final files = uploadInput.files;
                final file = files[0];
                print("Tipo archivo" + file.type);
                final reader = new html.FileReader();
                this.tipoContratoFile = file;
                reader.onLoadEnd.listen((e) {
                  this.controladorContrato.text = "Contrato Lista para enviar";
                  _bytesDataContrato = Base64Decoder().convert(reader.result.toString().split(",").last);
                  _selectedFotoContrato = _bytesDataContrato;

                });
                reader.readAsDataUrl(file);
              });
      }

      if( from == "* Subir Titulo" ){
             html.InputElement uploadInput = html.FileUploadInputElement();
              uploadInput.multiple = false;
              uploadInput.draggable = true;
              uploadInput.click();
              uploadInput.onChange.listen((e) {
                final files = uploadInput.files;
                final file = files[0];
                print("Tipo archivo" + file.type);
                final reader = new html.FileReader();
                this.tipoTituloFile = file;
                reader.onLoadEnd.listen((e) {
                  this.controladorFotoTitulo.text = "Titulo Lista para enviar";
                  _bytesDataTitulo = Base64Decoder().convert(reader.result.toString().split(",").last);
                  _selectedFotoTitulo = _bytesDataTitulo;

                });
                reader.readAsDataUrl(file);
              });
      }

      if( from == "* Subir CV" ){
            html.InputElement uploadInput = html.FileUploadInputElement();
              uploadInput.multiple = false;
              uploadInput.draggable = true;
              uploadInput.click();
              uploadInput.onChange.listen((e) {
                final files = uploadInput.files;
                final file = files[0];
                print("Tipo archivo" + file.type);
                final reader = new html.FileReader();
                this.tipoFotocvFile = file;
                reader.onLoadEnd.listen((e) {
                  this.controladorCV.text = "CV Lista para enviar";
                  _bytesDataFotocv = Base64Decoder().convert(reader.result.toString().split(",").last);
                  _selectedFotocv = _bytesDataFotocv;

                });
                reader.readAsDataUrl(file);
              });
      } 
     
  }

  bool _validateFields() {
       if( this.controladorCorreo.text == null || this.controladorCorreo.text == "" ||
           this.controladorCi.text == null || this.controladorCi.text == "" ||
           this.controladorNombres.text == null || this.controladorNombres.text == "" ||
           this.controladorApellidos.text == null || this.controladorApellidos.text == "" ||
           this.controladorTelefono.text == null || this.controladorTelefono.text == "" ||
           this.controladorDateBirth.text == null || this.controladorDateBirth.text == "" ||
           this.controladorPasword.text == null || this.controladorPasword.text == "" ||
           this.controladorFoto.text == null || this.controladorFoto.text == "" ||
           this.controladorCV.text == "" || this.controladorCV.text == "" || 
           this.controladorFotoTitulo.text == "" || this.controladorFotoTitulo.text == "" || 
           this.controladorContrato.text == "" || this.controladorContrato.text == "" ||
           this.controladorNumeroMatricula.text == null || this.controladorNumeroMatricula.text == "" ||
           this.controladorEspecialidad.text == null || this.controladorEspecialidad.text == "" ||
           this.controladorRepeatPassword == null || this.controladorEspecialidad.text == ""
  
        ) return false;

        return true;
  }


  _enviarInformacion( BuildContext contexto )  {
        Map<String, String> informacion = {
            "fechaNacimiento" : this.controladorDateBirth.text,
            "ci" : this.controladorCi.text,
            "apellidos" : this.controladorApellidos.text,
            "nombres" : this.controladorNombres.text,
            "telefono" : this.controladorTelefono.text,
            "email" : this.controladorCorreo.text,
            "contrasena" : this.controladorPasword.text,
            "foto" : "asd",
            "contrato" : "asd",
            "cv" : "asdad",
            "fotoTituloProfesional" :"asd",
            "numeroMatricula" : this.controladorNumeroMatricula.text,
            "rol" : "MEDICO" ,
             "especialidad"  : this.controladorEspecialidad.text
        };
        final progress = ProgressHUD.of(contexto);
        progress.showWithText('Enviando Informacion');
        var tipos = {
             "foto" : this.tipoFotoFile.name ,//+ "." + this.tipoFotoFile.type.split("/")[1],
             "fotoTituloProfesional" : this.tipoTituloFile.name ,//+ "." + this.tipoTituloFile.type.split("/")[1],
             "contrato" : this.tipoContratoFile.name ,//+ "." + this.tipoContratoFile.type.split("/")[1],
             "cv" : this.tipoFotocvFile.name,// + "." + this.tipoFotocvFile.type.split("/")[1]
        };
        MedicoProvider.sendData(this._selectedFoto, this._selectedFotoTitulo, this._selectedFotocv, this._selectedFotoContrato, informacion , tipos)
            .then((value) {
                 print("Respuesta " + value.toString());
                 progress.dismiss();
                 if( value['status'] == 'true' ){
                         final snackBar = SnackBar(content: Text('Medico registrado. Se le notificara al correo ingresado cuando haya sido aceptado'));
                         ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          Future.delayed(Duration( seconds: 3 ) , () {
                                  Navigator.pop(
                                           context, MaterialPageRoute(builder: (context) => LoginPage()));
                          } );

                 }else{
                       final snackBar = SnackBar(content: Text('Hubo un problema, vuelva a intentarlo'));
                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                 }
            });
       
  }

  Widget _btnValidarPin( BuildContext cont ){
      return RaisedButton(
             onPressed: (){
                  final progress = ProgressHUD.of(cont);
                  if( this.controladorValidarPinField != null || this.controladorValidarPinField.text != "" ){
                        progress.showWithText('Validando pin, no cerrar app'); 
                       
                  }else{
                      final snackBar = SnackBar(content: Text('Debe ingresar un pin, verificar su correo ingresado'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar); 
                  }
             },
             child: Container(
                 child: Text("Verificar"),
                 padding: EdgeInsets.symmetric( horizontal: 50, vertical: 10 ),
                 
             ),
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                elevation: 0.0,
                color:  Colors.white ,
                textColor: Colors.red,
         );
  }

  void _dialogForPin( BuildContext contextox ){
     showDialog(
                barrierDismissible: false,
                context: contextox,
                builder: ( BuildContext contexto ) {
                      return Dialog(
                           backgroundColor:  Colors.transparent,
                           shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all( Radius.circular(20.0) )
                           ),
                           child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: TextField(
                                    controller:  this.controladorValidarPinField ,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20.0)),

                                      filled: true,
                                      fillColor: Colors.white,

                                      prefixIcon: Icon(Icons.person),
                                      hintText: "Ingresar Pin",
                                    ),
                                    onChanged: (value) {
                                    },
                                  ),
                               ),
                               SizedBox( height: 20, ),
                               _btnValidarPin( contextox )
                              
                              ],
                           ),
                      );       
                }
     );    

  }

  Widget _submitButton( BuildContext contexto ) {
    return GestureDetector(
      onTap: (){
         bool validados = _validateFields();

          if( this.controladorPasword.text != this.controladorRepeatPassword.text ){
              final snackBar = SnackBar(content: Text('Contraseñas no coinciden'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return;
          }

          if( validados == false ){
              print('object');
              final snackBar = SnackBar(content: Text('Llenar todos los campos'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return;
          }
          _enviarInformacion( contexto );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'Registrarse',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Ya tienes una cuenta ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Ingresa',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Top',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'ico',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: ' Avanzado',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ProgressHUD(
        indicatorColor: Colors.red,
        child: Builder(
          builder:( contextProgress ) => Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -MediaQuery.of(contextProgress).size.height * .15,
                right: -MediaQuery.of(contextProgress).size.width * .4,
                child: BezierContainer(),
              ),
              SingleChildScrollView(
                child: ListView(
                    shrinkWrap: true,
              //    crossAxisAlignment: CrossAxisAlignment.center,
                //  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .01),
                    _title(),
                    SizedBox(
                      height: 30,
                    ),
                    //_emailPasswordWidget(contextProgress),
                    Row(
                       mainAxisSize: MainAxisSize.max,
                       children: [
                                Expanded(
                                  child: Column(
                              children: [
                                    _entryField("* Correo(Usuario)" ,  TextInputType.emailAddress , this.controladorCorreo ),
                                    _entryField("* Ci", TextInputType.number  , this.controladorCi ),
                                    _entryField('* Nombres', TextInputType.text , this.controladorNombres),
                                    _entryField('* Apellidos',TextInputType.text , this.controladorApellidos),
                                    _entryField('* Telefono', TextInputType.phone , this.controladorTelefono ),
                                    _entryField('* Fecha Nacimiento', TextInputType.datetime , this.controladorDateBirth  , isBirth: true ,contexto: contextProgress   ),
                                    _entryField("Especialidad", TextInputType.text, this.controladorEspecialidad)
                              ],
                          ),
                                ),
                                 Expanded(
                                  child: Column(
                              children: [
                                  _entryField('* Numero Matricula',  TextInputType.text , this.controladorNumeroMatricula),
                                  _entryField("* Password", TextInputType.text , this.controladorPasword ,isPassword: true),
                                  _entryField("* Repetir password",  TextInputType.text ,  this.controladorRepeatPassword, isPassword: true ),
                                  _entryField("* Subir Foto" ,  TextInputType.text , this.controladorFoto , isBirth:  true ),
                                  _entryField('* Subir Contrato', TextInputType.text   , this.controladorContrato , isBirth: true  ),
                                  _entryField('* Subir Titulo', TextInputType.text   , this.controladorFotoTitulo , isBirth: true  ),
                                  _entryField('* Subir CV', TextInputType.text   , this.controladorCV , isBirth: true  ),
                                    
                              ],
                          ),
                                ),
                       ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric( horizontal: 600.0 ),
                      child: _submitButton(contextProgress),
                    ),
                    SizedBox(height: height * .01),
                    _loginAccountLabel(),
                  ],
                ),
              ),
              Positioned(top: 40, left: 0, child: _backButton()),
            ],
          ),
        ),
       )
      ),
    );
  }
}
