import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_multifilter.dart';
import 'package:heidi/src/presentation/main/home/list_product/cubit/list_cubit.dart';
import 'package:heidi/src/utils/translate.dart';

class FilterScreen extends StatefulWidget {
  final MultiFilter multiFilter;

  const FilterScreen({super.key, required this.multiFilter});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int? currentCity;
  int? currentCategory;
  int? currentListingStatus;
  ProductFilter? currentProductEventFilter;

  @override
  void initState() {
    super.initState();
    currentCity = widget.multiFilter.currentLocation;
    currentCategory = widget.multiFilter.currentCategory;
    currentProductEventFilter = widget.multiFilter.currentProductEventFilter;
    currentListingStatus = widget.multiFilter.currentListingStatus;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Filter"),
      ),
      body: SingleChildScrollView(
        child: PopScope(
          canPop: false,
          onPopInvoked: (pop) async {
            if (pop) return;
            Navigator.pop(
                context,
                MultiFilter(
                    currentProductEventFilter: currentProductEventFilter,
                    currentListingStatus: currentListingStatus,
                    currentCategory: currentCategory,
                    currentLocation: currentCity,
                    hasLocationFilter: widget.multiFilter.hasLocationFilter,
                    hasProductEventFilter:
                        widget.multiFilter.hasProductEventFilter,
                    hasListingStatusFilter:
                        widget.multiFilter.hasListingStatusFilter,
                    hasCategoryFilter: widget.multiFilter.hasCategoryFilter));
          },
          child: Column(
            children: [
              if (widget.multiFilter.hasLocationFilter == true)
                ..._buildLocationFilter(),
              if (widget.multiFilter.hasProductEventFilter == true)
                ..._buildProductEventFilter(),
              if (widget.multiFilter.hasListingStatusFilter == true)
                ..._buildListingStatusFilter(),
              if (widget.multiFilter.hasCategoryFilter == true)
                ..._buildCategoryFilter(),
            ],
          ),
        ),
      ),
    ));
  }

  List<Widget> _buildLocationFilter() {
    return [
      const SizedBox(
        height: 8,
      ),
      Center(
          child: Text(
        Translate.of(context).translate('choose_city'),
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
      )),
      Container(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(spacing: 8.0, children: [
          ChoiceChip(
            label: Text(Translate.of(context).translate('select_location')),
            selected: 0 == currentCity,
            onSelected: (selected) {
              setState(() {
                currentCity = 0;
              });
            },
          ),
          ...widget.multiFilter.cities!.map((city) {
            return ChoiceChip(
              label: Text(city.title),
              selected: city.id == currentCity,
              onSelected: (selected) {
                setState(() {
                  currentCity = city.id;
                });
              },
            );
          }),
        ]),
      )
    ];
  }

  List<Widget> _buildListingStatusFilter() {
    return [
      const SizedBox(
        height: 8,
      ),
      Center(
          child: Text(
        Translate.of(context).translate('choose_listing_status'),
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
      )),
      Container(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(spacing: 8.0, children: [
          ChoiceChip(
            label: Text(Translate.of(context).translate('all')),
            selected: currentListingStatus == 0,
            onSelected: (selected) {
              setState(() {
                currentListingStatus = 0;
              });
            },
          ),
          ChoiceChip(
            label: Text(Translate.of(context).translate('active')),
            selected: currentListingStatus == 1,
            onSelected: (selected) {
              setState(() {
                currentListingStatus = 1;
              });
            },
          ),
          ChoiceChip(
            label: Text(Translate.of(context).translate('inactive')),
            selected: currentListingStatus == 2,
            onSelected: (selected) {
              setState(() {
                currentListingStatus = 2;
              });
            },
          ),
          ChoiceChip(
            label: Text(Translate.of(context).translate('under_review')),
            selected: currentListingStatus == 3,
            onSelected: (selected) {
              setState(() {
                currentListingStatus = 3;
              });
            },
          ),
        ]),
      )
    ];
  }

  List<Widget> _buildProductEventFilter() {
    return [
      const SizedBox(
        height: 8,
      ),
      Center(
          child: Text(
        Translate.of(context).translate('choose_time_period'),
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
      )),
      Container(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(spacing: 8.0, children: [
          ChoiceChip(
            label: Text(Translate.of(context).translate('all')),
            selected: currentProductEventFilter == null,
            onSelected: (selected) {
              setState(() {
                currentProductEventFilter = null;
              });
            },
          ),
          ChoiceChip(
            label: Wrap(
              spacing: 4.0,
              children: [
                Text(Translate.of(context).translate('this_month')),
                Icon(
                  Icons.calendar_today,
                  color: Theme.of(context).textTheme.bodyLarge?.color ??
                      Colors.white,
                  size: 18,
                )
              ],
            ),
            selected: currentProductEventFilter == ProductFilter.month,
            onSelected: (selected) {
              setState(() {
                currentProductEventFilter = ProductFilter.month;
              });
            },
          ),
          ChoiceChip(
            label: Wrap(
              spacing: 4.0,
              children: [
                Text(Translate.of(context).translate('this_week')),
                Icon(
                  Icons.calendar_today,
                  color: Theme.of(context).textTheme.bodyLarge?.color ??
                      Colors.white,
                  size: 18,
                )
              ],
            ),
            selected: currentProductEventFilter == ProductFilter.week,
            onSelected: (selected) {
              setState(() {
                currentProductEventFilter = ProductFilter.week;
              });
            },
          ),
          ChoiceChip(
            label: Wrap(
              spacing: 4.0,
              children: [
                Text(Translate.of(context).translate('today')),
                Icon(
                  Icons.calendar_today,
                  color: Theme.of(context).textTheme.bodyLarge?.color ??
                      Colors.white,
                  size: 18,
                )
              ],
            ),
            selected: currentProductEventFilter == ProductFilter.day,
            onSelected: (selected) {
              setState(() {
                currentProductEventFilter = ProductFilter.day;
              });
            },
          ),
        ]),
      )
    ];
  }

  List<Widget> _buildCategoryFilter() {
    return [
      const SizedBox(
        height: 8,
      ),
      Center(
          child: Text(
        Translate.of(context).translate('input_category'),
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
      )),
      Container(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(spacing: 8.0, children: [
          ChoiceChip(
            label: Text(Translate.of(context).translate('all_Categories')),
            selected: 0 == currentCategory,
            onSelected: (selected) {
              setState(() {
                currentCategory = 0;
              });
            },
          ),
          ...widget.multiFilter.categories!.map((category) {
            return ChoiceChip(
              label: Text(category.title),
              selected: category.id == currentCategory,
              onSelected: (selected) {
                setState(() {
                  currentCategory = category.id;
                });
              },
            );
          }),
        ]),
      )
    ];
  }
}
