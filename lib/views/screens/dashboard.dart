import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_flutter_app/bloc/wallet_bloc.dart';
import 'package:simple_flutter_app/res/colors.dart';
import 'package:simple_flutter_app/res/dimens.dart';
import 'package:simple_flutter_app/res/styles.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late WalletBloc _walletBloc;

  @override
  Widget build(BuildContext context) {
    _walletBloc = context.read<WalletBloc>();

    return BlocConsumer<WalletBloc, WalletState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.windowBackground,
          body: ListView(
            children: [
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.green,
                      child: Text(
                        'EO',
                        style: AppStyles.textBody1.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Text(
                      'Emmanuel Osei',
                      style: AppStyles.textBody1,
                    ),
                    const Expanded(child: SizedBox()),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.settings_outlined))
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: Dimens.circularBorderRadius),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Unique ID', style: AppStyles.textBody4),
                        SizedBox(height: 5),
                        Text(
                          'G4TSDFG4',
                          style: AppStyles.textHeadline3,
                        ),
                        SizedBox(height: 15),
                        Text('Balance', style: AppStyles.textBody4),
                        SizedBox(height: 5),
                        Text(
                          'GHc 12,000',
                          style: AppStyles.textHeadline3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
                const Text('Transactions', style: AppStyles.textTitle2),
          
            ],
          ),
        );
      },
    );
  }
}
