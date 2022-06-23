import 'package:api_first/api/controller/auth_api_controller.dart';
import 'package:api_first/api/controller/user_api_controller.dart';
import 'package:api_first/model/api_response.dart';
import 'package:api_first/storge/pref_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/user_api.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late Future<List<User>> _future;

  @override
  void initState() {
    _future = UserApiController().reedUser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              icon: const Icon(Icons.login_outlined, color: Colors.black),
              onPressed: () async {
                ApiResponse apiResponse = await AuthApiController().logout();
                if (apiResponse.status) {
                  await SharedPrefController().clear();
                  Navigator.pushReplacementNamed(context, '/login_screen');
                }
              }),
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/images_screen'),
            icon: const Icon(Icons.image,color: Colors.black,),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'User Screen',
          style: GoogleFonts.cairo(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<User>>(
        // future: UserApiController().reedUser(),
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(snapshot.data![index].firstName),
                    subtitle: Text(snapshot.data![index].email),
                    leading: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage(snapshot.data![index].image),
                    ),
                  );
                });
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.warning,
                  color: Colors.black45,
                  size: 80,
                ),
                Text(
                  'No Data',
                  style: GoogleFonts.cairo(
                    fontSize: 24,
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
