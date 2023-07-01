import 'package:chessy/components/input_textfield.dart';
import 'package:chessy/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chessy/screen/otp_form_screen.dart';
import 'package:chessy/screen/login_screen.dart';
import 'package:quickalert/quickalert.dart';
import 'package:chessy/screen/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  final usernameTextControler = TextEditingController();
  final passwordTextControler = TextEditingController();
  final repasswordTextControler = TextEditingController();
  final emailTextControler = TextEditingController();
  final nameTextControler = TextEditingController();
  File avatarImage = File("");

  Future<void> _pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        avatarImage = File(pickedImage.path);
      });
    } else {
      // Nếu file ảnh chưa được chọn, bỏ qua bước cập nhật giá trị của biến avatarImage
      print('No image selected.');
    }
  }

  Future<String> uploadImageToImgur(File imageFile) async {
    String clientId =
        '3810d133742c5a6'; // Thay YOUR_CLIENT_ID bằng Client ID của ứng dụng Imgur của bạn

    // Đọc dữ liệu ảnh
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    // Tạo request body
    Map<String, dynamic> requestBody = {
      'image': base64Image,
    };

    // Tạo header
    Map<String, String> headers = {
      'Authorization': 'Client-ID $clientId',
    };

    // Gửi request POST để upload ảnh lên Imgur
    var response = await http.post(
      Uri.parse('https://api.imgur.com/3/image'),
      headers: headers,
      body: requestBody,
    );

    // Kiểm tra response và trả về link ảnh
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      String imageUrl = responseData['data']['link'];
      return imageUrl;
    } else {
      throw Exception('Upload failed');
    }
  }

  void handleSubmit(BuildContext context) async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Loading',
      text: 'Wait a minute',
    );
    // Lấy thông tin từ các TextField
    String username = usernameTextControler.text;
    String password = passwordTextControler.text;
    String email = emailTextControler.text;
    String name = nameTextControler.text;

    if (username.isEmpty || password.isEmpty || email.isEmpty || name.isEmpty) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Please enter all fields',
      );
      return;
    }
    // Nếu ảnh đại diện đã được chọn, upload ảnh lên Imgur và lấy link ảnh
    String avatarURL = '';
    if (avatarImage != File("")) {
      try {
        avatarURL = await uploadImageToImgur(avatarImage);
      } catch (e) {
        // Xử lý khi upload ảnh lỗi
        print('Error uploading image: $e');
      }
    }

    // Tạo request body
    Map<String, dynamic> requestBody = {
      'username': username,
      'password': password,
      'email': email,
      'name': name,
      'avatarURL': avatarURL,
    };

    // Gửi request POST để đăng ký tài khoản
    var response = await http.post(
      Uri.parse(
          'https://chessy-backend.onrender.com/api/v1/authenticate/register'),
      body: jsonEncode(requestBody),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    // Kiểm tra response và chuyển sang màn hình xác nhận OTP nếu thành công
    if (response.statusCode == 200) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: "Sign up success",
        onConfirmBtnTap: () => {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpVerificationScreen(
                        username: usernameTextControler.text,
                        password: passwordTextControler.text,
                        email: emailTextControler.text,
                      )),
              (Route<dynamic> route) => false)
        },
      );
    } else {
      // Xử lý khi đăng ký thất bại
      print('Error registering account: ${response.body}');
    }
  }

  @override
  void dispose() {
    usernameTextControler.dispose();
    passwordTextControler.dispose();
    repasswordTextControler.dispose();
    emailTextControler.dispose();
    nameTextControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
          ),
          title: const Text("Chessy")),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(bottom: 92),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('image/167.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "SIGN UP",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              if (avatarImage != File(""))
                CircleAvatar(
                  radius: 60,
                  child: ClipOval(
                    child: Image.file(
                      avatarImage,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: _pickImageFromGallery,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(110, 30),
                    backgroundColor: const Color(0xFFF9D8F4),
                    foregroundColor: const Color(0xFF811F86),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  child: const Text('Choose Avatar'),
                ),
              ),
              InputTextField("Username", usernameTextControler, false),
              InputTextField("Password", passwordTextControler, true),
              InputTextField(
                  "Re-Enter Password", repasswordTextControler, true),
              InputTextField("Email", emailTextControler, false),
              InputTextField("Name", nameTextControler, false),
              RoundedButton("Submit", () => handleSubmit(context)),
            ],
          ),
        ),
      ),
    );
  }
}
