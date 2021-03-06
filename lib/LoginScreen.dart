import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'HomeScreen.dar.dart';
import 'RegisterScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();  //Id. único del formulario
  String _userName;  //variable que almacena el correo del usuario
  String _password;  //variable que almacena la contraseña

  bool _formValidate(){
    if (_formKey.currentState.validate())  // Verifica su hace la validación
    {
        _formKey.currentState.save();
        return true;
    }
    return false;
  }

  void _registerAccount() {
    Navigator.push(context, MaterialPageRoute(builder: (_) =>  RegisterScreen()));
  }

  // función del boton para verificar validaciones
  void _loginAuth ()async
  {
    if (_formValidate()){
      //Firebase autentication
      try{
        print("userName $_userName");
        print("password $_password");
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _userName, password: _password);
        print("Signed in Ok: ${user.uid}");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen(userName: _userName,)));
      }catch(e){
        print("Error: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body: ListView(
        padding: EdgeInsets.all(32.0),
        children: <Widget>[
          SizedBox(
            height: 80.0,
          ),
          FlutterLogo(
            size: 100.0,
          ),
          Center(
            child: Text("Simple LoginApp", style: TextStyle(fontSize: 20.0),),
          ),
          SizedBox(height: 80.0,),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    //filled: true,
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (input)=> _validateEmail(input) ,
                  onSaved: (input)=> _userName = input,
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    //filled: true,
                    labelText: 'Password',
                  ),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  validator: (input)=> _validatePassword(input),
                  onSaved: (input)=> _password = input,
                ),
              ],
            ),

          ),
          SizedBox(height: 15.0,),
          RaisedButton(
              color: Theme.of(context).accentColor,
              elevation: 5.0,
              splashColor: Colors.blueGrey,
              child: Text('ENTRAR'),
              onPressed: () => _loginAuth()),
          FlatButton(
              child: Text('No tienes cuenta? Regístrate aquí'),
              onPressed: () => _registerAccount()),
        ],
      ),
    );
  }

  String _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'El Email no es válido';
    else
      return null;
  }

  String _validatePassword(String value) {
    if (value.isEmpty)
      return "Escriba una contraseña";
    else if (value.length < 6)
      return "La contraseña debe tener por lo menos 6 caracteres";
    else
      return null;
  }
}
