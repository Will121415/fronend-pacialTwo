import 'package:flutter/material.dart';
import 'package:parcial_two/bloc/sign_in_bloc.dart';
import 'package:parcial_two/model/login_model.dart';
import 'package:parcial_two/ui/screen/admin_screen.dart';
import 'package:parcial_two/ui/screen/attetion_staff_screen.dart';
import 'package:parcial_two/ui/widget/button_generic.dart';

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInt();
}

class _SignInt extends State<SignIn> {
  TextEditingController controllerUser;
  TextEditingController controllerPassword;
  bool showPassword = true;
  LoginBloc loginBloc;
  bool correctData = false;

  @override
  void initState() {
    controllerUser = TextEditingController();
    controllerPassword = TextEditingController();
    super.initState();
  }

  void visibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    loginBloc = new LoginBloc();
    Size size = MediaQuery.of(context).size;

    final wallpaper = Container(
      width: size.width,
      height: size.height,
      child: Image.network(
        'https://i.pinimg.com/564x/45/bb/bf/45bbbf04a9873a44398629b41ef193d6.jpg',
        fit: BoxFit.cover,
      ),
    );

    final imageLogo = Padding(
      padding: EdgeInsets.all(15),
      child: CircleAvatar(
        radius: size.height * 0.10,
        backgroundImage: NetworkImage(
            'https://i.pinimg.com/564x/c1/d7/5b/c1d75b7e75f18881e542191d0c6c918d.jpg'),
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          wallpaper,
          SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 150.0),
              // color: Colors.amber,
              child: Column(
                children: [
                  imageLogo,
                  userTextField(),
                  passwordTextField(),
                  ButtonGeneric(
                    title: 'Sign In',
                    height: 50.0,
                    width: 270.0,
                    onPressed: () {
                      Login l = Login(
                          userName: controllerUser.text,
                          password: controllerPassword.text);
                      loginBloc.signInUser(l).then((login) {
                        print(login);
                        if (login != null) {
                          correctData = true;
                          myShowDialog(
                              context,
                              'Has iniciado sesion como <${login.role.toUpperCase()}>',
                              Colors.amber,
                              'Bienvenido...!',
                              login.role);
                        } else {
                          correctData = false;
                          myShowDialog(
                              context,
                              'Sus credenciales son incorrectas',
                              Colors.amber,
                              'Error al iniciar seccion...!',
                              '');
                        }
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget userTextField() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: TextField(
        controller: controllerUser,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            icon: Icon(Icons.person),
            labelText: 'USUARIO',
            suffix: GestureDetector(
              child: Icon(Icons.close),
              onTap: () {
                WidgetsBinding.instance
                    .addPostFrameCallback((_) => controllerUser.clear());
              },
            )),
      ),
    );
  }

  Widget passwordTextField() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: TextField(
        obscureText: showPassword,
        controller: controllerPassword,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white),
          ),
          icon: Icon(Icons.lock),
          labelText: 'PASSWORD',
          suffixIcon: GestureDetector(
            child: Icon(Icons.close),
            onTap: () {
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => controllerPassword.clear());
            },
          ),
          suffix: GestureDetector(
            onTap: visibility,
            child: Icon(showPassword ? Icons.visibility_off : Icons.visibility),
          ),
        ),
      ),
    );
  }

  myShowDialog(BuildContext context, String message, Color colors,
      String _title, String type) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(_title, style: TextStyle(color: Colors.white)),
        backgroundColor: colors,
        content: Text('' + message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            )),
        actions: [
          TextButton(
            onPressed: () {
              if (correctData == true) {
                controllerUser.clear();
                controllerPassword.clear();
                Navigator.pop(context);
                if (type == 'admin') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminScreen()));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AttentionStaffScreen()));
                }
              } else {
                Navigator.pop(context);
                controllerUser.clear();
                controllerPassword.clear();
              }
            },
            child: Text(
              'CONFIRMAR',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
