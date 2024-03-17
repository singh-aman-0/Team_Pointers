import 'package:attendance/wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Myregister extends StatefulWidget {
  const Myregister({super.key});

  @override
  State<Myregister> createState() => _MyregisterState();
}

class _MyregisterState extends State<Myregister> {
  @override
  final _formkey = GlobalKey<FormState>();
  final NameEditingController = new TextEditingController();
  final EmailEditingController = new TextEditingController();
  final PhoneEditingController = new TextEditingController();
  final PasswordEditingController = new TextEditingController();
  final EnrollmentEditingController = new TextEditingController();

 Future signup() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: EmailEditingController.text, password: PasswordEditingController.text);
    Get.offAll(Wrapper());
    
    adduserdetails(NameEditingController.text, EmailEditingController.text, int.parse(PhoneEditingController.text), EnrollmentEditingController.text);
  }
 Future adduserdetails(String name , String email , int phone , String enrollment) async {
    await FirebaseFirestore.instance.collection('users').add(({
      'Name':name,
      'Email': email,
      'PhoneNo.': phone,
      'enrollment' : enrollment,

    }));

  }

  Widget build(BuildContext context) {
    final Namefields = TextFormField(
      autofocus: false,
      controller: NameEditingController,
      keyboardType: TextInputType.name,
      // validator: (),
      onSaved: (value){
        NameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Full Name",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );
    final Enrollmentfields = TextFormField(
      autofocus: false,
      controller: EnrollmentEditingController,
      keyboardType: TextInputType.text,
      // validator: (),
      onSaved: (value){
        EmailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.engineering_sharp),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enrollment",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );
    final Emailfields = TextFormField(
      autofocus: false,
      controller: EmailEditingController,
      keyboardType: TextInputType.emailAddress,
      // validator: (),
      onSaved: (value){
        EmailEditingController.text = value!;
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
    final Phonefields = TextFormField(
      autofocus: false,
      controller: PhoneEditingController,
      keyboardType: TextInputType.number,
      // validator: (),
      onSaved: (value){
        NameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Mobile Number",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );
    final passwordlfields = TextFormField(
      obscureText: true,
      autofocus: false,
      controller: PasswordEditingController,
      // validator: (),
      onSaved: (value){
        PasswordEditingController.text = value!;
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
    final RegisterButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        // height: 25,
        onPressed: (()=>signup()),
        child: Text("Register",textAlign: TextAlign.center,style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back,color: Colors.black,size: 28,)),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(child:Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 150,width:MediaQuery.of(context).size.width/1.2,
                    child: Image.asset("assets/images/logo2.jpg"), ),
                  SizedBox(height: 45,),
                  Namefields,
                  SizedBox(height: 25,),
                  Emailfields,
                  SizedBox(height: 25,),
                  Enrollmentfields,
                  SizedBox(height: 25,),
                  Phonefields,
                  SizedBox(height: 25,),
                  passwordlfields,
                  SizedBox(height: 25,),
                  RegisterButton,
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Already have an account ?"),
                      TextButton(onPressed: (){
                        Navigator.pushNamed(context, 'login');
                      }, child: Text('Login',style:
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
