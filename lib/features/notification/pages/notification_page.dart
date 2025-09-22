import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../managers/notification_bloc.dart';
import '../managers/notification_state.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Notification',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              height: 1,
              color: const Color(0xFFE6E6E6),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<NotificationBloc, NotificationState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state.error != null) {
                    return Center(
                      child: Text(
                        state.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  if (state.notifications.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          SvgPicture.asset("assets/icons/Bell.svg",width: 64,height: 64,),
                          const Text("You haven’t gotten any notifications yet!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,),maxLines: 2,),
                          Text('We’ll alert you when something cool happens.',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,),maxLines: 2,)
                        ],
                      ),
                    );
                  }
                  final grouped = context
                      .read<NotificationBloc>()
                      .groupNotifications(state.notifications);

                  return ListView(
                    children: grouped.entries.map((entry) {
                      final date = entry.key;
                      final list = entry.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${date.day}.${date.month}.${date.year}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...list.map((n) {
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                leading: Icon(Icons.notifications),
                                title: Text(n.title),
                                subtitle: Text(n.content),
                                trailing: Text(
                                  "${n.date.hour.toString().padLeft(2, '0')}:${n.date.minute.toString().padLeft(2, '0')}",
                                ),
                              ),
                            );
                          }),
                          const SizedBox(height: 16),
                        ],
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
