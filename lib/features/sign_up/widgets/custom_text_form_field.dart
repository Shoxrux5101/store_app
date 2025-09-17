// lib/features/common/widgets/custom_text_form_field.dart
import 'package:flutter/material.dart';

enum ValidationStatus { initial, valid, invalid }

class FieldValidation {
  final ValidationStatus status;
  final String? message;
  const FieldValidation._(this.status, this.message);
  const FieldValidation.initial() : this._(ValidationStatus.initial, null);
  const FieldValidation.valid() : this._(ValidationStatus.valid, null);
  FieldValidation.invalid(String message)
      : this._(ValidationStatus.invalid, message);
}

class CustomTextFormField extends StatefulWidget {
  final String text;
  final TextEditingController controller;
  final String hint;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final ValueNotifier<FieldValidation>? validationNotifier;

  const CustomTextFormField({
    super.key,
    required this.text,
    required this.controller,
    required this.hint,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.validationNotifier,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isValid = true;
  bool _shouldShowValidation = false;
  bool _obscureText = true;
  String? _errorMessage;
  VoidCallback? _notifierListener;

  @override
  void initState() {
    super.initState();
    final initial =
        widget.validationNotifier?.value ?? const FieldValidation.initial();
    _applyValidation(initial, notify: false);

    if (widget.validationNotifier != null) {
      _notifierListener = () {
        _applyValidation(widget.validationNotifier!.value);
      };
      widget.validationNotifier!.addListener(_notifierListener!);
    }
  }

  void _applyValidation(FieldValidation val, {bool notify = true}) {
    setState(() {
      _shouldShowValidation = val.status != ValidationStatus.initial;
      _isValid = val.status == ValidationStatus.valid;
      _errorMessage = val.message;
    });
  }

  void _validateField(String value) {
    if (widget.validator != null) {
      final res = widget.validator!.call(value);
      final validation =
      res == null ? FieldValidation.valid() : FieldValidation.invalid(res);
      _applyValidation(validation);
      widget.validationNotifier?.value = validation;
    } else {
      if (value.isNotEmpty) {
        final v = FieldValidation.valid();
        _applyValidation(v);
        widget.validationNotifier?.value = v;
      }
    }
  }

  @override
  void dispose() {
    if (widget.validationNotifier != null && _notifierListener != null) {
      widget.validationNotifier!.removeListener(_notifierListener!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.text,
            style: const TextStyle(
                fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black)),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          onChanged: _validateField,
          onFieldSubmitted: _validateField,
          onEditingComplete: () {
            _validateField(widget.controller.text);
          },
          decoration: InputDecoration(
            hintText: widget.hint,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: !_shouldShowValidation
                    ? Colors.grey[300]!
                    : _isValid
                    ? Colors.green
                    : Colors.red,
                width: _shouldShowValidation ? 2 : 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: !_shouldShowValidation
                    ? Colors.blue
                    : _isValid
                    ? Colors.green
                    : Colors.red,
                width: 2,
              ),
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
              icon: Icon(
                _obscureText
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.grey[600],
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )
                : (_shouldShowValidation
                ? (_isValid
                ? const Icon(Icons.check_circle, color: Colors.green)
                : const Icon(Icons.error, color: Colors.red))
                : null),
          ),
        ),
        if (_shouldShowValidation && !_isValid && _errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 4),
            child: Row(
              children: [
                const Icon(Icons.error_outline,
                    color: Colors.red, size: 16),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(_errorMessage!,
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
