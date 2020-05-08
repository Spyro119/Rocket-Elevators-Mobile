import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rocketelevatorsapp/models/employeeResponse.dart';
import 'package:rocketelevatorsapp/routes.dart';
import 'package:rocketelevatorsapp/repository/Employees_repository.dart';
import 'package:rocketelevatorsapp/views/Alert.dart';

void main() => runApp(MyApp());
bool isSignedin = false;

// Fetching Employees from API and looking if user input matches
// Employee's database model informations in order to access next pages.
Future<bool> getinfos() async{
  print('email : ' + email + ' password : ' + name  );
  dynamic employee = new EmployeesRepository();
  List<EmployeeResponse> Employees = await employee.fetchEmployees();
  int EmployeesLength = Employees.length;
  for(var i = 0; i< EmployeesLength; i++){
    if (email.toString() == Employees[i].email && name == Employees[i].firstname){
      isSignedin = true;
      break;
    }
    else {
      isSignedin = false;
    }
  }
  return isSignedin;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rocket elevators',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,

      ),
      routes: routes,
      home: MyHomePage(title: 'Rocket Elevators mobile app'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
String email = " ";
String name = "";

class _MyHomePageState extends State<MyHomePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final nameField = TextField(
      onChanged: (text) {
        name = text;
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "First name",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),

    );

    final emailField = TextField(
      onChanged: (text) {
        email = text;
      },
      keyboardType: TextInputType.emailAddress,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.blue,
//      Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          await getinfos();
          if(isSignedin == true) {
            Navigator.pushNamed(context, '/Elevators');
          }
          else{
            showAlertDialog(context);
          }
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      
      appBar: AppBar(
        title: Text('Rocket elevator mobile app'),
      ),
      resizeToAvoidBottomInset: true, // set it to false
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 115.0,
                    child: Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 45.0),
                  nameField,
                  SizedBox(height: 25.0),
                  emailField,
                  SizedBox(
                    height: 20.0,
                  ),
                  loginButton,
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



