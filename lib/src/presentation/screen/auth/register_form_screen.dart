import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import 'widget/input_field_widget.dart';
import 'widget/select_gender_widget.dart';

class RegisterFormScreen extends StatefulWidget {
  const RegisterFormScreen({super.key});

  @override
  State<RegisterFormScreen> createState() => _RegisterFormScreenState();
}

class _RegisterFormScreenState extends State<RegisterFormScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();

  final _namaSekolahController = TextEditingController();
  final _genderController = TextEditingController();
  final _schoolLevelController = TextEditingController();
  final _schoolGradeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ///
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Yuk isi data diri'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              InputFieldWidget(
                name: 'Email',
                hintText: 'Email...',
                enabled: false,
                controller: TextEditingController(
                  text:
                      context.read<AuthBloc>().getCurrentSignedInEmail() ?? '',
                ),
              ),
              InputFieldWidget(
                name: 'Nama Lengkap',
                hintText: 'contoh: Lionel Messi',
                controller: _fullNameController,
              ),
              SelectGenderWidget(
                gender: '',
                onSelectGender: (value) {},
              ),
              DropdownButtonFormField(
                value: '10',
                items: const [
                  DropdownMenuItem(value: '10', child: Text('Kelas 10')),
                  DropdownMenuItem(value: '11', child: Text('Kelas 11')),
                  DropdownMenuItem(value: '12', child: Text('Kelas 12')),
                ],
                onChanged: (value) {},
              ),
              InputFieldWidget(
                name: 'Nama Sekolah',
                hintText: 'MAN 1 HSS',
                controller: _namaSekolahController,
              ),
              ElevatedButton(
                onPressed: () {
                  
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
