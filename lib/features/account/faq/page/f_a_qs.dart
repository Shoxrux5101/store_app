import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../model/faq_model.dart';
import '../widgets/faq_category_tabs.dart';
import '../widgets/faq_search_bar.dart';
import '../widgets/faq_item.dart';

class FAQsPage extends StatefulWidget {
  const FAQsPage({super.key});

  @override
  State<FAQsPage> createState() => _FAQsPageState();
}

class _FAQsPageState extends State<FAQsPage> {
  int selectedCategory = 0;
  int expandedIndex = -1;

  List<String> categories = ["General", "Account", "Service", "Payment"];

  List<FAQModel> faqs = [
    FAQModel(
      question: "How do I make a purchase?",
      answer:
      "When you find a product you want to purchase, tap on it to view the product details...",
    ),
    FAQModel(
      question: "What payment methods are accepted?",
      answer:
      "We accept major credit/debit cards, PayPal, and other payment methods.",
    ),
    FAQModel(
      question: "How do I track my orders?",
      answer: "Go to 'My Orders' to see order status and tracking info.",
    ),
    FAQModel(
      question: "Can I cancel or return an order?",
      answer:
      "Yes, depending on our policy. See 'Returns & Refunds' for details.",
    ),
    FAQModel(
      question: "How can I contact customer support?",
      answer:
      "You can contact support through the Help Center or Contact Us page.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          "FAQs",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset("assets/icons/Bell.svg"),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 8),
          FAQCategoryTabs(
            categories: categories,
            selectedIndex: selectedCategory,
            onSelect: (i) {
              setState(() {
                selectedCategory = i;
              });
            },
          ),
          SizedBox(height: 8),
          FAQSearchBar(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: faqs.length,
              itemBuilder: (context, index) {
                return FAQItem(
                  faq: faqs[index],
                  isExpanded: expandedIndex == index,
                  onTap: () {
                    setState(() {
                      expandedIndex = expandedIndex == index ? -1 : index;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
