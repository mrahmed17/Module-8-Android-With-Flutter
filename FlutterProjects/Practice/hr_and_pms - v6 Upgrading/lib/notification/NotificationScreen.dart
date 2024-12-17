import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildNotificationCard(
            icon: Icons.notifications,
            color: Colors.blue,
            title: "Leave Request Submitted",
            subtitle: "An employee has submitted a leave request.",
            timestamp: "Just now",
            onDismissed: () {},
          ),
          _buildNotificationCard(
            icon: Icons.monetization_on,
            color: Colors.green,
            title: "Advance Salary Requested",
            subtitle: "An employee has requested an advance salary.",
            timestamp: "2 hours ago",
            onDismissed: () {},
          ),
          _buildNotificationCard(
            icon: Icons.feedback,
            color: Colors.orange,
            title: "Feedback Submitted",
            subtitle: "An employee has submitted feedback.",
            timestamp: "Yesterday",
            onDismissed: () {},
          ),
          _buildNotificationCard(
            icon: Icons.warning,
            color: Colors.red,
            title: "Critical System Alert",
            subtitle: "There was a critical issue detected.",
            timestamp: "2 days ago",
            onDismissed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required String timestamp,
    required Function() onDismissed,
  }) {
    return Dismissible(
      key: Key(timestamp), // Unique key to dismiss each notification
      direction: DismissDirection.endToStart, // Swipe to dismiss
      onDismissed: (_) => onDismissed(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: Colors.redAccent,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, size: 30, color: color),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(subtitle),
          trailing: Text(
            timestamp,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}

class ManagerDashboardScreen extends StatefulWidget {
  const ManagerDashboardScreen({super.key});

  @override
  _ManagerDashboardScreenState createState() => _ManagerDashboardScreenState();
}

class _ManagerDashboardScreenState extends State<ManagerDashboardScreen> {
  int _selectedIndex = 0;
  List<Widget> _screens = [Container(), const NotificationScreen()]; // Add Notification Page as one of the screens

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manager Dashboard'),
        backgroundColor: Colors.teal,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
      ),
    );
  }
}
