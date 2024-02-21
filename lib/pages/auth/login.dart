import 'package:flutter/material.dart';
// Assuming 'auth.dart' contains the loginUser function and other necessary imports.
import 'package:nairaverse/auth.dart';
import 'package:nairaverse/homepage.dart'; // Ensure this file exists and has HomePage class.
// Assuming 'signup_page.dart' exists and contains SignUpPage class.
import 'package:nairaverse/pages/auth/signup.dart'; 

void main() {
  runApp(MaterialApp(
    home: LoginForm(),
  ));
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      loginUser(emailController.text, passwordController.text)
          .then((value) {
        if (value) { // Assuming value is bool.
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Successful")));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePages())); // Corrected class name.
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Failed: Incorrect email or password")));
        }
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Failed: $error")));
      });
    }
  }

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
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Login'),
              ),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp())),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
