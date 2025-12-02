import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/app_state.dart';

class CaptureIdeaScreen extends StatefulWidget {
  const CaptureIdeaScreen({super.key});

  @override
  State<CaptureIdeaScreen> createState() => _CaptureIdeaScreenState();
}

class _CaptureIdeaScreenState extends State<CaptureIdeaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tickerController = TextEditingController();
  final _thesisController = TextEditingController();
  String _sentiment = 'Bullish';

  @override
  void dispose() {
    _tickerController.dispose();
    _thesisController.dispose();
    super.dispose();
  }

  void _saveIdea(NewsArticle article) {
    if (_formKey.currentState!.validate()) {
      final newIdea = InvestmentIdea(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        relatedArticleId: article.id,
        relatedArticleTitle: article.title,
        ticker: _tickerController.text.toUpperCase(),
        thesis: _thesisController.text,
        sentiment: _sentiment,
        createdAt: DateTime.now(),
      );

      context.read<AppState>().addIdea(newIdea);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Investment Idea Captured!')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Handle case where arguments might be null or invalid, though flow guarantees it usually
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null || args is! NewsArticle) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('No article provided')),
      );
    }
    
    final article = args;

    return Scaffold(
      appBar: AppBar(
        title: Text('Capture Idea', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Article Context
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reference Article:',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Ticker Input
              Text('Ticker Symbol', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _tickerController,
                decoration: InputDecoration(
                  hintText: 'e.g. AAPL, TSLA',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  prefixIcon: const Icon(Icons.attach_money),
                ),
                textCapitalization: TextCapitalization.characters,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a ticker symbol';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Sentiment Selection
              Text('Sentiment', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Bullish', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      value: 'Bullish',
                      groupValue: _sentiment,
                      activeColor: Colors.green,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (value) {
                        setState(() {
                          _sentiment = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Bearish', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      value: 'Bearish',
                      groupValue: _sentiment,
                      activeColor: Colors.red,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (value) {
                        setState(() {
                          _sentiment = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Thesis Input
              Text('Investment Thesis', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _thesisController,
                decoration: InputDecoration(
                  hintText: 'Why is this a good idea? What is your reasoning?',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your investment thesis';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _saveIdea(article),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Save Investment Idea',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
