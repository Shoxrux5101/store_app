import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/routes/routes.dart';
import '../../sign_up/managers/auth_view_model.dart';
import '../../sign_up/widgets/already_have_account.dart';
import '../../sign_up/widgets/custom_text_form_field.dart';
import '../../sign_up/widgets/social_section.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _secureStorage = const FlutterSecureStorage();

  final emailValidation = ValueNotifier<FieldValidation>(const FieldValidation.initial());
  final passwordValidation = ValueNotifier<FieldValidation>(const FieldValidation.initial());

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailValidation.dispose();
    passwordValidation.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (emailController.text.trim().isEmpty ||
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text.trim())) {
      emailValidation.value = FieldValidation.invalid("Invalid email");
      return;
    }

    if (passwordController.text.length < 6) {
      passwordValidation.value = FieldValidation.invalid("Password at least 6 chars");
      return;
    }

    final authVM = Provider.of<AuthViewModel>(context, listen: false);
    await authVM.login(emailController.text.trim(), passwordController.text);

    if (authVM.error == null && authVM.data != null) {
      final token = authVM.data['accessToken'] ?? authVM.data['token'];
      if (token != null) {
        await _secureStorage.write(key: 'token', value: token);
        await _secureStorage.write(key: 'login', value: emailController.text.trim());
        await _secureStorage.write(key: 'password', value: passwordController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login successful")),
        );

        context.go(Routes.homePage);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Token not received")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: ${authVM.error}")),
      );
    }
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
              const Text("It's great to see you again.",
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
              Consumer<AuthViewModel>(
                builder: (context, authVM, _) {
                  return AnimatedBuilder(
                    animation: Listenable.merge([emailValidation, passwordValidation]),
                    builder: (context, _) {
                      final allValid = emailValidation.value.status == ValidationStatus.valid &&
                          passwordValidation.value.status == ValidationStatus.valid;
                      return GestureDetector(
                        onTap: (allValid && !authVM.isLoading) ? _onLogin : null,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(19),
                            border: Border.all(color: Colors.black, width: 1),
                            color: (allValid && !authVM.isLoading) ? Colors.black : const Color(0xFFCCCCCC),
                          ),
                          child: Center(
                            child: authVM.isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : Text("Login",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: (allValid && !authVM.isLoading) ? Colors.white : Colors.black54)),
                          ),
                        ),
                      );
                    },
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
        child: AlreadyHaveAccount(
            titleText: "Don't have an account? ",
            actionText: "Join",
            onTap: () => context.go(Routes.signUp)
        ),
      ),
    );
  }
}