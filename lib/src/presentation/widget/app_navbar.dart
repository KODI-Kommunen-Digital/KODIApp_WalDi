import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_sort.dart';
import 'package:heidi/src/utils/translate.dart';

enum PageType { map, list }

class AppNavBar extends StatelessWidget {
  final PageType pageStyle;
  final SortModel? currentSort;
  final VoidCallback onChangeSort;
  final VoidCallback onFilter;
  final IconData iconModeView;

  const AppNavBar({
    Key? key,
    this.pageStyle = PageType.list,
    this.currentSort,
    required this.onChangeSort,
    required this.iconModeView,
    required this.onFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String sortTitle = Translate.of(context).translate('sort');
    if (currentSort != null) {
      sortTitle = Translate.of(context).translate(currentSort!.title);
    }
    return SafeArea(
      top: false,
      bottom: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.swap_vert),
                onPressed: onChangeSort,
              ),
              Text(
                sortTitle,
                style: Theme.of(context).textTheme.titleSmall,
              )
            ],
          ),
          Row(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    height: 24,
                    child: VerticalDivider(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.track_changes),
                onPressed: onFilter,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Text(
                  Translate.of(context).translate('filter'),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
