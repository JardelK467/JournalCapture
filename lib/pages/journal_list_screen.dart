import 'package:flutter/material.dart';
import 'package:journal_capture/model/journal_entry_model.dart';
import 'package:journal_capture/widgets/animations/page_turn_transition.dart';
import 'package:journal_capture/pages/journal_details_screen.dart';
// Mock data
final List<JournalEntry> mockEntries = [
  JournalEntry(
    id: 1,
    title: "Morning Reflections",
    date: "Nov 8, 2025",
    preview: "Today started with a beautiful sunrise...",
    content:
        "Today started with a beautiful sunrise. The colors reminded me of watercolor paintings I used to make as a child. There's something profound about beginnings - each morning is a fresh page.\n\nI've been thinking about creativity lately. How it flows and ebbs like the tide. The Artist's Way has taught me that showing up is half the battle.",
  ),
  JournalEntry(
    id: 2,
    title: "Coding Journey",
    date: "Nov 7, 2025",
    preview: "Learning Flutter has been interesting...",
    content:
        "Learning Flutter has been an interesting experience. The declarative approach feels natural after Jetpack Compose, but there are subtle differences.\n\nToday I worked on understanding animations. The way Flutter handles them is elegant - AnimationController, Tween, and AnimatedBuilder work together beautifully.",
  ),
  JournalEntry(
    id: 3,
    title: "Creative Blocks",
    date: "Nov 6, 2025",
    preview: "Sometimes the hardest part is starting...",
    content:
        "Sometimes the hardest part is starting. I sat with my journal for 20 minutes before writing anything. But that's part of the process.\n\nThe morning pages don't have to be profound. They just have to be. Three pages of stream of consciousness, no editing, no judgment.",
  ),
];
// Journal List Screen
class JournalListScreen extends StatelessWidget {
  const JournalListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Journal'),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockEntries.length,
        itemBuilder: (context, index) {
          final entry = mockEntries[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () {
                // Use the custom page turn transition
                Navigator.push(
                  context,
                  PageTurnTransition(
                    child: JournalDetailScreen(entry: entry),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          entry.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Icon(Icons.book, color: Colors.deepPurple.shade300),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      entry.date,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      entry.preview,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to create new entry
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}