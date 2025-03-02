import 'package:arcade/screens/startscreen.dart';
import 'package:arcade/utils/colors.dart';
import 'package:arcade/utils/dimension.dart';
import 'package:arcade/utils/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Dimension dimension;

    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      dimension = Dimension(MediaQuery.of(context).size.height,
          MediaQuery.of(context).size.width);
    } else {
      dimension = Dimension(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height);
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Dimension(0, 0)),
        ChangeNotifierProvider(create: (_) => DynamicTheming()),
      ],
      builder: (context, child) {
        final dynamicTheme = context.watch<DynamicTheming>();
        return MaterialApp(
          title: 'Anaconrelo\'s Arcade',
          theme: ThemeData(
            colorScheme: ColorScheme(
                brightness: Brightness.light,
                primary: dynamicTheme.themeData?.primaryColor ??
                    AppColors.engineeringOrange,
                onPrimary: AppColors.maroon,
                secondary:
                    dynamicTheme.themeData?.secondaryColor ?? AppColors.poppy,
                onSecondary: AppColors.bloodRed,
                error: AppColors.pennRed,
                onError: Colors.red,
                surface: Colors.white,
                onSurface: Colors.black),
            textTheme: TextTheme(
              displayLarge: GoogleFonts.inter(
                fontSize: 96,
                fontWeight: FontWeight.w300,
                letterSpacing: -1.5,
              ),
              displayMedium: GoogleFonts.inter(
                fontSize: 60,
                fontWeight: FontWeight.w300,
                letterSpacing: -0.5,
              ),
              displaySmall:
                  GoogleFonts.inter(fontSize: 48, fontWeight: FontWeight.w400),
              headlineMedium: GoogleFonts.inter(
                fontSize: 34,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.25,
              ),
              headlineSmall: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
              titleLarge: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.15,
              ),
              titleMedium: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.15,
              ),
              titleSmall: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.1,
              ),
              bodyLarge: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
              ),
              bodyMedium: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.25,
              ),
              bodySmall: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.4,
              ),
              labelLarge: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.25,
              ),
              labelSmall: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.5,
              ),
            ),
            dialogBackgroundColor: dynamicTheme.themeData?.primaryColor ??
                AppColors.engineeringOrange,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: dynamicTheme.themeData?.primaryColor ??
                    AppColors.engineeringOrange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    dimension.getWidth(16),
                  ),
                ),
              ),
            ),
            scaffoldBackgroundColor: AppColors.engineeringOrange,
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.engineeringOrange,
              foregroundColor: Colors.white,
            ),
            useMaterial3: true,
            brightness: Brightness.light,
            snackBarTheme: SnackBarThemeData(
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  dimension.getWidth(16),
                ),
              ),
            ),
          ),
          builder: (context, child) {
            return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child!);
          },
          home: const OrientationChangeHandler(),
        );
      },
    );
  }
}

class OrientationChangeHandler extends StatelessWidget {
  const OrientationChangeHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final dimension = Provider.of<Dimension>(context, listen: false);
    final mediaQuery = MediaQuery.of(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Update dimensions after the frame has been built
      if (mediaQuery.orientation == Orientation.portrait) {
        dimension.updateDimensions(
            mediaQuery.size.height, mediaQuery.size.width);
      } else {
        dimension.updateDimensions(
            mediaQuery.size.width, mediaQuery.size.height);
      }
    });

    return const StartScreen();
  }
}
