import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_multifilter.dart';
import 'package:heidi/src/utils/translate.dart';

class FilterScreen extends StatefulWidget {
  final MultiFilter multiFilter;

  const FilterScreen({super.key, required this.multiFilter});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Filter"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (widget.multiFilter.hasLocationFilter == true)
              _buildLocationFilter(),
            if (widget.multiFilter.hasListProductFilter == true)
              _buildListProductFilter(),
            if (widget.multiFilter.hasListingStatusFilter == true)
              _buildListingStatusFilter(),
            if (widget.multiFilter.hasForumGroupFilter == true)
              _buildForumGroupFilter(),
          ],
        ),
      ),
    ));
  }

  Widget _buildLocationFilter() {
    return Expanded(
      child: Column(
        children: [
          Text(Translate.of(context).translate('choose_city')),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              children: widget.multiFilter.cities!.map((city) {
                return ChoiceChip(
                  label: Text(city.title),
                  selected: city.id == widget.multiFilter.currentLocation!,
                  onSelected: (selected) {
                    //Handle selected city
                  },
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListingStatusFilter() {
    return Container();
  }

  Widget _buildForumGroupFilter() {
    return Container();
  }

  Widget _buildListProductFilter() {
    return Container();
  }
}
