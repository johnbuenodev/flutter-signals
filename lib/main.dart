import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FormHomePage(),
    );
  }
}

class FormHomePage extends StatefulWidget {
  const FormHomePage({super.key});

  @override
  State<FormHomePage> createState() => _FormHomePageState();
}

class _FormHomePageState extends State<FormHomePage> {
  final email = signal('');
  final pass = signal('');

  late final isValid = computed(() => email().isNotEmpty && pass().isNotEmpty);

  final passError = signal<String?>(null);

  validateForm() {
    if(pass().length < 6) {
      passError.value = "Senha precisa de 6 caracteres";
      return;
    } 
    if(pass().length > 6) {
      passError.value = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Form com Signals"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: TextField(
                onChanged: email.set,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Email'),
                ),
              ),
            ),
            const SizedBox(height: 24,),
            Flexible(
              child: TextField(
                onChanged: pass.set,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Password'),
                  errorText: passError.watch(context),
                ),
              ),
            ),
            const SizedBox(height: 40,),
            Flexible(
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 60,
                child: FilledButton(
                  onPressed: isValid.watch(context) ? validateForm : null,
                  child: const Text('Entrar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
