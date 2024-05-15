import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:heidi/firebase_options.dart';
import 'package:heidi/src/data/remote/api/firebase_api.dart';
import 'package:heidi/src/data/remote/local/category_manager.dart';
import 'package:heidi/src/data/repository/forum_repository.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/main_screen.dart';
import 'package:heidi/src/presentation/cubit/bloc.dart';
import 'package:heidi/src/presentation/main/splash_screen/splash_screen.dart';
import 'package:heidi/src/utils/adapters/formdata_adapter.dart';
import 'package:heidi/src/utils/configs/language.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/heidi_bloc_observer.dart';
import 'package:heidi/src/utils/language_manager.dart';
import 'package:heidi/src/utils/logging/bloc_logger.dart';
import 'package:heidi/src/utils/logging/crashlytics_log_printer.dart';
import 'package:heidi/src/utils/logging/drift_logger.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loggy/loggy.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:upgrader/upgrader.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FormDataAdapter());
  WidgetsFlutterBinding.ensureInitialized();
  Loggy.initLoggy(
    logPrinter: FirebaseCrashlyticsLogPrinter(),
    filters: [
      BlacklistFilter([
        BlocLoggy,
        DriftLoggy,
      ])
    ],
  );
  await Hive.initFlutter();
  final prefBox = await Preferences.openBox();
  Bloc.observer = HeidiBlocObserver();
  await Upgrader.clearSavedSettings();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseApi(globalNavKey, prefBox).initNotifications();
  await dotenv.load(fileName: "assets/env/.envAuf");
  await CategoryManager.loadCategories();

  await SentryFlutter.init((options) {
    options.dsn =
        'https://a4fb5224118623425d802bf0acaf087b@o4506393481510912.ingest.sentry.io/4506393482493952';
    options.tracesSampleRate = 0.01;
  }, appRunner: () => runApp(HeidiApp(prefBox)));

}

final globalNavKey = GlobalKey<NavigatorState>();

class HeidiApp extends StatefulWidget {
  final Preferences prefBox;

  const HeidiApp(
    this.prefBox, {
    super.key,
  });

  @override
  State<HeidiApp> createState() => _HeidiAppState();
}

class _HeidiAppState extends State<HeidiApp> {
  @override
  void initState() {
    super.initState();
    AppBloc.applicationCubit.onSetup();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider(
          create: (context) => ListRepository(widget.prefBox),
        ),
        RepositoryProvider(
          create: (context) => ForumRepository(widget.prefBox),
        )
      ],
      child: MultiBlocProvider(
        providers: AppBloc.providers,
        child: BlocBuilder<LanguageCubit, Locale>(
          builder: (context, lang) {
            return BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, theme) {
                return ChangeNotifierProvider(
                  create: (_) => LanguageManager(),
                  child: MaterialApp(
                    navigatorKey: globalNavKey,
                    debugShowCheckedModeBanner: false,
                    theme: theme.lightTheme,
                    darkTheme: theme.darkTheme,
                    onGenerateRoute: Routes.generateRoute,
                    localizationsDelegates: const [
                      Translate.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: AppLanguage.supportLanguage,
                    home: Scaffold(
                      body: BlocBuilder<ApplicationCubit, ApplicationState>(
                        builder: (context, state) {
                          if (state == const ApplicationState.loaded()) {
                            return const MainScreen();
                          }
                          if (state == const ApplicationState.loading()) {
                            return const SplashScreen();
                          }
                          return const MainScreen();
                        },
                      ),
                    ),
                    builder: (context, child) {
                      final data = MediaQuery.of(context).copyWith(
                        textScaleFactor: theme.textScaleFactor,
                      );
                      return MediaQuery(
                        data: data,
                        child: child!,
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
