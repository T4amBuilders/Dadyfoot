import 'package:flutter/material.dart';
import '../../services/profile_service.dart';
import '../../widgets/profile_widgets.dart';
import './profile_screen.dart';

class ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  String? username;
  String? email;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await ProfileService.getUserData();
    setState(() {
      username = userData['username'];
      email = userData['email'];
      _nameController.text = userData['name'];
    });
  }

  Future<void> _updateName() async {
    try {
      await ProfileService.updateUserName(_nameController.text);
      setState(() {
        errorMessage = "Nom mis à jour avec succès.";
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ProfileForm(
          username: username,
          email: email,
          nameController: _nameController,
          onUpdateName: _updateName,
          errorMessage: errorMessage,
        ),
      ),
    );
  }
}
