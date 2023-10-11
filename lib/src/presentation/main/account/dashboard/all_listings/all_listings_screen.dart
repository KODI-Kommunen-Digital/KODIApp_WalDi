import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/presentation/main/account/dashboard/all_listings/cubit/all_listings_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/all_listings/cubit/all_listings_state.dart';

class AllListingsScreen extends StatelessWidget {
  final UserModel user;

  const AllListingsScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllListingsCubit, AllListingsState>(
        builder: (context, state) => state.maybeWhen(
            loading: () => const AllListingsLoading(),
            loaded: (posts) => AllListingsLoaded(user: user, posts: posts),
            orElse: () => ErrorWidget("Failed to load listings.")));
  }
}

class AllListingsLoading extends StatelessWidget {
  const AllListingsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

class AllListingsLoaded extends StatefulWidget {
  final List<ProductModel>? posts;
  final UserModel user;

  const AllListingsLoaded({required this.user, this.posts, super.key});

  @override
  State<AllListingsLoaded> createState() => _AllListingsLoadedState();
}

class _AllListingsLoadedState extends State<AllListingsLoaded> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
