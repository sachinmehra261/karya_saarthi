import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,

        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),

            child: Column(
              children: [
                CircleAvatar(radius: 30, child: Icon(Icons.person)),

                SizedBox(height: 10),

                Text(
                  "Karya Sarthi",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home),
            title: Text("Home", style: Theme.of(context).textTheme.titleMedium),

            onTap: () {
              context.pop();
              context.go("/");
            },
          ),

          ListTile(
            leading: const Icon(Icons.star_rounded),
            title: Text(
              "Hit Chaurasi Ji",
              style: Theme.of(context).textTheme.titleMedium,
            ),

            onTap: () {
              context.pop();
              context.push("/hit_chaurasi");
            },
          ),
          ListTile(
            leading: const Icon(Icons.alarm),
            title: Text(
              "Reminders",
              style: Theme.of(context).textTheme.titleMedium,
            ),

            onTap: () {
              context.pop();
              context.push("/reminders");
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(
              "Settings",
              style: Theme.of(context).textTheme.titleMedium,
            ),

            onTap: () {
              context.pop();
              context.push("/settings");
            },
          ),
        ],
      ),
    );
  }
}
