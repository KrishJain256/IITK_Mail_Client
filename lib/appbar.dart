import 'package:flutter/material.dart';

class pfp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 50, // Adjust the radius for the size you want
        backgroundImage: "https://i.redd.it/bcyq3rjk2w071.png".isNotEmpty ? NetworkImage("https://i.redd.it/bcyq3rjk2w071.png") : null,
        backgroundColor: Colors.grey.shade200, // A default color for the avatar
        child: "https://i.redd.it/bcyq3rjk2w071.png".isEmpty ? Text("K") : null,
      );
  }
}

class appbar extends StatelessWidget {
  const appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: pfp(),
        actions: <Widget>[

          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Go to the next page',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Next page'),
                    ),
                    body: const Center(
                      child: Text(
                        'This is the next page',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                },
              ));
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'This is the home page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
