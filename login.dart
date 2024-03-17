import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Mylogin extends StatefulWidget {
  const Mylogin({Key? key}) : super(key: key);

  @override
  State<Mylogin> createState() => _MyloginState();
}

class _MyloginState extends State<Mylogin> {
  _MyloginState(){
    _selectedVal=Usertypelist[0];
  }
  final _formKey = GlobalKey<FormState>();
  //editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final Usertypelist = [ "Student" , "Faculty"];
  String? _selectedVal = "";

 signIn() async{
   await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
}
  @override
  Widget build(BuildContext context) {
    final emailfields = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      // validator: (),
      onSaved: (value){
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );
    final passwordlfields = TextFormField(
      obscureText: true,
      autofocus: false,
      controller: passwordController,
      // validator: (),
      onSaved: (value){
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        // height: 25,
        onPressed: (()=>signIn()),
        child: Text("Login",textAlign: TextAlign.center,style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back,color: Colors.black,size: 28,)),
      ),
      body: Center(
        child: SingleChildScrollView(child:Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 200,width:MediaQuery.of(context).size.width/1.2,
                    child: Image.asset("assets/images/logo.png"), ),
                  SizedBox(height: 45,),
                  emailfields,
                  SizedBox(height: 25,),
                  passwordlfields,
                  SizedBox(height: 25,),
                  Container(
                    decoration: BoxDecoration(),
                    // child: DropdownButton(
                    //   value: _selectedVal,
                    //   onChanged: (val){
                    //   setState(() {
                    //     _selectedVal = val as String;
                    //   });
                    // } , hint: Text('Select Usertype'),items: Usertypelist.map((e) => DropdownMenuItem(child: Text(e),value: e,)).toList(),
                  //  ),
                    child: DropdownButtonFormField(
                      value: _selectedVal,
                      onChanged: (val){
                        setState(() {
                          _selectedVal = val as String;
                        });
                      } , hint: Text('Select Usertype'),items: Usertypelist.map((e) => DropdownMenuItem(child: Text(e),value: e,)).toList(),
                           icon: const Icon(Icons.arrow_drop_down_circle_rounded,color: Colors.redAccent,),
                      decoration: InputDecoration(

                        labelText: "Select Usertype",
                        border: OutlineInputBorder()
                      ),
                    ),

                  ),

                  SizedBox(height: 25,),
                  loginButton ,
                  SizedBox(height:10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account ?"),
                      TextButton(onPressed: (){
                        Navigator.pushNamed(context, 'register');
                      }, child: Text('SignUp',style:
                      TextStyle(color: Colors.redAccent,fontSize: 15,fontWeight: FontWeight.w600),),)
                    ],
                  )

                ],
              ),
            ),
          ),
        ),),
      ),
    );
  }
}
