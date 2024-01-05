import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/login/verify_email/cubit/verify_email_cubit.dart';
import 'package:heidi/src/presentation/main/login/verify_email/cubit/verify_email_state.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';


class VerifyEmailScreen extends StatefulWidget {
  final String link;

  const VerifyEmailScreen({super.key, required this.link});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  @override
  void initState() {
    AppBloc.verifyEmailCubit.verifyEmail(widget.link);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('verify_email'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<VerifyEmailCubit, VerifyEmailState>(
            builder: (context, state) => state.when(
                loading: () => const VerifyEmailLoading(),
                loaded: () => const VerifyEmailLoaded(),
                error: (msg) => const VerifyEmailFailed()),
          ),
        ),
      ),
    );
  }
}

class VerifyEmailFailed extends StatelessWidget {
  const VerifyEmailFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.close,
          size: 50,
        ),
        const SizedBox(height: 16),
        Text(
          Translate.of(context).translate("email_error_verified"),
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class VerifyEmailLoaded extends StatefulWidget {
  const VerifyEmailLoaded({super.key});

  @override
  State<VerifyEmailLoaded> createState() => _VerifyEmailLoadedState();
}

class _VerifyEmailLoadedState extends State<VerifyEmailLoaded> {
  @override
  void initState() {
    redirectLogin();
    super.initState();
  }

  void redirectLogin() async {
    await Future.delayed(const Duration(seconds: 4));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, Routes.signIn);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.done,
          size: 50,
        ),
        const SizedBox(height: 16),
        Text(
          Translate.of(context).translate("email_successfully_verified"),
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class VerifyEmailLoading extends StatelessWidget {
  const VerifyEmailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
