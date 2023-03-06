import 'package:flutter/material.dart';
import 'package:widgets/pages/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool mascara = true;
  TextEditingController emailController =
      new TextEditingController(text: "usuario@gmail.com");
  TextEditingController senhaController =
      new TextEditingController(text: "12345");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 6, 6, 6),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Expanded(child: Container()),
                    const Expanded(
                      flex: 5,
                      child: Icon(
                        Icons.person,
                        size: 150,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Ja tem cadastro?",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Faça seu login e make the change",
                  style: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 255, 255, 255)),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    height: 40,
                    // ignore: prefer_const_constructors
                    child: TextField(
                        controller: emailController,
                        onChanged: (value) {
                          //debugPrint(value);
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 159, 68, 191))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 159, 68, 191))),
                            hintText: "E-mail",
                            hintStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(Icons.email,
                                color: Color.fromARGB(255, 159, 68, 191))))),
                SizedBox(
                  height: 15,
                ),
                Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    height: 40,
                    alignment: Alignment.center,
                    child: TextField(
                        obscureText: mascara,
                        controller: senhaController,
                        onChanged: (value) {
                          //debugPrint(value);
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 159, 68, 191))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 159, 68, 191))),
                            hintText: "Senha",
                            hintStyle: TextStyle(color: Colors.white),
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  mascara = !mascara;
                                });
                              },
                              child: Icon(
                                  mascara
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                            prefixIcon: Icon(Icons.lock,
                                color: Color.fromARGB(255, 159, 68, 191))))),
                SizedBox(
                  height: 28,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          //debugPrint('email:${emailController.text}');
                          //debugPrint('senha:${senhaController.text}');
                          if (emailController.text.trim() ==
                                  "usuario@gmail.com" &&
                              senhaController.text.trim() == "12345") {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainPage()));

                            /*ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Login Efetuado com sucesso")));*/
                            //debugPrint("Login Efetuado com sucesso");
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Erro ao efeturar login")));
                            //debugPrint("Erro ao efetuar login");
                          }
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 159, 68, 191))),
                        child: Text(
                          "ENTRAR",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        )),
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  height: 30,
                  alignment: Alignment.center,
                  child: Text(
                    "Esqueci minha senha",
                    style: TextStyle(
                        color: Color.fromARGB(255, 212, 2, 82),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  height: 30,
                  alignment: Alignment.center,
                  child: Text(
                    "Criar conta",
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
