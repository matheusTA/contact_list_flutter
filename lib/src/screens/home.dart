import 'dart:io';

import 'package:flutter/material.dart';
import 'package:phone_book_flutter/src/helpers/contact_helper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ContactHelper contactHelper = ContactHelper();
  List<Contact> contacts = List();

  @override
  void initState() {
    super.initState();
    setState(() {
      contactHelper.getAllContacts().then((resp) {
        contacts = resp;
      });
    });
  }

  Widget _contactsNotFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error,
            size: 100,
            color: Colors.grey[400],
          ),
          Text(
            "Nenhum contato",
            style: TextStyle(
                color: Colors.grey[400],
                fontSize: 25.0,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: contacts[index].img != null
                          ? FileImage(File(contacts[index].img))
                          : AssetImage("images/person.png")),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      contacts[index].img ?? "",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      contacts[index].email ?? "",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      contacts[index].phone ?? "",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contatos",
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: contacts.length > 0
          ? ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return _contactCard(context, index);
              })
          : _contactsNotFound(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.indigoAccent,
      ),
    );
  }
}
