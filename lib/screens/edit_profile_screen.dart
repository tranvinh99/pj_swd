import 'dart:io';

import 'package:f_home_mo/provider/user.dart';
import 'package:f_home_mo/repostitory/user_repository.dart';
import 'package:f_home_mo/utils/storage_methods.dart';
import 'package:f_home_mo/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel userModel;
  const EditProfileScreen({
    super.key,
    required this.userModel,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  PickedFile? _imageFile;
  String? imageUrl;

  bool isLoading = false;

  void takePhoto(ImageSource source) async {
    final _pickedFile = await _picker.getImage(source: source);
    if (_pickedFile != null) {
      setState(() {
        _imageFile = _pickedFile;
        uploadImage(_imageFile!);
      });
    }
  }

  // upload _imageFile to api
  void uploadImage(PickedFile _imageFile) async {
    final _image = File(_imageFile.path);
    Uint8List avatar = await _image.readAsBytes();
    imageUrl = await StorageMethods().uploadImageToStorage(
      'profilePics',
      avatar,
      false,
      widget.userModel.id,
    );
    print('url anh: $imageUrl');

    //await ProfilePro().updateProfilePictureAPIProvider(imageUrl);
    //context.read<ProfileProvider>().setProfilePicture(imageUrl);
  }

  @override
  void initState() {
    super.initState();
    fullnameController.text = widget.userModel.fullname;
    emailController.text = widget.userModel.email;
    phoneController.text = widget.userModel.phone;
  }

  @override
  void dispose() {
    super.dispose();
    fullnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
  }

  void updateProfile() async {
    UserModel user = UserModel(
      id: widget.userModel.id,
      email: emailController.text,
      phone: phoneController.text,
      fullname: fullnameController.text,
      imgUrl: imageUrl!,
      roleName: widget.userModel.roleName,
      status: widget.userModel.status,
    );

    setState(() {
      isLoading = true;
    });

    await UserRepository().updateUser(user);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông tin cá nhân',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => takePhoto(ImageSource.gallery),
              child: Align(
                alignment: Alignment.center,
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(widget.userModel.imgUrl),
                    ),
                    const Positioned(
                      bottom: 0,
                      child: Icon(
                        FontAwesomeIcons.camera,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(
                left: 15,
              ),
              child: Text(
                'Full name',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFieldInput(
                hintText: 'Full name',
                controller: fullnameController,
              ),
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.only(
                left: 15,
              ),
              child: Text(
                'Email',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFieldInput(
                hintText: 'Email',
                controller: emailController,
              ),
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.only(
                left: 15,
              ),
              child: Text(
                'Phone number',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFieldInput(
                hintText: 'Phone number',
                controller: phoneController,
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: updateProfile,
                      child: const Text(
                        'Chỉnh sửa',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
