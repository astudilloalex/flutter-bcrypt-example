import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController hashController = TextEditingController();

  StringBuffer hashedPassword = StringBuffer();
  bool correctPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextFormField(
            controller: passwordController,
          ),
          ElevatedButton(
            onPressed: () => setState(() {
              hashedPassword.clear();
              hashedPassword.write(BCrypt.hashpw(
                passwordController.text,
                BCrypt.gensalt(),
              ));
            }),
            child: const Text('Hash Password'),
          ),
          SelectableText(
            hashedPassword.toString(),
            style: const TextStyle(color: Colors.blueAccent),
          ),
          TextFormField(
            controller: hashController,
            minLines: 1,
            maxLines: 5,
          ),
          ElevatedButton(
            onPressed: () => setState(() {
              correctPassword = BCrypt.checkpw(
                passwordController.text,
                hashController.text,
              );
            }),
            child: const Text('Verify password'),
          ),
          Text('Correct: $correctPassword'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    hashController.dispose();
    super.dispose();
  }
}
