import 'package:bluebank_app/src/core/di/injector.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/bloc/auth_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            unauthenticated: () {
              context.go('/login');
            },
            error: (message) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            },
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Accounts'),
            actions: [
              IconButton(icon: const Icon(Icons.add), onPressed: () {}),
              IconButton(
                icon: const Icon(Icons.person_outline),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  context.read<AuthBloc>().add(AuthEvent.logout());
                },
              ),
            ],
          ),
          body: ListView(
            children: [
              _buildBalanceCard(),
              _buildActionButtons(),
              _buildAccountsSection(),
              _buildCardsSection(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance),
                label: 'Accounts',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.swap_horiz),
                label: 'Transfer',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.credit_card),
                label: 'Cards',
              ),
            ],
            currentIndex: 0,
            selectedItemColor: Colors.blue,
            onTap: (index) {},
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '\$24,000.58',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          const Row(
            children: [
              Icon(Icons.flag, color: Colors.white),
              SizedBox(width: 8.0),
              Text(
                'USD Global Balance',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(icon: Icons.arrow_downward, label: 'Deposit'),
          _buildActionButton(icon: Icons.arrow_upward, label: 'Send'),
          _buildActionButton(icon: Icons.request_quote, label: 'Request'),
          _buildActionButton(icon: Icons.more_horiz, label: 'More'),
        ],
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required String label}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.blue[100],
          child: Icon(icon, color: Colors.blue),
        ),
        const SizedBox(height: 8.0),
        Text(label),
      ],
    );
  }

  Widget _buildAccountsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Checking Accounts',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildAccountCard(
                  flag: '🇺🇸',
                  accountName: 'Checking Account ...2032',
                  balance: '\$22,021.32',
                  apy: '4.25% APY',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildAccountCard(
                  flag: '🇪🇺',
                  accountName: 'Ahorros para viaje',
                  balance: '€22,021.32',
                  apy: '4.25% APY',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAccountCard({
    required String flag,
    required String accountName,
    required String balance,
    required String apy,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(flag, style: const TextStyle(fontSize: 24)),
              Text(apy, style: const TextStyle(color: Colors.green)),
            ],
          ),
          const SizedBox(height: 16),
          Text(accountName),
          const SizedBox(height: 8),
          Text(
            balance,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildCardsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cards',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCard(
                  color: Colors.blue,
                  cardName: 'Blue Bank Platinum - 4307',
                  balance: '\$1,021.33',
                  textColor: Colors.white,
                ),
                const SizedBox(width: 16),
                _buildCard(
                  color: Colors.black,
                  cardName: 'Blue Bank Platinum - 4307',
                  balance: '\$1,021.33',
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required Color color,
    required String cardName,
    required String balance,
    required Color textColor,
  }) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Align(
            alignment: Alignment.topRight,
            child: Icon(Icons.more_horiz, color: Colors.white),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cardName, style: TextStyle(color: textColor)),
              const SizedBox(height: 8),
              Text(
                balance,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Current Balance',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
