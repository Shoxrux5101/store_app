import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/routes/routes.dart';
import '../../sign_up/managers/auth_view_model.dart';
import '../../sign_up/widgets/custom_text_form_field.dart';

class ResetPassword extends StatefulWidget {
  final String email;
  final String otp;

  const ResetPassword({
    super.key,
    required this.email,
    required this.otp,
  });

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final passwordValidation = ValueNotifier<FieldValidation>(const FieldValidation.initial());
  final confirmPasswordValidation = ValueNotifier<FieldValidation>(const FieldValidation.initial());

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    passwordValidation.dispose();
    confirmPasswordValidation.dispose();
    super.dispose();
  }

  bool get allValid =>
      passwordValidation.value.status == ValidationStatus.valid &&
          confirmPasswordValidation.value.status == ValidationStatus.valid &&
          passwordController.text == confirmPasswordController.text;

  Future<void> _onResetPassword() async {
    if (passwordController.text.isEmpty) {
      passwordValidation.value = FieldValidation.invalid("Password required");
      return;
    }
    if (passwordController.text.length < 6) {
      passwordValidation.value = FieldValidation.invalid("Password at least 6 chars");
      return;
    }
    if (confirmPasswordController.text.isEmpty) {
      confirmPasswordValidation.value = FieldValidation.invalid("Confirm password required");
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      confirmPasswordValidation.value = FieldValidation.invalid("Passwords don't match");
      return;
    }

    final authVM = Provider.of<AuthViewModel>(context, listen: false);
    await authVM.resetPassword(widget.email, widget.otp, passwordController.text);

    if (authVM.error == null) {
      _showSuccessDialog();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${authVM.error}')),
      );
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Password Changed!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "You can now use your new password to login to your account.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.go(Routes.loginPage);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pop();
        context.go(Routes.homePage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Reset Password",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  "Set the new password for your account so you can login and access all the features.",
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
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
                const SizedBox(height: 16),
                CustomTextFormField(
                  text: 'Confirm Password',
                  controller: confirmPasswordController,
                  hint: 'Confirm your password',
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm password';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords don\'t match';
                    }
                    return null;
                  },
                  validationNotifier: confirmPasswordValidation,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Consumer<AuthViewModel>(
                builder: (context, authVM, _) {
                  return AnimatedBuilder(
                    animation: Listenable.merge([passwordValidation, confirmPasswordValidation]),
                    builder: (context, _) {
                      return GestureDetector(
                        onTap: (allValid && !authVM.isLoading) ? _onResetPassword : null,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(19),
                            border: Border.all(color: Colors.black, width: 1),
                            color: (allValid && !authVM.isLoading)
                                ? Colors.black
                                : const Color(0xFFCCCCCC),
                          ),
                          child: Center(
                            child: authVM.isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : Text(
                              "Reset Password",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: (allValid && !authVM.isLoading)
                                    ? Colors.white
                                    : Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}