import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:gsg_fire_base/Providers/authProvider.dart';
import 'package:gsg_fire_base/Services/Router.dart';
import 'package:gsg_fire_base/constants.dart';
import 'package:provider/provider.dart';

class AllUsersScreen extends StatelessWidget {
  static final routeName = 'AllUsersScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('All Users'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            RouteHelper.routeHelper.goTOReplacement(HomeScreen.routeName);
          },
        ),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, provider, x) {
          if (provider.users == null) {
            print(provider.users);
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: provider.users.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          NetworkImage(provider.users[index].imageUrl),
                    ),
                    title: Text(provider.users[index].userName),
                    subtitle: Text(provider.users[index].bio),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
