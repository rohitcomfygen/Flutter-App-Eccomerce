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
                  width: 190, // set desired width
                  height: 157, // set desired height
                  fit: BoxFit
                      .contain, // scale the image to fit within width & height while keeping aspect ratio
                  alignment:
                      Alignment.center, // position inside the widget bounds
                ),

                const SizedBox(height: 30),
                CustomInputField(
                  controller: _emailController,
                  label: "Email",
                  hintText: "Enter your email",
                  // icon: Icons.email,
                  icon: Icons.email,
                  // isPassword: true,
                  validator: (val) => val!.isEmpty ? 'Email is required' : null,

                    
                
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  controller: _passwordController,
                  label: "Password",
                  hintText: "Enter your password",
                  icon: Icons.lock,
                  isPassword: true,
                  validator: (val) =>
                      val!.isEmpty ? 'Password is required' : null,
                ),
               
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Your onPress action here
                        print('Forgot Password tapped');
                        // For example, navigate to forgot password screen
                      },
                      child: Text(
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
                      print(
                        "isChecked: $isChecked",
                      ); // 👈 Logs value to console
                    });
                  },
                ),
                Text('Accept Terms'),

                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
