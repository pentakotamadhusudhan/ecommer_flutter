import 'package:flutter/material.dart';
import 'package:local_baba/app_style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // const primaryColor = Color(0xFFC5A08E);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Header Section with Avatar
            _buildHeader(AppColors.gold),

            const SizedBox(height: 10),

            // 2. Account Statistics / Quick Info
            _buildStatsRow(),

            const SizedBox(height: 20),

            // 3. Menu Options
            _buildMenuSection(context, "Account Settings", [
              _ProfileMenuItem(
                  icon: Icons.person_outline,
                  title: "Edit Profile",
                  onTap: () {}),
              _ProfileMenuItem(
                  icon: Icons.shopping_bag_outlined,
                  title: "Change Password",
                  onTap: () {}),
              _ProfileMenuItem(
                  icon: Icons.location_city,
                  title: "History",
                  onTap: () {}),
            ]),

            _buildMenuSection(context, "General", [
              _ProfileMenuItem(
                  icon: Icons.notifications_none,
                  title: "Notifications",
                  onTap: () {}),
              _ProfileMenuItem(
                  icon: Icons.favorite_border, title: "Wishlist", onTap: () {}),
              _ProfileMenuItem(
                  icon: Icons.help_outline,
                  title: "Help & Support",
                  onTap: () {}),
            ]),

            // 4. Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Logout",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 60, color: Color(0xFFC5A08E)),
          ),
          const SizedBox(height: 15),
          const Text(
            "John Doe",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            "johndoe@example.com",
            style:
                TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem("Orders", "12"),
          _buildStatItem("Pending", "2"),
          _buildStatItem("Reviews", "5"),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildMenuSection(
      BuildContext context, String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey)),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: Column(children: items),
        ),
      ],
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileMenuItem(
      {required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFC5A08E)),
      title: Text(title, style: TextStyle()),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
