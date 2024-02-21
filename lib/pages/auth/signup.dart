import 'package:flutter/material.dart';
import 'package:nairaverse/auth.dart';
import 'package:nairaverse/main.dart';
import 'package:nairaverse/pages/auth/login.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController dobController = TextEditingController();

    void _submit() {
      String username = usernameController.text;
      String email = emailController.text;
      String password = passwordController.text;
      String dob = dobController.text;

      print('Username: $username');
      print('Email: $email');
      print('Password: $password');
      print('Date of Birth: $dob');
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Create your profile",
                  style: TextStyle(fontSize: 32),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    createUser( usernameController.text, emailController.text, passwordController.text).
                    then((value){
                      if(value=="success"){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content : Text("Account Created")));
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginForm()));
                      } else{
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content : Text(value)));
                      }
                    });
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
