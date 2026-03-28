import 'dart:async';

//import 'package:logger/logger.dart';
import 'package:path/path.dart' as p;

//import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart'
    as path_provider
    show getApplicationDocumentsDirectory;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:flutter/foundation.dart';

void someFunction() {}

File? _imageFile;

class ProfileScreen extends StatefulWidget {
  final String name;
  const ProfileScreen({super.key, required this.name});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DateTime? _selectedDate;

  TextEditingController textEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();

  @override
  void initState() {
    getSavedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.amber ,
        toolbarHeight: 50,
        leadingWidth: 90,
        title: Text(
          "profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        backgroundColor: Colors.amber,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.dark_mode))],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : AssetImage('assets/images/profile.png')
                            as ImageProvider,
                  child: Icon(Icons.camera_alt_outlined),
                ),
              ),
              Text(widget.name),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 50, width: 20),
                    TextField(
                      controller: nameEditingController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: 'Enter your name',

                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 50, width: 20),
                    TextField(
                      controller: emailEditingController,
                      decoration: InputDecoration(
                        labelText: 'Eamil',
                        hintText: 'enter yor email',

                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 50, width: 20),
                    TextFormField(
                      //initialValue: 'select date',
                      controller: textEditingController,
                      decoration: InputDecoration(
                        labelText: 'Birth',
                        hintText: 'Date of Birth',

                        suffixIcon: IconButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          icon: const Icon(Icons.calendar_today),
                        ),
                        border: const OutlineInputBorder(),

                        focusedBorder: const OutlineInputBorder(),
                      ),

                      readOnly: true,
                    ),

                    SizedBox(height: 50, width: 20),
                    // TextField(
                    //   maxLines:
                    //       null, // Allows for multiple lines, expands as needed
                    //   keyboardType: TextInputType.multiline,
                    //   decoration: InputDecoration(
                    //     labelText: 'About us',
                    //     hintText: 'Tell me about your self',
                    //     border: OutlineInputBorder(),
                    //   ),
                    //   // maxLines: null,
                    //   // keyboardType: TextInputType.multiline,
                    // ),
                    MaterialButton(
                      elevation: 0.0,
                      color: Colors.grey,
                      onPressed: () {
                        saveUserData();
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:_selectedDate ?? DateTime.now(), // Sets the initial date displayed
      firstDate: DateTime(1800), // Sets the earliest selectable date
      lastDate: DateTime(2027), // Sets the latest selectable date
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(picked);
        textEditingController.text = formattedDate;
      });
    }
  }

  void saveUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('date', textEditingController.text);
    await prefs.setString('name', nameEditingController.text);
    await prefs.setString('email', emailEditingController.text);
  }

  Future<void> getSavedData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //log(await prefs.getString('date')?? "no data");
    textEditingController.text = prefs.getString('date') ?? "no data";
    nameEditingController.text = prefs.getString('name') ?? "null";
    emailEditingController.text = prefs.getString('email') ?? "null";
  }

  Future<void> getLostData() async {
    final ImagePicker picker = ImagePicker();
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      // if (_imageFile !=null) {
      //   await _saveImageLocally(_imageFile!);

      // }
    }
  }

  Future<void> _saveImageLocally(File image) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final fileName = p.basename(image.path);
    final locaLImage = await image.copy('${appDocDir.path}/$fileName');
    debugPrint('Image saved locally at :${locaLImage.path}');
    // Update your user data with the local path
  }

  Future getApplicationDocumentsDirectory() async {
    return await path_provider.getApplicationDocumentsDirectory();
  }
}
