import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cr_info_cubit.dart';
import '../cubit/cr_info_state.dart';
import '../widgets/cr_info_app_bar.dart';
import '../widgets/cr_info_builder.dart';
import '../widgets/custom_snackbar.dart';

class CrInfoPage extends StatefulWidget {
  const CrInfoPage({super.key});

  @override
  State<CrInfoPage> createState() => _CrInfoPageState();
}

class _CrInfoPageState extends State<CrInfoPage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearch() {
    final crNumber = _controller.text.trim();
    context.read<CrInfoCubit>().fetchCrInfo(crNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        toolbarHeight: 68,
        backgroundColor: Colors.transparent,
        title: CrInfoAppBar(controller: _controller, onSearch: _onSearch),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          children: [
            const SizedBox(height: 22),
            Expanded(
              child: BlocConsumer<CrInfoCubit, CrInfoState>(
                listener: (context, state) {
                  if (state is CrInfoError) {
                    showCustomSnackbar(
                      context,
                      message: state.message,
                      isError: true,
                      duration: const Duration(seconds: 4),
                    );
                  }
                },
                builder: (context, state) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    switchInCurve: Curves.easeIn,
                    switchOutCurve: Curves.easeOut,
                    child: _buildBody(state),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(CrInfoState state) {
    if (state is CrInfoLoading) {
      return const Center(
        key: ValueKey('loading'),
        child: CircularProgressIndicator(color: Colors.deepPurpleAccent),
      );
    }

    if (state is CrInfoLoaded) {
      return CrInfoBuilder(key: const ValueKey('loaded'), data: state.crInfo);
    }

    return Center(
      key: const ValueKey('empty'),
      child: Text(
        "أدخل رقم السجل ثم اضغط بحث",
        style: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
