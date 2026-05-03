import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'app/workflow/domain/focus_session.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: FocusyApp()));
}

final isarProvider = FutureProvider<Isar>((ref) async {
  final directory = await getApplicationDocumentsDirectory();
  return Isar.open(
    [FocusSessionSchema],
    name: 'focusy',
    directory: directory.path,
  );
});

class FocusyApp extends StatelessWidget {
  const FocusyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Focusy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isar = ref.watch(isarProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Focusy')),
      body: Center(
        child: isar.when(
          data: (_) => const Text('Flutter + Isar setup is ready.'),
          loading: () => const CircularProgressIndicator(),
          error: (error, _) => Text('Isar init failed: $error'),
        ),
      ),
    );
  }
}
