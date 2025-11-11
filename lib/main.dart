import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_management_client/common/app_color.dart';
import 'package:my_management_client/core/session.dart';
import 'package:my_management_client/data/models/solution_model.dart';
import 'package:my_management_client/presentation/pages/account_page.dart';
import 'package:my_management_client/presentation/pages/agenda/add_agenda_page.dart';
import 'package:my_management_client/presentation/pages/agenda/all_agenda_page.dart';
import 'package:my_management_client/presentation/pages/agenda/detail_agenda_page.dart';
import 'package:my_management_client/presentation/pages/chat_ai_page.dart';
import 'package:my_management_client/presentation/pages/dashboard_page.dart';
import 'package:my_management_client/presentation/pages/login_page.dart';
import 'package:my_management_client/presentation/pages/mood/choose_mood_page.dart';
import 'package:my_management_client/presentation/pages/register_page.dart';
import 'package:my_management_client/presentation/pages/solution/add_solution_page.dart';
import 'package:my_management_client/presentation/pages/solution/detail_solution_page.dart';
import 'package:my_management_client/presentation/pages/solution/update_solution_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColor.primary,
        scaffoldBackgroundColor: AppColor.surface,
        colorScheme: const ColorScheme.light(
          primary: AppColor.primary,
          secondary: AppColor.secondary,
          surface: AppColor.surface,
          surfaceContainer: AppColor.surfaceContainer,
          error: AppColor.error,
        ),
        textTheme: GoogleFonts.interTextTheme(),
        shadowColor: AppColor.primary.withValues(alpha: 0.3),
      ),
      home: FutureBuilder(
        future: Session.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.data == null) return const LoginPage();

          return const DashboardPage();
        },
      ),
      routes: {
        LoginPage.routeName: (context) => const LoginPage(),
        DashboardPage.routeName: (context) => const DashboardPage(),
        RegisterPage.routeName: (context) => const RegisterPage(),
        AccountPage.routeName: (context) => const AccountPage(),
        ChooseMoodPage.routeName: (context) => const ChooseMoodPage(),
        AllAgendaPage.routeName: (context) => const AllAgendaPage(),
        AddAgendaPage.routeName: (context) => const AddAgendaPage(),
        DetailAgendaPage.routeName: (context) {
          int agendaId = ModalRoute.settingsOf(context)?.arguments as int;
          return DetailAgendaPage(agendaId: agendaId);
        },
        AddSolutionPage.routeName: (context) => const AddSolutionPage(),
        UpdateSolutionPage.routeName: (context) {
          SolutionModel solution =
              ModalRoute.settingsOf(context)?.arguments as SolutionModel;
          return UpdateSolutionPage(solution: solution);
        },
        DetailSolutionPage.routeName: (context) {
          int solutionId = ModalRoute.settingsOf(context)?.arguments as int;
          return DetailSolutionPage(solutionId: solutionId);
        },
        ChatAIPage.routeName: (context) => const ChatAIPage(),
      },
    );
  }
}
