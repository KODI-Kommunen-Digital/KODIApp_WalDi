import 'package:flutter/material.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/translate.dart';

class GroupMembersScreen extends StatefulWidget {
  final int groupId;

  const GroupMembersScreen(this.groupId, {super.key});

  @override
  State<GroupMembersScreen> createState() => _GroupMembersScreenState();
}

class _GroupMembersScreenState extends State<GroupMembersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('members'),
        ),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 8),
            itemCount: 17,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 10, 8, 10),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: ClipOval(
                            child: Image.network(
                          Application.defaultPicturesURL,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Claudia Muler',
                              maxLines: 1,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            // description,
                            const SizedBox(height: 4),
                            Text(
                              '12.06.2023',
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert), // Three dots icon
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
