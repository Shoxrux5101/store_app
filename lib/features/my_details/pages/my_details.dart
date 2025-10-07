import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/core/authInterceptor.dart';
import '../../../core/network/api_client.dart';
import '../../../core/routes/routes.dart';
import '../../../data/repository/my_detail_repository.dart';
import '../manager/my_detail_bloc.dart';
import '../manager/my_detail_event.dart';
import '../manager/my_detail_state.dart';

class MyDetailPage extends StatelessWidget {
  const MyDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MyDetailBloc(
        MyDetailRepository(apiClient: ApiClient(interceptor: AuthInterceptor(secureStorage: FlutterSecureStorage()))),
      )..add(LoadMyDetail()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
          centerTitle: true,
          title: const Text("My Details"),
          actions: [
            IconButton(onPressed: (){context.push(Routes.notification);}, icon: SvgPicture.asset('assets/icons/Bell.svg')),
          ],
        ),
        body: BlocBuilder<MyDetailBloc, MyDetailState>(
          builder: (context, state) {
            if (state is MyDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MyDetailLoaded) {
              final details = state.details;
              print(details);
              if (details.isEmpty) {
                return const Center(child: Text("Hech qanday ma'lumot yo‘q"));
              }

              return ListView.separated(
                itemCount: details.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final detail = details[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(detail.fullName.isNotEmpty ? detail.fullName[0] : "?"),
                    ),
                    title: Text(detail.fullName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email: ${detail.email}"),
                        Text("Phone: ${detail.phoneNumber}"),
                        Text("Gender: ${detail.gender}"),
                        Text("Birth Date: ${detail.birthDate}"),
                      ],
                    ),
                  );
                },
              );
            } else if (state is MyDetailError) {
              return Center(child: Text("Xatolik: ${state.message}"));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
