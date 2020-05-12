import 'dart:io';

import 'package:flutter/material.dart';
import 'package:phone_book_flutter/src/helpers/contact_helper.dart';

class ContactScrenn extends StatefulWidget {
  final Contact contact;

  ContactScrenn({this.contact});

  @override
  _ContactScrennState createState() => _ContactScrennState();
}

class _ContactScrennState extends State<ContactScrenn> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  Contact _editedContact;
  bool _userEdited = false;

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact.toMap());

      _nameController.text = _editedContact.name;
      _emailController.text = _editedContact.email;
      _phoneController.text = _editedContact.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _editedContact.name ?? "Novo Contato",
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 140.0,
                height: 140.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: _editedContact.img != null
                          ? FileImage(File(_editedContact.img))
                          : AssetImage("images/person.png")),
                ),
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Nome"),
              onChanged: (text) {
                _userEdited = true;
                setState(() {
                  if (text == "") {
                    _editedContact.name = "Nova Contato";
                  } else {
                    _editedContact.name = text;
                  }
                });
              },
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "E-mail"),
              keyboardType: TextInputType.emailAddress,
              onChanged: (text) {
                _userEdited = true;
                _editedContact.email = text;
              },
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Telefone"),
              keyboardType: TextInputType.phone,
              onChanged: (text) {
                _userEdited = true;
                _editedContact.phone = text;
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.save),
        backgroundColor: Colors.indigoAccent,
      ),
    );
  }
}
