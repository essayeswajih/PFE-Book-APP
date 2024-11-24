import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pfe_book/pages/constructionPage.dart';
import 'package:pfe_book/pages/loginPage.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.amber,
            padding: const EdgeInsets.only(top: 40.0, bottom: 20),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40, // Adjust size as needed
                  backgroundImage: AssetImage('assets/images/logo2.png'),
                  backgroundColor: Colors.amber,
                ),
                SizedBox(height: 10),
                Text(
                  'Essayes Mohamed Wajih',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'wajihsayes@gmail.com',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  icon: Icons.dashboard,
                  text: 'Dashboard',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const constructionPage()));
                  },
                ),
                const Divider(),
                _buildDrawerItem(
                  icon: Icons.favorite,
                  text: 'Favorites',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const constructionPage()));
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.history,
                  text: 'History',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const constructionPage()));
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.settings,
                  text: 'Settings',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const constructionPage()));
                  },
                ),
                const Divider(),
                _buildDrawerItem(
                  icon: Icons.help,
                  text: 'Help & Support',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const constructionPage()));
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.info,
                  text: 'About',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const constructionPage()));
                  },
                ),
                const Divider(),
                _buildDrawerItem(
                  icon: Icons.logout,
                  text: 'Logout',
                  onTap: () async {
                    // Sign the user out
                    await FirebaseAuth.instance.signOut();

                    // Navigate to the login screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>  const LoginPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Version 1.0.0',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({required IconData icon, required String text, required GestureTapCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(
        text,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}
