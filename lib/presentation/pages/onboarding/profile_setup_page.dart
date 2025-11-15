import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/profile/profile_cubit.dart';
import '../../bloc/profile/profile_state.dart';

class QuestionSlide extends StatefulWidget {
  final String
  keyName;
  final String question;
  final TextEditingController controller;
  final Function(String key, dynamic value) onUpdate;

  const QuestionSlide({
    super.key,
    required this.keyName,
    required this.question,
    required this.controller,
    required this.onUpdate,
  });

  @override
  State<QuestionSlide> createState() => _QuestionSlideState();
}

class _QuestionSlideState extends State<QuestionSlide> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.question,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: widget.controller,
              onChanged: (value) {
                widget.onUpdate(widget.keyName, value);
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Jawaban untuk ${widget.keyName}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Daftarkan controller untuk setiap input
  final List<TextEditingController> _controllers = List.generate(
    10,
    (_) => TextEditingController(),
  );

  final List<Map<String, String>> questions = [
    {"key": "name", "question": "What's your Name?"},
    {"key": "nickname", "question": "What's your Nickname?"},
    {"key": "role", "question": "Tell us who You are..."},
    {"key": "birthdate", "question": "Let's get your Birthdate?"},
    {"key": "personality", "question": "What's your Personality Type?"},
    {"key": "blood_type", "question": "What's your blood type?"},
    {"key": "fun_activity", "question": "What do you do for fun?"},
    {"key": "faculty", "question": "Which faculty Are you in?"},
    {"key": "major", "question": "What's your Major?"},
    {"key": "college_year", "question": "What year did you start College?"},
  ];

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < questions.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      context.read<ProfileCubit>().submitProfile();
    }
  }

  void _onUpdateData(String key, dynamic value) {
    context.read<ProfileCubit>().updateProfileData(key, value);
  }

  @override
  Widget build(BuildContext context) {
    bool isLastPage = _currentPage == questions.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Setup Profil (${_currentPage + 1}/${questions.length})'),
        automaticallyImplyLeading: false,
      ),
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.isCompleted) {
            context.go('/dashboard');
          } else if (state.errorMessage != null && !state.isLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.errorMessage!}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: questions.length,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return QuestionSlide(
                      keyName: questions[index]["key"]!,
                      question: questions[index]["question"]!,
                      controller: _controllers[index],
                      onUpdate: _onUpdateData,
                    );
                  },
                ),
              ),

              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_currentPage > 0)
                          TextButton(
                            onPressed: state.isLoading
                                ? null
                                : () {
                                    _pageController.previousPage(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeIn,
                                    );
                                  },
                            child: const Text(
                              'Kembali',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        else
                          const SizedBox.shrink(),

                        ElevatedButton(
                          onPressed: state.isLoading ? null : _nextPage,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 15,
                            ),
                          ),
                          child: state.isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                )
                              : Text(
                                  isLastPage
                                      ? 'Selesai & Lanjutkan'
                                      : 'Berikutnya',
                                  style: const TextStyle(fontSize: 16),
                                ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
