import 'package:flutter/material.dart';

import '../model/faq_model.dart';

class FAQItem extends StatelessWidget {
  final FAQModel faq;
  final bool isExpanded;
  final VoidCallback onTap;

  const FAQItem({
    super.key,
    required this.faq,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14,top: 14,left: 20,),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            faq.question,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          trailing: Icon(
            isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.black,
          ),
          onExpansionChanged: (context) => onTap(),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                maxLines: 10,
                faq.answer,
                style: TextStyle(color: Colors.black54,fontSize: 12,fontWeight: FontWeight.w400,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
