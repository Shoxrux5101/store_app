import 'package:flutter/material.dart';
import 'package:strore_app/features/sign_up/widgets/already_have_account.dart';
import 'package:strore_app/features/sign_up/widgets/social_section.dart';
import '../../sign_up/widgets/custom_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailValidation = ValueNotifier<FieldValidation>(const FieldValidation.initial());
  final passwordValidation = ValueNotifier<FieldValidation>(const FieldValidation.initial());

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    debugPrint('Email: ${emailController.text}');
    debugPrint('Password: ${passwordController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Login to your account",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 32)),
              const Text("It’s great to see you again.",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
              const SizedBox(height: 24),
              CustomTextFormField(
                text: 'Email',
                controller: emailController,
                hint: 'Enter your email address',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Invalid email';
                  }
                  return null;
                },
                validationNotifier: emailValidation,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                text: 'Password',
                controller: passwordController,
                hint: 'Enter your password',
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter password';
                  }
                  if (value.length < 6) {
                    return 'Password at least 6 chars';
                  }
                  return null;
                },
                validationNotifier: passwordValidation,
              ),
              const SizedBox(height: 24),
              AnimatedBuilder(
                animation: Listenable.merge([emailValidation, passwordValidation]),
                builder: (context, _) {
                  final allValid = emailValidation.value.status == ValidationStatus.valid &&
                      passwordValidation.value.status == ValidationStatus.valid;
                  return GestureDetector(
                    onTap: allValid ? _onLogin : null,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(19),
                        border: Border.all(color: Colors.black, width: 1),
                        color: allValid ? Colors.black : const Color(0xFFCCCCCC),
                      ),
                      child: Center(
                        child: Text("Login",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: allValid ? Colors.white : Colors.black54)),
                      ),
                    ),
                  );
                },
              ),
              const SocialSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: AlreadyHaveAccount(titleText: "Don’t have an account? ", actionText: "Join", onTap: (){}),
      ),
    );
  }
}
