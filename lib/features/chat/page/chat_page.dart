import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:store_app/features/chat/managers/chat_bloc.dart';
import 'package:store_app/features/chat/managers/chat_state.dart';
import 'package:store_app/features/chat/widgets/chat_input_field.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  @override
  State<ChatPage> createState() => _ChatPageState();
}
class _ChatPageState extends State<ChatPage> {
  final controller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
          centerTitle: true,
          title: Text(
            "Customer Chat",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/icons/phone.svg"),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.separated(
                    itemCount: state.messages.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                    itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Align(
                          alignment: state.messages[index]["direction"] == "to"
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: Container(
                            width: 200,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: state.messages[index]["direction"] == "to"
                                  ? Colors.grey
                                  : Colors.black,
                              borderRadius: state.messages[index]["direction"] == "to"
                                  ? BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    )
                                  : BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                            ),
                            child: Text(
                              state.messages[index]["message"],
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: state.messages[index]["direction"] == "to"
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: state.messages[index]["direction"] == "to"
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: Text(
                            DateFormat("HH:mm").format(
                              DateTime.parse(state.messages[index]["date"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ChatInputField(controller: controller,),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
