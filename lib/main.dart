// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:talabatcom_driver/cubit/check_phone_cubit/check_phone_cubit.dart';
import 'package:talabatcom_driver/cubit/driverinfo_cubit/driverinfo_cubit.dart';
import 'package:talabatcom_driver/cubit/list_orders_cubit/list_orders_cubit.dart';
import 'package:talabatcom_driver/cubit/login_cubit/login_cubit.dart';
import 'package:talabatcom_driver/cubit/trackdeatils_cuibt/orderdetails_cubit.dart';
import 'package:talabatcom_driver/cubit/update_pass_cubit/update_pass_cubit.dart';
import 'package:talabatcom_driver/cubit/verification_cubit/verification_cubit.dart';
import 'package:talabatcom_driver/helpers/utils/sharedPreferenceClass.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:talabatcom_driver/screens/splash_screen.dart';
import 'app/keys.dart';
import 'cubit/changestatus_cubit/changestatus_cubit.dart';
import 'cubit/forget_pass_cubit/forget_pass_cubit.dart';
import 'cubit/signup_cubit/signup_cubit.dart';
import 'helpers/lang/demo_localization.dart';
import 'helpers/lang/language_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  runApp(const TalabatcomDriver());
}

class TalabatcomDriver extends StatefulWidget {
  const TalabatcomDriver({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale locale) {
    _TalabatcomDriverState? state =
        context.findAncestorStateOfType<_TalabatcomDriverState>();
    state!.setLocale(locale);
  }

  @override
  State<TalabatcomDriver> createState() => _TalabatcomDriverState();
}

class _TalabatcomDriverState extends State<TalabatcomDriver> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
        selectedlang = _locale!.languageCode;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpCubit>(create: (context) => SignUpCubit()),
        BlocProvider<ForgetPassCubit>(create: (context) => ForgetPassCubit()),
        BlocProvider<VerificationCubit>(
            create: (context) => VerificationCubit()),
        BlocProvider<UpdatePassCubit>(create: (context) => UpdatePassCubit()),
        BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
        BlocProvider<ListOrdersCubit>(create: (context) => ListOrdersCubit()),
        BlocProvider<CheckPhoneCubit>(create: (context) => CheckPhoneCubit()),
        BlocProvider<TrackingCubit>(create: (context) => TrackingCubit()),
        BlocProvider<DriverInfoCubit>(create: (context) => DriverInfoCubit()),
        BlocProvider<ChangestatusCubit>(
            create: (context) => ChangestatusCubit())
      ],
      child: MaterialApp(
          title: 'Talabaccom Driver',
          builder: (context, widget) => ResponsiveWrapper.builder(
              BouncingScrollWrapper.builder(context, widget!),
              maxWidth: 1200,
              minWidth: 450,
              defaultScale: true,
              breakpoints: [
                const ResponsiveBreakpoint.resize(450, name: MOBILE),
                const ResponsiveBreakpoint.resize(800, name: TABLET),
                const ResponsiveBreakpoint.resize(1000, name: TABLET),
                const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
              ],
              background: Container(color: const Color(0xFFF5F5F5))),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blue,
              bottomSheetTheme: const BottomSheetThemeData(
                  backgroundColor: Colors.transparent)),
          localizationsDelegates: const [
            DemoLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: _locale,
          supportedLocales: const [
            Locale("en", "US"),
            Locale("ar", "SA"),
          ],
          localeResolutionCallback: (currentLocale, supportedLocales) {
            if (currentLocale != null) {
              for (Locale locale in supportedLocales) {
                if (currentLocale.languageCode == locale.languageCode) {
                  return currentLocale;
                }
              }
            }
            return supportedLocales.first;
          },
          home: SplashScreen()),
    );
  }
}
