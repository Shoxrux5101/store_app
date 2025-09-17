import 'package:flutter/material.dart';

class VerifyCode extends StatefulWidget {
  final String email;
  const VerifyCode({super.key, required this.email});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  // 4 ta controller (OTP raqamlari uchun)
  final List<TextEditingController> controllers =
  List.generate(4, (_) => TextEditingController());

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _onVerify() {
    // barcha raqamlarni birlashtiramiz
    final code = controllers.map((c) => c.text).join();
    if (code.length < 4) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("4 raqam kiriting")));
      return;
    }

    // bu yerda API ga so'rov yuborishingiz mumkin:
    print("Email: ${widget.email}, Code: $code");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Tasdiqlash: $code, Email: ${widget.email}")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
        title: Text("Verify ${widget.email}"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Enter the 4-digit code",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  4,
                      (index) => SizedBox(
                    width: 60,
                    height: 60,
                    child: TextField(
                      controller: controllers[index],
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24),
                      decoration: InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onVerify,
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: const Text("Verify Code"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
