import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:strore_app/features/sign_up/widgets/already_have_account.dart';
import 'package:strore_app/features/sign_up/widgets/custom_text_form_field.dart';
import 'package:strore_app/data/models/user_model.dart';
import '../../../core/routes/routes.dart';
import '../managers/auth_view_model.dart';
import '../widgets/social_section.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final ValueNotifier<FieldValidation> nameValidation =
  ValueNotifier(const FieldValidation.initial());
  final ValueNotifier<FieldValidation> emailValidation =
  ValueNotifier(const FieldValidation.initial());
  final ValueNotifier<FieldValidation> passwordValidation =
  ValueNotifier(const FieldValidation.initial());

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameValidation.dispose();
    emailValidation.dispose();
    passwordValidation.dispose();
    super.dispose();
  }

  bool get allValid =>
      nameValidation.value.status == ValidationStatus.valid &&
          emailValidation.value.status == ValidationStatus.valid &&
          passwordValidation.value.status == ValidationStatus.valid;

  Future<void> _onRegister() async {
    if (fullNameController.text.trim().isEmpty) {
      nameValidation.value = FieldValidation.invalid("Full name required");
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
        .hasMatch(emailController.text.trim())) {
      emailValidation.value = FieldValidation.invalid("Invalid email");
    }
    if (passwordController.text.length < 6) {
      passwordValidation.value = FieldValidation.invalid("Min 6 chars");
    }

    if (!allValid) {
      return;
    }

    final authVM = Provider.of<AuthViewModel>(context, listen: false);
    final user = UserModel(
      fullName: fullNameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    debugPrint("Register payload: ${user.toJson()}");

    await authVM.register(user);

    if (authVM.error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${authVM.error}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Create an account",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 32)),
              const Text("Let's create your account",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
              const SizedBox(height: 24),
              CustomTextFormField(
                text: "Full Name",
                controller: fullNameController,
                hint: "Enter your full name",
                validationNotifier: nameValidation,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return "Full name required";
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                text: "Email",
                controller: emailController,
                hint: "Enter your email address",
                validationNotifier: emailValidation,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return "Email required";
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(val)) {
                    return "Invalid email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                text: "Password",
                controller: passwordController,
                hint: "Enter your password",
                isPassword: true,
                validationNotifier: passwordValidation,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Password required";
                  if (val.length < 6) return "Min 6 chars";
                  return null;
                },
              ),
              const SizedBox(height: 12),
              const Text(
                "By signing up you agree to our Terms, Privacy Policy, and Cookie Use",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 24),
              AnimatedBuilder(
                animation: Listenable.merge([
                  nameValidation,
                  emailValidation,
                  passwordValidation,
                ]),
                builder: (context, _) {
                  final isActive = allValid;
                  return GestureDetector(
                    onTap: isActive ? _onRegister : null,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(19),
                        border: Border.all(color: Colors.black, width: 1),
                        color: isActive ? Colors.black : const Color(0xFFCCCCCC),
                      ),
                      child: Center(
                        child: Text(
                          "Create an Account",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: isActive ? Colors.white : Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              const SocialSection(),
              const SizedBox(height: 30),
              AlreadyHaveAccount(titleText: "Already have an account? ", actionText: "Log In", onTap: (){context.push(Routes.loginPage);}),
            ],
          ),
        ),
      ),
    );
  }
}
