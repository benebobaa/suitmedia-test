import 'package:flutter/material.dart';
import 'package:flutter_suitmedia/view/second_screen.dart';
import 'package:flutter_suitmedia/viewmodel/firstscreen_viewmodel.dart';
import 'package:flutter_suitmedia/widget/button_custom.dart';
import 'package:flutter_suitmedia/widget/formfield_custom.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _nameController = TextEditingController();
  final _palindromController = TextEditingController();
  FirstScreenViewModel vm = FirstScreenViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Colors.lightBlue,
            Colors.blue,
            Colors.grey,
            Colors.blueGrey,
            Colors.blueGrey,
          ])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white54,
                  child: IconButton(
                    icon: const Icon(
                      Icons.person_add_alt_sharp,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: TextFormCustom(
                    controller: _nameController,
                    hintText: 'Name',
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: TextFormCustom(
                    controller: _palindromController,
                    hintText: 'Palindrome',
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: ButtonCustom(
                        text: 'Check',
                        onPressed: () {
                          (vm.isPalindrome(_palindromController.text))
                              ? _showAlertDialog(
                                  context, 'Is Palindrome', 'Palindrom Check')
                              : _showAlertDialog(
                                  context, 'Not Palindrome', 'Palindrom Check');
                        })),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: ButtonCustom(
                        text: 'Next',
                        onPressed: () {
                          if (_nameController.text.isEmpty) {
                            _showAlertDialog(
                                context, 'Nama tidak  boleh kosong', 'Pesan');
                            return;
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecondScreen(
                                        name: _nameController.text,
                                      )));
                        })),
              ],
            ),
          )),
    );
  }

  Future<dynamic> _showAlertDialog(
      BuildContext context, String text, String title) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              title: Text(title),
              content: Text(text),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok')),
              ],
            ));
  }
}
