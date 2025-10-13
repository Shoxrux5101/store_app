import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:store_app/core/routes/routes.dart';
import '../../../data/models/my_detail_model.dart';
import '../manager/my_detail_bloc.dart';
import '../manager/my_detail_event.dart';
import '../manager/my_detail_state.dart';
import '../widgets/date_field.dart';
import '../widgets/email_field.dart';
import '../widgets/form_label.dart';
import '../widgets/full_name_field.dart';
import '../widgets/gender_dropdown.dart';
import '../widgets/phone_field.dart';
import '../widgets/submit_button.dart';

class MyDetailsScreen extends StatefulWidget {
  MyDetailsScreen({Key? key}) : super(key: key);

  @override
  State<MyDetailsScreen> createState() => _MyDetailsScreenState();
}

class _MyDetailsScreenState extends State<MyDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _dateController;
  late TextEditingController _phoneController;
  String _selectedGender = 'Male';
  int _userId = 0;
  final List<String> _genders = ['Male', 'Female', 'Other'];

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _dateController = TextEditingController();
    _phoneController = TextEditingController();
    context.read<MyDetailBloc>().add(LoadMyDetail());
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _dateController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
  String _formatDateForUI(String backendDate) {
    try {
      if (backendDate.isEmpty) return '';
      final date = DateTime.parse(backendDate);
      return DateFormat('MM/dd/yyyy').format(date);
    } catch (e) {
      return backendDate;
    }
  }
  String _formatDateForBackend(String uiDate) {
    try {
      if (uiDate.isEmpty) return '';
      final date = DateFormat('MM/dd/yyyy').parse(uiDate);
      return DateFormat('yyyy-MM-dd').format(date);
    } catch (e) {
      return uiDate;
    }
  }
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String cleanPhone = _phoneController.text.replaceAll(RegExp(r'[^\d]'), '');
      final myDetail = MyDetail(
        id: _userId,
        fullName: _fullNameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: cleanPhone,
        gender: _selectedGender,
        birthDate: _formatDateForBackend(_dateController.text),
      );
      context.read<MyDetailBloc>().add(UpdateMyDetail(myDetail));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('My Details', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: [
          IconButton(icon: SvgPicture.asset("assets/icons/Bell.svg"), onPressed: () {context.push(Routes.notification);}),
        ],
      ),
      body: BlocConsumer<MyDetailBloc, MyDetailState>(
        listener: (context, state) {
          if (state is MyDetailUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Malumotlar muvaffaqiyatli yangilandi'), backgroundColor: Colors.green, duration: Duration(seconds: 2)));
          } else if (state is MyDetailError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Xatolik: ${state.message}'), backgroundColor: Colors.red, duration: Duration(seconds: 3)));
          }
        },
        builder: (context, state) {
          if (state is MyDetailLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is MyDetailLoaded || state is MyDetailUpdated) {
            final myDetail = state is MyDetailLoaded ? state.myDetail : (state as MyDetailUpdated).myDetail;
            if (_fullNameController.text.isEmpty && myDetail.fullName.isNotEmpty) {
              _userId = myDetail.id;
              _fullNameController.text = myDetail.fullName;
              _emailController.text = myDetail.email;
              _dateController.text = _formatDateForUI(myDetail.birthDate!);
              _phoneController.text = myDetail.phoneNumber!;
              _selectedGender = (myDetail.gender!.isNotEmpty ? myDetail.gender : 'Male')!;
            }
          }
          return SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabel(text: 'Full Name'),
                  SizedBox(height: 8),
                  FullNameField(controller: _fullNameController),
                  SizedBox(height: 20),
                  FormLabel(text: 'Email Address'),
                  SizedBox(height: 8),
                  EmailField(controller: _emailController),
                  SizedBox(height: 20),
                  FormLabel(text: 'Date of Birth'),
                  SizedBox(height: 8),
                  DateField(controller: _dateController),
                  SizedBox(height: 20),
                  FormLabel(text: 'Gender'),
                  SizedBox(height: 8),
                  GenderDropdown(
                    genders: _genders,
                    selectedGender: _selectedGender,
                    onChanged: (v) => setState(() => _selectedGender = v)),
                  SizedBox(height: 20),
                  FormLabel(text: 'Phone Number'),
                  SizedBox(height: 8),
                  PhoneField(controller: _phoneController),
                  SizedBox(height: 40),
                  SubmitButton(onPressed: _submitForm),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
