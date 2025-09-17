import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:strore_app/core/routes/routes.dart';
import 'package:strore_app/features/forgot_password/pages/verify_code.dart';
import '../../sign_up/managers/auth_view_model.dart';
import '../../sign_up/widgets/custom_text_form_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  final emailValidation = ValueNotifier<FieldValidation>(const FieldValidation.initial());

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _onSendCode() async {
    final email = emailController.text.trim();
    if (email.isEmpty) return;

    final authVM = Provider.of<AuthViewModel>(context, listen: false);
    await authVM.sendOtp(email);

    if (authVM.error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kod $email ga yuborildi')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VerifyCode(email: email),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Xatolik: ${authVM.error}')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Forgot Password",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 32)),
                  const Text("Enter your email for the verification process. We will send 4 digits code to your email.",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),maxLines: 2,),
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
                ],
              ),
              const SizedBox(height: 24),
              AnimatedBuilder(
                animation: Listenable.merge([emailValidation,]),
                builder: (context, _) {
                  final allValid = emailValidation.value.status == ValidationStatus.valid;
                  return GestureDetector(
                    onTap: (){_onSendCode();},
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(19),
                        border: Border.all(color: Colors.black, width: 1),
                        color: allValid ? Colors.black : const Color(0xFFCCCCCC),
                      ),
                      child: Center(
                        child: Text("Send Code",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: allValid ? Colors.white : Colors.black54)),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
