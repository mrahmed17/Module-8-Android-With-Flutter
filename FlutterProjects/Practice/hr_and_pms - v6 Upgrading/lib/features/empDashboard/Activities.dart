import 'package:flutter/material.dart';

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activities'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ActivityList(),
            Divider(),
            NotificationBox(),
          ],
        ),
      ),
    );
  }
}

class ActivityList extends StatelessWidget {
  const ActivityList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ActivityItem(
          avatar: Image.asset('assets/images/profile_demo/profile.png'),
          name: 'Shabab Ahmed',
          action: 'added new task',
          task: 'Bonus Accept',
          time: '4 mins ago',
        ),
        ActivityItem(
          avatar: Text('L'),
          name: 'Raju Ahmed',
          action: 'added',
          extraUsers: ['Loren Gatlin', 'Tarah Shropshire'],
          task: 'Leave Application',
          time: '6 mins ago',
        ),
        // Add more ActivityItems here...
      ],
    );
  }
}

class ActivityItem extends StatelessWidget {
  final Widget avatar;
  final String name;
  final String action;
  final String? task;
  final List<String>? extraUsers;
  final String time;

  const ActivityItem({super.key, 
    required this.avatar,
    required this.name,
    required this.action,
    this.task,
    this.extraUsers,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: avatar),
      title: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(text: '$name '),
            TextSpan(
                text: action, style: TextStyle(fontWeight: FontWeight.bold)),
            if (extraUsers != null)
              TextSpan(text: ' ${extraUsers!.join(', ')} '),
            if (task != null)
              TextSpan(
                  text: task!, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      subtitle: Text(time),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          // Handle delete action
        },
      ),
    );
  }
}

class NotificationBox extends StatelessWidget {
  const NotificationBox({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text("Messages"),
      children: [
        MessageItem(
          author: 'Rezvi',
          time: '1:28 PM, 1 Dec',
          content: 'Lorem ipsum dolor sit amet, consectetur adipiscing',
        ),
        MessageItem(
          author: 'Najmul',
          time: '2:38 PM, 1 Dec',
          content: 'Lorem ipsum dolor sit amet, consectetur adipiscing',
          isNew: true,
        ),
        // Add more MessageItems here...
      ],
    );
  }
}

class MessageItem extends StatelessWidget {
  final String author;
  final String time;
  final String content;
  final bool isNew;

  const MessageItem({super.key, 
    required this.author,
    required this.time,
    required this.content,
    this.isNew = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(author[0]),
      ),
      title: Text(author),
      subtitle: Text(content),
      trailing: Text(time),
      tileColor: isNew ? Colors.blue.shade50 : Colors.white,
    );
  }
}

void main() => runApp(MaterialApp(home: ActivitiesPage()));
