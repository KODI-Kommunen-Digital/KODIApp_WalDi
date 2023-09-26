import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_forum_group.dart';
import 'package:heidi/src/utils/configs/application.dart';

class GroupDetailsScreen extends StatefulWidget {
  final ForumGroupModel item;

  const GroupDetailsScreen(this.item, {super.key});

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            // Height when expanded
            floating: false,
            // Whether the app bar should stay at the top when scrolling
            pinned: true,
            // Whether the app bar should remain visible after scrolling
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('SilverAppBar Example'),
              background: Image.network(
                widget.item.image != null
                    ? "${Application.picturesURL}${widget.item.image}"
                    : Application.defaultPicturesURL,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    'Scrollable Content Goes Here',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Create post', style: TextStyle(color: Colors.white)),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
