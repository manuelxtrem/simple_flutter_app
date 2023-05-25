import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_flutter_app/bloc/auth_bloc.dart';
import 'package:simple_flutter_app/res/colors.dart';
import 'package:simple_flutter_app/res/styles.dart';
import 'package:simple_flutter_app/views/commons/button.dart';
import 'package:simple_flutter_app/views/commons/loading.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late AuthBloc _authBloc;

  @override
  Widget build(BuildContext context) {
    _authBloc = context.read<AuthBloc>();

    return BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return LoadingOverlay(
            enabled: state is AuthLoading,
            message: (state is AuthLoading) ? state.message : null,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Settings',
                  style: AppStyles.textTitle1.copyWith(color: Colors.white),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.help_outline),
                  ),
                ],
              ),
              body: ListView(
                children: [
                  _buildSectionHeader('Account'),
                  _buildListItem('Personal Info'),
                  _buildListItem('Security'),
                  _buildListItem('KYC'),
                  _buildSectionHeader('Rewards & Loyalty'),
                  _buildListItem('Rewards'),
                  _buildSectionHeader('Support'),
                  _buildListItem('Pending & Ongoing Support Tickets'),
                  _buildSectionHeader('Integrations'),
                  _buildListItem('WhatsApp Integration'),
                  const SizedBox(height: 20),
                  Center(
                    child: AppButton(
                      text: 'LOGOUT',
                      color: AppColors.red,
                      onPressed: () {
                        _authBloc.add(LogoutAuthEvent());
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title.toUpperCase(),
        style: AppStyles.textBody3.copyWith(
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildListItem(String title) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // Handle tapping on the list item
        // You can navigate to the corresponding sub-view here
      },
    );
  }
}
