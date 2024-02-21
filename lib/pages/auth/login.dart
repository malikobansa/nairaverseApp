import 'package:flutter/material.dart';
// Assuming 'auth.dart' contains the loginUser function.
import 'package:nairaverse/auth.dart'; 
import 'package:nairaverse/homepage.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Form'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username or email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),
              ElevatedButton(
                onPressed: () {
                  loginUser(_email, _password).then((value) {
                  if (value == "success") {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Successful")));
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePages())); // Corrected to HomePage
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value))); // Display the error message
                  }
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Failed: $error")));
                });
                }, // Call the _submitForm method on button press.
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginForm(),
  ));
}
