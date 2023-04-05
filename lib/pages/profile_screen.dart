import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:films/widget/logout.dart';
import 'package:flutter/material.dart';
import 'package:films/service/authFunctions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Profile extends StatefulWidget {
  final String userId;

  Profile({required this.userId});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Users? user;

  Future<Users> getUser(String userId) async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (documentSnapshot.exists) {
      // If the document exists, return a User object
      return Users.fromSnapshot(documentSnapshot);
    } else {
      // If the document does not exist, return null
      return Users(email: "", name: "", id: "");
    }
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    final user = await getUser(widget.userId);
    setState(() {
      this.user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 75, 71, 65),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(
          Icons.menu,
          color: Colors.black45,
        ),
        title: Text(
          'FCMovies'.toUpperCase(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'muli',
              ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/images/home.png'),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                //backgroundImage: AssetImage('assets/images/home.png'),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: user == null
                    ? CircularProgressIndicator()
                    : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                             AppLocalizations.of(context)!.name(user!.name),
                              style:
                                  Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'muli',
                                      ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)!.email(user!.email),
                              style:
                                  Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'muli',
                                      ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text(AppLocalizations.of(context)!.edit),
                              ),
                            ),
                          ],
                        ),
                    ),
              ),
              /*Text(
                user!.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'muli',
                ),
              ),*/
              const Expanded(child: SizedBox()),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                width: double.infinity,
                child: SignOutButton(),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Languages"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Users {
  String id;
  String name;
  String email;

  Users({
    required this.id,
    required this.name,
    required this.email,
  });

  factory Users.fromSnapshot(DocumentSnapshot? snapshot) {
    if (snapshot == null || snapshot.data() == null) {
      return Users(email: "email", name: "name", id: "id");
    }

    final data = snapshot.data()!
        as Map<String, dynamic>; // cast data to Map<String, dynamic>
    return Users(
      id: snapshot.id,
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
    );
  }
}
