import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:learn_management_system/config/common/reusable_text.dart';
import 'package:learn_management_system/features/auth/domain/entity/auth_entity.dart';
import 'package:learn_management_system/features/profile/presentation/view_model/profile_view_model.dart';

class EditProfileView extends ConsumerStatefulWidget {
  const EditProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  final _gap = const SizedBox(
    height: 15,
  );
  final _fullNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _imageController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final result = await ref.watch(profileViewModelProvider);
      final profile = result.users!.first;
      _userNameController.text = profile.userName ?? '';
      _fullNameController.text = profile.fullName ?? '';
      _emailController.text = profile.email ?? '';
      _phoneNumberController.text = profile.phoneNumber ?? '';
      _passwordController.text = profile.password ?? '';
      _imageController.text = profile.image ?? '';
    });
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _imageController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileViewModelProvider);
    final profile = profileState.users!.first;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kButton,
        title: const ReusableText(
            text: 'Edit Profile',
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: kLight),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(kLight.value),
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _gap,
              Center(
                child: CircleAvatar(
                  // backgroundColor: Colors.transparent,
                  radius: 60,
                  backgroundImage:
                      profile.image != null && profile.image!.isNotEmpty
                          ? NetworkImage(profile.image!)
                          : AssetImage('assets/images/login_icon.png'),
                ),
              ),
              _gap,
              _gap,
              _gap,
              _gap,
              const Text('UserName'),
              Row(
                children: [
                  const Icon(
                      Icons.supervised_user_circle_rounded), // Prefix Icon
                  const VerticalDivider(
                    thickness: 1,
                    color: kDark,
                  ), // Vertical Divider
                  Expanded(
                    child: TextFormField(
                      controller: _userNameController,
                      decoration: const InputDecoration(
                          // hintText: 'Please Enter your Full Name',
                          ),
                    ),
                  ),
                ],
              ),
              _gap,
              const Text('Full Name'),
              Row(
                children: [
                  const Icon(
                      Icons.supervised_user_circle_rounded), // Prefix Icon
                  const VerticalDivider(
                    thickness: 1,
                    color: kDark,
                  ), // Vertical Divider
                  Expanded(
                    child: TextFormField(
                      controller: _fullNameController,
                      decoration: const InputDecoration(
                          // hintText: 'Please Enter your Full Name',
                          ),
                    ),
                  ),
                ],
              ),
              _gap,
              const Text('Email'),
              Row(
                children: [
                  const Icon(Icons.email), // Prefix Icon
                  const VerticalDivider(
                    thickness: 1,
                    color: kDark,
                  ), // Vertical Divider
                  Expanded(
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          // hintText: 'Please Enter your Full Name',
                          ),
                    ),
                  ),
                ],
              ),
              _gap,
              const Text('Phone Number'),
              Row(
                children: [
                  const Icon(Icons.phone), // Prefix Icon
                  const VerticalDivider(
                    thickness: 1,
                    color: kDark,
                  ), // Vertical Divider
                  Expanded(
                    child: TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          // hintText: 'Please Enter your Full Name',
                          ),
                    ),
                  ),
                ],
              ),
              _gap,
              _gap,
              _gap,
              _gap,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ref
                            .read(profileViewModelProvider.notifier)
                            .resetState();
                      },
                      child: ReusableText(
                          text: 'Cancel',
                          fontSize: 15,
                          fontWeight: FontWeight.w100,
                          color: Color(kButton.value))),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(120, 40),
                          backgroundColor: Color(kButton.value)),
                      onPressed: () {
                        final authEntity = AuthEntity().copyWith(
                          fullName: _fullNameController.text.trim(),
                          userName: _userNameController.text.trim(),
                          phoneNumber: _phoneNumberController.text.trim(),
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim().isNotEmpty
                              ? _passwordController.text.trim()
                              : null,
                          image: _imageController.text.trim(),
                        );
                        ref
                            .read(profileViewModelProvider.notifier)
                            .updateProfile(authEntity, context);
                      },
                      child: ReusableText(
                          text: 'Save',
                          fontSize: 15,
                          fontWeight: FontWeight.w100,
                          color: Color(kLight.value)))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
