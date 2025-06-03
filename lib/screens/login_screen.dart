import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/custom_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  bool isChecked = false;

  // Dummy data: list of objects (maps)
  final List<Map<String, String>> items = [
    {
      'title': 'Apple',
      'subtitle': 'A sweet red fruit',
      'imageUrl': 'https://dummyimage.com/150x150/ff0000/ffffff&text=Apple',
    },
    {
      'title': 'Banana',
      'subtitle': 'A long yellow fruit',
      'imageUrl': 'https://dummyimage.com/150x150/ff0000/ffffff&text=Apple',
    },
    {
      'title': 'Cherry',
      'subtitle': 'Small and red fruit',
      'imageUrl': 'https://dummyimage.com/150x150/ff0000/ffffff&text=Apple',
    },
  ];

  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final success = await AuthService.loginUser(
        _emailController.text,
        _passwordController.text,
      );
      for (var i = 0; i < 10; i++) {
        print('Selected prediction: $i');
      }
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? 'Login Successful!' : 'Login Failed'),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/AppIcon.png',
                  width: 190,
                  height: 157,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ),
                const SizedBox(height: 30),
                CustomInputField(
                  controller: _emailController,
                  label: "Email",
                  hintText: "Enter your email",
                  icon: Icons.email,
                  validator: (val) => val!.isEmpty ? 'Email is required' : null,
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  controller: _passwordController,
                  label: "Password",
                  hintText: "Enter your password",
                  icon: Icons.lock,
                  isPassword: true,
                  validator: (val) => val!.isEmpty ? 'Password is required' : null,
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('Forgot Password tapped');
                        // TODO: Navigate to forgot password screen
                      },
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                      print("isChecked: $isChecked");
                    });
                  },
                ),
                const Text('Accept Terms'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2.0,
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: 'RobotoMono',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                ),

                const SizedBox(height: 30),

                // List of Cards from dummy data
                Column(
                  children: items.map((item) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 18),
                      elevation: 3,
                      child: ListTile(
                        leading: Image.network(
                          item['imageUrl']!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(item['title']!),
                        subtitle: Text(item['subtitle']!),
                        onTap: () {
                          print('Tapped on ${item['title']}');
                        },
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 50), // Bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }
}
