import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Functon/functios.dart';
import 'componentes/textfield.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController nome = TextEditingController();
  final TextEditingController idade = TextEditingController();
  final TextEditingController senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<bool> Cadastrar() async {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email.text, password: senha.text);
        return true;
      } catch (e) {
        return false;
      }
    }

    final media = MediaQuery.of(context).size;
    return Scaffold(
        body: Form(
            key: _formKey,
            child: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "CADASTRO ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 25),
                      ),
                    ),
                    CustomTextField(
                      nometextedintcontroler: nome,
                      teclado: TextInputType.name,
                      label: "nome",
                      icon: Icons.person,
                    ),
                    CustomTextField(
                      nometextedintcontroler: idade,
                      teclado: TextInputType.number,
                      label: "idade",
                      osbscure: false,
                      icon: Icons.person_pin,
                    ),
                    CustomTextField(
                      nometextedintcontroler: email,
                      teclado: TextInputType.emailAddress,
                      label: "email",
                      osbscure: false,
                      icon: Icons.email,
                    ),
                    CustomTextField(
                      nometextedintcontroler: senha,
                      teclado: TextInputType.emailAddress,
                      label: "senha",
                      osbscure: true,
                      icon: Icons.password,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(10),
                              textStyle: const TextStyle(fontSize: 22)),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                            bool provider = await  Cadastrar();
                              if (provider) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("cadastro realizado"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("fechar"))
                                        ],
                                      );
                                    });
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text(
                                            "erro ao criar o usuario"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("fechar"))
                                        ],
                                      );
                                    });
                              }
                            }
                          },
                          child: const Text("Cadastrar"),
                        ),
                      ),
                    ),
                    //voltar usuario
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(10),
                              textStyle: const TextStyle(fontSize: 22)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Voltar"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}