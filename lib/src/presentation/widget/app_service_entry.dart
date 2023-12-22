import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_service_entry.dart';

class BuildServiceEntry extends StatefulWidget {
  final ServiceEntry entry;
  final int index;
  final ValueSetter<ServiceEntry>? onEntryCallback;
  final ValueSetter<int>? onDelete;

  const BuildServiceEntry({
    super.key,
    required this.entry,
    this.onEntryCallback,
    this.onDelete,
    required this.index,
  });

  @override
  State<BuildServiceEntry> createState() => _BuildServiceEntryState();
}

class _BuildServiceEntryState extends State<BuildServiceEntry> {
  ServiceEntry? entry;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    entry = widget.entry;
    return Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: entry?.controller,
                decoration: const InputDecoration(
                  labelText: 'Add Service Name',
                  border: OutlineInputBorder(), // Add this line for border
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                widget.onDelete!(widget.index);
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: <Widget>[
            const Text('Duration:'),
            const SizedBox(width: 20),
            DropdownButton<int>(
              value: entry?.selectedMinutes,
              onChanged: (value) {
                setState(() {
                  entry?.selectedMinutes = value!;
                  widget.onEntryCallback!(entry!);
                });
              },
              items: List.generate(
                5,
                (index) => DropdownMenuItem<int>(
                  value: (index + 1) * 15,
                  child: Text('${(index + 1) * 15} mins'),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(
          thickness: 3,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
