import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final TextEditingController classCodeController = TextEditingController();
  bool isLoading = false;

  Future<void> joinProject() async {
    final classCode = classCodeController.text.trim();

    if (classCode.isEmpty) {
      showMessage('Please enter a class code.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      final cleanedCode = classCode.trim().toUpperCase();
      
      final response = await http.get(
        
        Uri.parse(
          'https://citizen-science-backend.fly.dev/api/projects/code/$cleanedCode',
        ),
      );

      if (response.statusCode == 200) {
        final projectData = Map<String, dynamic>.from(
          jsonDecode(response.body),
        );

        if (!mounted) {
          return;
        }

        Navigator.pushReplacementNamed(
          context,
          '/nav',
          arguments: projectData,
        );
      } else {
        showMessage('Invalid class code. Please try again.');
      }
    } catch (error) {
      showMessage('Error joining project.');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void learnMore() {
    showMessage('This app helps students record science observations.');
  }

  void showMessage(String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  void dispose() {
    classCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/mobile_web_title.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.eco,
                                size: 80,
                                color: colorScheme.primary,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Citizen Science for Kids',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.primary,
                                    ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Join your class project and record observations from the field!',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: colorScheme.onSurface,
                                    ),
                              ),
                              const SizedBox(height: 32),
                              TextField(
                                controller: classCodeController,
                                decoration: const InputDecoration(
                                  labelText: 'Class Code',
                                  hintText: 'Enter your class code',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.lock_outline),
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: isLoading ? null : joinProject,
                                  child: Text(
                                    isLoading ? 'Joining...' : 'Join Project',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextButton(
                                onPressed: learnMore,
                                child: const Text('Learn More'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}