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
            leading: IconButton(
              icon: const Icon(Icons.arrow_back), // Change to your desired icon
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
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
                  child: Text(
                    widget.item.forumName!,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    widget.item.description!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Create post',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
