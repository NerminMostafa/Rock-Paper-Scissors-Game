import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String username = 'username';
  String password = '10';
  bool _obscureText = true;
  bool login = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getData();
    if(login)
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen(value: username)));
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 100,top: 100),
                  child: Text('Sign In',style:TextStyle(
                    color: Color(0xd3441a75),
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'font2',
                  ),
                  ),
                ),
                Padding(
                  padding: const  EdgeInsets.only(bottom: 25),
                  child: TextFormField(
                    validator: (input){
                      if(input == null || input.isEmpty){
                        return('Please enter your username!');
                      }
                      return null;
                    },
                    onSaved: (value){
                      username = value.toString();
                    },
                    decoration: const InputDecoration(
                      labelText: 'Enter your username',
                      fillColor: Colors.transparent,
                      filled: true,
                    ),
                    //autofillHints: [AutofillHints.username.toString()],
                  ),
                ),

                TextFormField(
                  validator: (input){
                    if(input == null || input.isEmpty){
                      return('Please enter your password!');
                    }
                    return null;
                  },
                  onSaved: (value){
                    password = value.toString();
                  },
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(onTap: (){
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                      child: Icon(_obscureText?Icons.visibility : Icons.visibility_off),
                    ),
                    hintText: 'Enter your password',
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                  //autofillHints: [AutofillHints.password.toString()],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Text('Forgot your password?',style: TextStyle(
                    color: Colors.blueGrey,
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                      onPressed: (){
                        _saveData();
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen(value: username)));
                          login = true;
                        }
                      },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      fixedSize: const Size(110,40),
                      primary: const Color(0xd3441a75),
                    ),
                    child: const Text('Sign In'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Expanded(
                      child: Divider(
                        indent: 20.0,
                        endIndent: 10.0,
                        thickness: 1,
                      ),
                    ),
                    Text(
                      "OR",
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                    Expanded(
                      child: Divider(
                        indent: 10.0,
                        endIndent: 20.0,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: ElevatedButton(
                    onPressed: (){
                      _saveData();
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen(value: username)));
                        login = true;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      fixedSize: const Size(250,40),
                      primary: const Color(0xE4213681)
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.facebook,),
                        Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Text('Sign in with facebook',),
                        )
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top:150),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                    Text('Don\'t have account?'),
                    Text(' Sign up',style: TextStyle(
                      color: Colors.blueGrey
                    ),),
                  ],),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      username = sharedPreferences.getString('username')!;
      password = sharedPreferences.getString('password')!;
    });
  }

  void _saveData() async {
    _formKey.currentState?.save();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('username', username);
    sharedPreferences.setString('password', password);

    setState(() {

    });
  }
}
