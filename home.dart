import 'package:attendance/blank.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();

}

class _HomepageState extends State<Homepage> {
  final user = FirebaseAuth.instance.currentUser;


  List<String> docsIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance.collection('users').get().then((snapshot) => snapshot.docs.forEach((document) {
      print(document.reference);
      docsIDs.add(document.reference.id);
    }));
  }
  void initState(){
    getDocId();
    super.initState();
  }
  signout()async
  {
    await FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (()=>signout()) ,),
        title: Text('${user!.email}'),
        backgroundColor: Colors.transparent,
        elevation: 0,

      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 40),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text('Hello Student!', style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white
                  )),
                  subtitle: Text('Welcome Back', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white54
                  )),
                  trailing: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/mypic.jpg'),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(200)
                  )
              ),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  itemDashboard('Books', CupertinoIcons.book_circle, Colors.deepOrange),
                  itemDashboard('Analytics', CupertinoIcons.graph_circle, Colors.green),
                  itemDashboard('Pay Fees', CupertinoIcons.money_dollar, Colors.purple),
                  itemDashboard('Bus Route', CupertinoIcons.bus, Colors.brown),
                  itemDashboard('Time table', CupertinoIcons.time, Colors.indigo),
                  itemDashboard('Upload', CupertinoIcons.add_circled, Colors.teal),
                  itemDashboard('About', CupertinoIcons.question_circle, Colors.blue),
                  itemDashboard('Mail', CupertinoIcons.mail, Colors.pinkAccent),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  itemDashboard(String title, IconData iconData, Color background) => Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 5),
              color: Theme.of(context).primaryColor.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 5
          )
        ]
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
            ),
            child: IconButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SecondRoute()),
              );
            }, icon: Icon(iconData), color: Colors.white,)
        ),
        const SizedBox(height: 8),
        Text(title.toUpperCase(), style: Theme.of(context).textTheme.titleMedium)
      ],
    ),

  );
}