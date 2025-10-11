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
      """When you find a product you want to purchase, tap on it to view the product details. Check the price, description, and available options (if applicable), and then tap the "Add to Cart" button. Follow the on-screen instructions to complete the purchase, including providing shipping details and payment information.""",
    ),
    FAQModel(
      question: "What payment methods are accepted?",
      answer:
      """When you find a product you want to purchase, tap on it to view the product details. Check the price, description, and available options (if applicable), and then tap the "Add to Cart" button. Follow the on-screen instructions to complete the purchase, including providing shipping details and payment information.""",
    ),
    FAQModel(
      question: "How do I track my orders?",
      answer:"""When you find a product you want to purchase, tap on it to view the product details. Check the price, description, and available options (if applicable), and then tap the "Add to Cart" button. Follow the on-screen instructions to complete the purchase, including providing shipping details and payment information.""",
    ),
    FAQModel(
      question: "Can I cancel or return an order?",
      answer:
      """When you find a product you want to purchase, tap on it to view the product details. Check the price, description, and available options (if applicable), and then tap the "Add to Cart" button. Follow the on-screen instructions to complete the purchase, including providing shipping details and payment information.""",
    ),
    FAQModel(
      question: "How can I contact customer support for assistance?",
      answer:
      """When you find a product you want to purchase, tap on it to view the product details. Check the price, description, and available options (if applicable), and then tap the "Add to Cart" button. Follow the on-screen instructions to complete the purchase, including providing shipping details and payment information.""",
    ),
    FAQModel(
      question: "How do I create an account?",
      answer:
      """When you find a product you want to purchase, tap on it to view the product details. Check the price, description, and available options (if applicable), and then tap the "Add to Cart" button. Follow the on-screen instructions to complete the purchase, including providing shipping details and payment information.""",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          "FAQs",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
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
