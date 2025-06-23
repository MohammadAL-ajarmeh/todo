// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: TodoApp(
        onToggleTheme: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
        isDarkMode: isDarkMode,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoApp extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const TodoApp({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final List<String> tasks = [];
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo Application',)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Input and Add button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    
                    controller: controller,
                    maxLength: 10,
                    decoration: const InputDecoration(
                      labelText: 'Task',
                      border: OutlineInputBorder(),
                      counterText: '',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (controller.text.trim().isNotEmpty) {
                      setState(() {
                        tasks.add(controller.text.trim());
                        controller.clear();
                      });
                    }
                  },
                  child: const Text('Add'),
                  
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Task List
            Expanded(
              child: tasks.isEmpty
                  ? const Center(child: Text('No tasks yet.'))
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (_, index) {
                        return Card(
                          child: ListTile(
                            title: Text(tasks[index]),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  tasks.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),

            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.isDarkMode ? Icons.nightlight_round : Icons.wb_sunny),
                Switch(
                  value: widget.isDarkMode,
                  onChanged: (value) {
                    widget.onToggleTheme();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

