import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:topicowebflutter3/pages/homeAdministrador.page.dart';
import 'package:topicowebflutter3/pages/signup.page.dart';
import 'package:topicowebflutter3/providers/medico.provider.dart';
import 'package:topicowebflutter3/widgets/bezierContainer.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController controladorEmail , controladorPassowrd;
  var progress;

  @override
  initState(){
      this.controladorEmail = new TextEditingController( text: "");
      this.controladorPassowrd = new TextEditingController( text: "");
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

  Widget _entryField(String title, TextEditingController controlador  ,{bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: controlador,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

 bool _validateControllers (){
      if( this.controladorEmail.text == "" || this.controladorPassowrd.text == "")  {
          return false;
      }

      return true;
 }

  Widget _submitButton( BuildContext x )  {
    return GestureDetector(
      onTap: () async {
          bool validado = _validateControllers();
           if( validado){
                progress.showWithText('Verificando informacion');
                MedicoProvider.loginMedicoAdm(this.controladorEmail.text,  this.controladorPassowrd.text )
                      .then((value) {
                           progress.dismiss();
                           if( value != null &&  value.status == true ){
                                print(value.data.tipoCuenta);
                                   Navigator.push(context, MaterialPageRoute(builder: (context) => MedicoPage( tipoCuenta: value.data.tipoCuenta )));
                                // Navigator.push( context, MaterialPageRoute(builder: (context) => SignUpPage()));
                           }else{
                                 final snackBar = SnackBar(content: Text( value != null ? value.message : "Dato no existente, error" ));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                           }
                      });
                   print("paso");   
           }else{
              //Show a snackbar to indicate that the form is not valid in dart flutter
              final snackBar = SnackBar(content: Text('Llenar todos los campos'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
           }  
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
          'Ingresar',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff1959a9),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('f',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff2872ba),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('Inicio con Facebook',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Eres medico?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Registrate',
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
          text: 'Topi',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'co ',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'Avanzado',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email" , this.controladorEmail ),
        _entryField("Contraseña", this.controladorPassowrd  ,isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: ProgressHUD(
          indicatorColor: Colors.red,
          barrierEnabled: false,
          child: Builder(
             builder: (c) {
                this.progress = ProgressHUD.of(c);
                 return Container(
      height: height,
      child: Stack(
          children: <Widget>[
            Positioned(
                top: -height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .1),
                    _title(),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric( horizontal: 600.0 ),
                      child: _emailPasswordWidget(),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric( horizontal: 600.0  )  ,
                      child: _submitButton(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric( horizontal: 600.0  )  ,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.centerRight,
                        child: Text('Olvido su contraseña ?',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric( horizontal: 600.0  ),
                      child: _divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric( horizontal: 600.0  ),
                      child: _facebookButton(),
                    ),
                    SizedBox(height: height * .055),
                    Padding(
                      padding: const EdgeInsets.symmetric( horizontal: 600.0  ),
                      child: _createAccountLabel(),
                    ),
                  ],
                ),
              ),
            ),
          ],
      ),
    );
             }
          )
        ));
  }
}