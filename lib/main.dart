import 'package:flutter/material.dart';
import 'package:uc_silver_gold_bali/controller/controller_form.dart';
import 'package:uc_silver_gold_bali/model/form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UC Survey',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'UC Silver Gold'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final feedbackController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      FormFeedback formFeedback = FormFeedback(
        nama: namaController.text,
        email: emailController.text,
        feedback: feedbackController.text,
      );

      // Tampilkan snackbar awal
      _showSnackbar("Menyimpan Feedback...");

      FormController formController = FormController((String response) {
        debugPrint("Response dari Google Script: $response");
        if (response == FormController.statusSuccess) {
          _showSnackbar("Feedback Berhasil Dikirim");
          _formKey.currentState!.reset(); // Reset form jika berhasil
        } else {
          _showSnackbar("Feedback Gagal Dikirim");
        }
      });

      formController.submitForm(formFeedback);
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Your Name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains("@")) {
                    return 'Enter a valid Email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: feedbackController,
                decoration: const InputDecoration(labelText: 'Feedback'),
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Your Feedback';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: _submitForm,
                child: const Text("Submit Feedback"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
