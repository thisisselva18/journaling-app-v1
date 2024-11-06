import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart'; // Make sure this is imported for animations

void main() => runApp(JournalApp());

class JournalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Journal',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor:
            Color.fromARGB(255, 41, 201, 193), // Background color
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal, // AppBar color
          titleTextStyle: TextStyle(
            color: Colors.white, // White text in AppBar for contrast
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true, // Center the title in the AppBar
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.teal, // Same color for FAB
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: Colors.black54,
          ),
        ),
      ),
      home: JournalHomePage(),
    );
  }
}

class JournalHomePage extends StatefulWidget {
  @override
  _JournalHomePageState createState() => _JournalHomePageState();
}

class _JournalHomePageState extends State<JournalHomePage> {
  final List<Map<String, dynamic>> _entries = [
    {
      'title': 'Day at the Beach',
      'date': DateTime.now().subtract(Duration(days: 1)),
      'content': 'Today was amazing!'
    },
    {
      'title': 'Morning Run',
      'date': DateTime.now().subtract(Duration(days: 2)),
      'content': 'Started my day with a run.'
    },
  ];

  void _addNewEntry(Map<String, dynamic> newEntry) {
    setState(() => _entries.add(newEntry));
  }

  void _openAddEntryPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEntryPage(onAdd: _addNewEntry),
      ),
    );
  }

  void _openEntryDetail(Map<String, dynamic> entry) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EntryDetailPage(entry: entry)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The InsightOut Journal'),
        backgroundColor: Colors.teal, // Centered AppBar title
      ),
      backgroundColor: Colors.teal[50],
      body: ListView.builder(
        itemCount: _entries.length,
        itemBuilder: (_, index) {
          final entry = _entries[index];
          return FadeInUp(
            duration: Duration(milliseconds: 800),
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              elevation: 4, // Elevation for shadow effect
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10), // Rounded corners for cards
              ),
              child: ListTile(
                title: Text(
                  entry['title'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('${entry['date'].toLocal()}'.split(' ')[0]),
                onTap: () => _openEntryDetail(entry),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FadeInUp(
        duration: Duration(milliseconds: 800),
        delay: Duration(milliseconds: 600),
        child: GestureDetector(
          onTap: _openAddEntryPage,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class AddEntryPage extends StatelessWidget {
  final Function(Map<String, dynamic>) onAdd;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  AddEntryPage({required this.onAdd});

  void _saveEntry(BuildContext context) {
    onAdd({
      'title': _titleController.text,
      'date': DateTime.now(),
      'content': _contentController.text,
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Add New Entry'), backgroundColor: Colors.teal),
      backgroundColor: Colors.teal[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FadeInUp(
              duration: Duration(milliseconds: 800),
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title of your Journal :D', // Customized label
                ),
              ),
            ),
            SizedBox(height: 10),
            FadeInUp(
              duration: Duration(milliseconds: 800),
              child: TextField(
                controller: _contentController,
                decoration: InputDecoration(
                  labelText: 'Type whatever you want!', // Customized label
                ),
                maxLines: 5,
              ),
            ),
            SizedBox(height: 20),
            FadeInUp(
              duration: Duration(milliseconds: 800),
              delay: Duration(milliseconds: 400),
              child: ElevatedButton(
                onPressed: () => _saveEntry(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  'Save your Entry',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EntryDetailPage extends StatelessWidget {
  final Map<String, dynamic> entry;

  EntryDetailPage({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(entry['title'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${entry['date'].toLocal()}'.split(' ')[0],
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              entry['content'],
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
