// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:heidi/src/data/model/model_product.dart';
// import 'package:heidi/src/presentation/cubit/app_bloc.dart';
// import 'package:heidi/src/presentation/main/account/dashboard/test/cubit/test_cubit.dart';
// import 'package:heidi/src/presentation/main/account/dashboard/test/cubit/test_state.dart';
// import 'package:heidi/src/utils/configs/routes.dart';

// class TestScreen extends StatefulWidget {
//   const TestScreen({super.key});

//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {
//   @override
//   void initState() {
//     AppBloc.testCubit.onLoad();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             appBar: AppBar(
//               title: const Text("TestCases Appointment"),
//               actions: [
//                 TextButton(
//                   child: const Text("User"),
//                   onPressed: () {
//                     AppBloc.testCubit.fetchAppointments();
//                   },
//                 ),
//                 TextButton(
//                   child: const Text("Load"),
//                   onPressed: () {
//                     AppBloc.testCubit.onLoad();
//                   },
//                 )
//               ],
//             ),
//             body: BlocBuilder<TestCubit, TestState>(
//                 builder: (context, state) => state.maybeWhen(
//                     loading: () => const TestScreenLoading(),
//                     loaded: (posts) => TestScreenLoaded(
//                           posts: posts ?? [],
//                         ),
//                     orElse: () => ErrorWidget("Failed to load listings.")))));
//   }
// }

// class TestScreenLoading extends StatelessWidget {
//   const TestScreenLoading({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: CircularProgressIndicator(),
//     );
//   }
// }

// class TestScreenLoaded extends StatefulWidget {
//   final List<dynamic> posts;

//   const TestScreenLoaded({required this.posts, super.key});

//   @override
//   State<TestScreenLoaded> createState() => _TestScreenLoadedState();
// }

// class _TestScreenLoadedState extends State<TestScreenLoaded> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       padding: const EdgeInsets.all(0),
//       physics: const NeverScrollableScrollPhysics(),
//       itemBuilder: (context, index) {
//         final item = widget.posts[index];
//         return Padding(
//             padding: const EdgeInsets.only(bottom: 16),
//             child: Column(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     _onProductDetail(item);
//                   },
//                   child: SizedBox(
//                     height: 200,
//                     width: 400,
//                     child: Row(
//                       children: [
//                         Text(item.title),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         Text(item.id.toString())
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 IconButton(
//                     onPressed: () {
//                       AppBloc.testCubit.postAppointment(1);
//                     },
//                     icon: const Icon(Icons.add)),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextButton(
//                     onPressed: () {
//                       AppBloc.testCubit.editAppointment(1, 1);
//                     },
//                     child: const Text("edit appointment")),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextButton(
//                     onPressed: () {
//                       AppBloc.testCubit.deleteAppointment(1, 1, 1);
//                     },
//                     child: const Text("delete appointment")),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextButton(
//                     onPressed: () {
//                       AppBloc.testCubit.fetchOwnerBookings();
//                     },
//                     child: const Text("fetchOwnerBookings")),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextButton(
//                     onPressed: () {
//                       AppBloc.testCubit.fetchUserBookings();
//                     },
//                     child: const Text("fetchUserBookings")),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextButton(
//                     onPressed: () {
//                       AppBloc.testCubit.postBooking();
//                     },
//                     child: const Text("postBooking")),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextButton(
//                     onPressed: () {
//                       AppBloc.testCubit.deleteBooking();
//                     },
//                     child: const Text("delete booking"))
//               ],
//             ));
//       },
//       itemCount: widget.posts.length,
//     );
//   }

//   void _onProductDetail(ProductModel item) {
//     Navigator.pushNamed(context, Routes.productDetail, arguments: item);
//   }
// }
