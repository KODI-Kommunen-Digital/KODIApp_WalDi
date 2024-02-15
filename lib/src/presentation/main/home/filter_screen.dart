import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/presentation/main/account/dashboard/my_groups/cubit/my_groups_cubit.dart';
import 'package:heidi/src/presentation/main/home/list_product/cubit/list_cubit.dart';
import 'package:heidi/src/utils/translate.dart';

class FilterScreen extends StatefulWidget {
  final ProductFilter? currentListProductFilter; //ListGroup filter
  final GroupFilter? currentForumGroupFilter; //Forum group filter
  final int? currentListingStatus; //Listing status in All Listings

  final List<CategoryModel>? cities; //All cities
  final int? currentLocation; //Location IDs

  const FilterScreen(
      {super.key,
      this.currentLocation,
      this.currentListingStatus,
      this.currentForumGroupFilter,
      this.currentListProductFilter,
      this.cities});

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
            if (widget.currentLocation != null) _buildLocationFilter(),
            if (widget.currentListProductFilter != null)
              _buildListProductFilter(),
            if (widget.currentListingStatus != null)
              _buildListingStatusFilter(),
            if (widget.currentForumGroupFilter != null)
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
              children: widget.cities!.map((city) {
                return ChoiceChip(
                  label: Text(city.title),
                  selected: city.id == widget.currentLocation!,
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
