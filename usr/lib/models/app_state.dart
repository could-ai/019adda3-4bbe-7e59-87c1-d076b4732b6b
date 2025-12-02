import 'package:flutter/material.dart';

class NewsArticle {
  final String id;
  final String title;
  final String summary;
  final String source;
  final DateTime publishedAt;
  final String imageUrl;

  NewsArticle({
    required this.id,
    required this.title,
    required this.summary,
    required this.source,
    required this.publishedAt,
    required this.imageUrl,
  });
}

class InvestmentIdea {
  final String id;
  final String relatedArticleId;
  final String relatedArticleTitle;
  final String ticker;
  final String thesis; // Why invest?
  final String sentiment; // Bullish / Bearish
  final DateTime createdAt;

  InvestmentIdea({
    required this.id,
    required this.relatedArticleId,
    required this.relatedArticleTitle,
    required this.ticker,
    required this.thesis,
    required this.sentiment,
    required this.createdAt,
  });
}

class AppState extends ChangeNotifier {
  // Mock Data - News
  final List<NewsArticle> _articles = [
    NewsArticle(
      id: '1',
      title: 'Tech Giants Report Record Earnings Amid AI Boom',
      summary: 'Major technology companies have surpassed market expectations, driven by the surging demand for artificial intelligence solutions.',
      source: 'TechDaily',
      publishedAt: DateTime.now().subtract(const Duration(hours: 2)),
      imageUrl: 'https://placehold.co/600x400/2196F3/FFFFFF/png?text=AI+Boom',
    ),
    NewsArticle(
      id: '2',
      title: 'Green Energy Sector Sees New Government Subsidies',
      summary: 'New legislation aims to boost solar and wind energy production with significant tax credits for manufacturers.',
      source: 'EcoWorld',
      publishedAt: DateTime.now().subtract(const Duration(hours: 5)),
      imageUrl: 'https://placehold.co/600x400/4CAF50/FFFFFF/png?text=Green+Energy',
    ),
    NewsArticle(
      id: '3',
      title: 'Electric Vehicle Sales Slow Down in Q3',
      summary: 'Consumer demand for EVs has cooled slightly due to high interest rates and charging infrastructure concerns.',
      source: 'AutoNews',
      publishedAt: DateTime.now().subtract(const Duration(days: 1)),
      imageUrl: 'https://placehold.co/600x400/F44336/FFFFFF/png?text=EV+Sales',
    ),
    NewsArticle(
      id: '4',
      title: 'Semiconductor Shortage Expected to Ease by Year End',
      summary: 'Supply chain experts predict a normalization of chip availability, which could boost automotive and consumer electronics sectors.',
      source: 'ChipInsider',
      publishedAt: DateTime.now().subtract(const Duration(days: 2)),
      imageUrl: 'https://placehold.co/600x400/FF9800/FFFFFF/png?text=Chips',
    ),
  ];

  // Mock Data - Captured Ideas
  final List<InvestmentIdea> _ideas = [];

  List<NewsArticle> get articles => _articles;
  List<InvestmentIdea> get ideas => _ideas;

  void addIdea(InvestmentIdea idea) {
    _ideas.add(idea);
    notifyListeners();
  }

  void removeIdea(String id) {
    _ideas.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
