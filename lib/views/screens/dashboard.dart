import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_flutter_app/bloc/wallet_bloc.dart';
import 'package:simple_flutter_app/res/colors.dart';
import 'package:simple_flutter_app/res/dimens.dart';
import 'package:simple_flutter_app/res/enums.dart';
import 'package:simple_flutter_app/res/styles.dart';
import 'package:simple_flutter_app/res/utils.dart';
import 'package:simple_flutter_app/views/screens/settings.dart';

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
          bottomNavigationBar: PreferredSize(
            preferredSize: const Size(double.infinity, 5),
            child: AnimatedContainer(
              width: double.infinity,
              height: 5,
              color: AppColors.red,
              duration: const Duration(milliseconds: 350),
            ),
          ),
          body: ListView(
            children: [
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.colorBorderGraph,
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
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.help_outline_outlined,
                        color: AppColors.yellow,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(Utils.pageRoute(SettingsScreen()));
                      },
                      icon: const Icon(
                        Icons.settings_outlined,
                        color: AppColors.colorPrimary,
                      ),
                    ),
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
                      children: [
                        Text('Unique ID', style: AppStyles.textBody4),
                        SizedBox(height: 5),
                        Text(
                          'G4TSDFG4',
                          style: AppStyles.textHeadline3
                              .copyWith(fontWeight: FontWeight.w300, fontSize: 21),
                        ),
                        SizedBox(height: 15),
                        Text('Balance', style: AppStyles.textBody4),
                        SizedBox(height: 5),
                        Text(
                          Utils.formatMoney(12340, 'GHc'),
                          style: AppStyles.textHeadline3.copyWith(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('Transactions', style: AppStyles.textTitle2),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: Dimens.circularBorderRadius),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 5),
                      TransactionItem(
                        transactionType: TransactionType.credit,
                        successful: true,
                        amount: 12300,
                        account: 'Jason Smith',
                        currency: 'GHc',
                        description: 'Received Money',
                      ),
                      TransactionItem(
                        transactionType: TransactionType.debit,
                        successful: true,
                        amount: 200,
                        account: 'Transfer to Bank',
                        currency: 'GHc',
                        description: 'Charges',
                      ),
                      TransactionItem(
                        transactionType: TransactionType.debit,
                        successful: false,
                        amount: 200,
                        account: 'Transfer to Bank',
                        currency: 'GHc',
                        description: 'Charges',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TransactionItem extends StatelessWidget {
  final TransactionType transactionType;
  final bool successful;
  final double amount;
  final String currency;
  final String description;
  final String account;

  const TransactionItem({
    Key? key,
    required this.transactionType,
    required this.successful,
    required this.amount,
    required this.description,
    required this.account,
    required this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: successful ? AppColors.green : AppColors.red,
        child: Icon(
          () {
            switch (transactionType) {
              case TransactionType.debit:
                return Icons.remove_circle_outline;
              case TransactionType.credit:
                return Icons.add_circle_outline;
              case TransactionType.transfer:
                return Icons.arrow_circle_right_outlined;
            }
          }(),
          color: AppColors.white,
        ),
      ),
      title: Text(
        description,
        style: AppStyles.textBody2.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        account,
        style: AppStyles.textBody3.copyWith(
          color: AppColors.textPrimaryLight,
        ),
      ),
      trailing: Text(
        Utils.formatMoney(amount, currency),
        style: AppStyles.textBody3.copyWith(
          color: successful ? AppColors.green : AppColors.red,
        ),
      ),
    );
  }
}
