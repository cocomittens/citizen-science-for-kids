import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final TextEditingController classCodeController = TextEditingController();

  void joinProject() {
    String classCode = classCodeController.text.trim();

    if (classCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a class code.'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Joining project with code: $classCode'),
      ),
    );
  }

  void learnMore() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('This app helps students record science observations.'),
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
    Theme.of(context);

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/mobile_web_title.png"),
            fit: BoxFit.cover
          )
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Row(children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.eco,
                          size: 90,
                          color: Colors.green,
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 20.0, right: 20.0, left: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 24),
                              Text(
                                'Citizen Science for Kids',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.amber
                                  )
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Join your class project and record observations from the field!',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.robotoSerif(
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white
                                  )
                                ),
                              )
                            ]
                          )
                        ),
                        const SizedBox(height: 32),
                        TextField(
                          controller: classCodeController,
                          decoration: InputDecoration(
                            labelText: 'Class Code',
                            labelStyle: TextStyle(
                              color: Colors.grey
                            ),
                            hintText: 'Enter your class code',
                            hintStyle: TextStyle(
                              color: const Color.fromARGB(255, 72, 97, 109),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white, width: 1.0
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 3.0
                              )
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.lock_outline),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/nav');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              textStyle: const TextStyle(fontSize: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Join Project'),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: learnMore,
                          child: const Text(
                            'Learn More',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(flex: 4, child: Container())
                ]),
              )
            )
          ),
        ),
      )
    );
  }
}