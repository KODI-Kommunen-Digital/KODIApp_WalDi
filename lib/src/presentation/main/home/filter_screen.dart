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
  ProductFilter? currentProductEventFilter;

  @override
  void initState() {
    super.initState();
    currentCity = widget.multiFilter.currentLocation;
    currentProductEventFilter = widget.multiFilter.currentProductEventFilter;
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
        child: WillPopScope(
          onWillPop: () async {
            Navigator.pop(
                context,
                MultiFilter(
                    currentLocation: currentCity,
                    currentProductEventFilter: currentProductEventFilter));
            return false;
          },
          child: Column(
            children: [
              if (widget.multiFilter.hasLocationFilter == true)
                ..._buildLocationFilter(),
              if (widget.multiFilter.hasProductEventFilter == true)
                ..._buildProductEventFilter(),
              if (widget.multiFilter.hasListingStatusFilter == true)
                _buildListingStatusFilter(),
              if (widget.multiFilter.hasForumGroupFilter == true)
                _buildForumGroupFilter(),
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
          }).toList(),
        ]),
      )
    ];
  }

  Widget _buildListingStatusFilter() {
    return Container();
  }

  Widget _buildForumGroupFilter() {
    return Container();
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
                const Icon(
                  Icons.calendar_today,
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
                const Icon(
                  Icons.calendar_today,
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
        ]),
      )
    ];
  }
}
