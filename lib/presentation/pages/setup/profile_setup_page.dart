import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import 'setup_components.dart';
import 'setup_steps.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  final Map<String, TextEditingController> _controllers = {
    'name': TextEditingController(),
    'nickname': TextEditingController(),
    'personality': TextEditingController(),
    'faculty': TextEditingController(),
    'major': TextEditingController(),
    'year': TextEditingController(),
  };

  String _gender = '';
  DateTime? _birthdate;
  String _bloodType = '';

  final List<String> _hobbies = [];

  void _nextPage() {
    if (_currentStep < 9) {
      _pageController.animateToPage(
        _currentStep + 1,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
      setState(() => _currentStep++);
    } else {
      _submitData();
    }
  }

  void _prevPage() {
    if (_currentStep > 0) {
      _pageController.animateToPage(
        _currentStep - 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
      setState(() => _currentStep--);
    }
  }

  Future<void> _submitData() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(color: AppColors.deepBrown),
      ),
    );

    // Packing Data (Hobby dikirim sebagai List atau digabung string koma)
    final Map<String, dynamic> dataPayload = {
      'full_name': _controllers['name']!.text,
      'nickname': _controllers['nickname']!.text,
      'gender': _gender,
      'birth_date': _birthdate?.toIso8601String(),
      'personality_type': _controllers['personality']!.text,
      'blood_type': _bloodType,
      'hobbies': _hobbies,
      'faculty': _controllers['faculty']!.text,
      'major': _controllers['major']!.text,
      'entry_year': int.tryParse(_controllers['year']!.text) ?? 0,
    };

    debugPrint("DATA YANG AKAN DIKIRIM: $dataPayload");
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.pop(context);
      context.go('/dashboard');
    }
  }

  // LOGIC MEMILIH HOBI (MAKSIMAL 3)
  void _toggleHobby(String hobby) {
    setState(() {
      if (_hobbies.contains(hobby)) {
        _hobbies.remove(hobby);
      } else {
        if (_hobbies.length < 3) {
          _hobbies.add(hobby);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("You can only select up to 3 hobbies!"),
              duration: Duration(milliseconds: 1000),
              backgroundColor: AppColors.deepBrown,
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mascotTalks = [
      "Hi! Let's get\nto know you!",
      "Friends call\nyou what?",
      "Are you a\nGentleman or Lady?",
      "When's the\nparty?",
      "What's your\nVibe?",
      "Just curious\nabout this one!",
      "Pick your top 3\nfavorites!",
      "Where do you\nstudy?",
      "What are you\nmastering?",
      "Class of\nwhat year?",
    ];

    final steps = [
      StepInputText(
        question: "Let's start with your\nName?",
        hint: "Full Name",
        controller: _controllers['name']!,
      ),
      StepInputText(
        question: "Got a\nNickname?",
        hint: "Your Nickname",
        controller: _controllers['nickname']!,
      ),
      StepGender(
        selectedGender: _gender,
        onSelect: (val) => setState(() => _gender = val),
      ),
      StepDate(
        selectedDate: _birthdate,
        onDateSelected: (val) => setState(() => _birthdate = val),
      ),
      StepInputText(
        question: "What's your\nPersonality Type?",
        hint: "e.g. ENTJ",
        controller: _controllers['personality']!,
      ),

      StepOptions(
        title: "Just out of curiosity,\nWhat's your blood type?",
        options: const ['A', 'B', 'AB', 'O'],
        selectedOption: _bloodType,
        onSelect: (val) => setState(() => _bloodType = val),
      ),

      StepMultiOptions(
        title: "What do you do\nfor fun? (Max 3)",
        options: const [
          'Art',
          'Sport',
          'Game',
          'Music',
          'Code',
          'Travel',
          'Cook',
          'Photo',
        ],
        selectedOptions: _hobbies,
        onSelect: _toggleHobby,
      ),

      StepInputText(
        question: "Which faculty\nAre you in?",
        hint: "Faculty Name",
        controller: _controllers['faculty']!,
      ),
      StepInputText(
        question: "What's your\nMajor?",
        hint: "Major Name",
        controller: _controllers['major']!,
      ),
      StepInputText(
        question: "What year did you start\nCollege?",
        hint: "e.g. 2023",
        controller: _controllers['year']!,
        isNumber: true,
      ),
    ];

    return SetupShell(
      totalSteps: steps.length,
      currentStep: _currentStep,
      pageController: _pageController,
      onNext: _nextPage,
      onBack: _prevPage,
      mascotTalk: mascotTalks[_currentStep],
      mascotAsset: 'assets/images/logo manpro2.png',
      children: steps,
    );
  }
}
