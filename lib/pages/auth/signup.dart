import 'package:flutter/material.dart';
import 'package:nairaverse/auth.dart';
import 'package:nairaverse/pages/auth/login.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController dobController = TextEditingController();

    void submit() {
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
                const Text(
                  "Create your profile",
                  style: TextStyle(fontSize: 32),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    createUser( usernameController.text, emailController.text, passwordController.text).
                    then((value){
                      if(value=="success"){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content : Text("Account Created")));
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginForm()));
                      } else{
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content : Text(value)));
                      }
                    });
                  },
                  child: const Text('Submit'),
                ),
                GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginForm())),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Log In",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
