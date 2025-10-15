import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utils/constants/colors.dart';

// ==================== CONTROLLERS ====================

class NurseEarningsController extends GetxController {
  final totalEarnings = 45000.0.obs;
  final monthlyEarnings = 12000.0.obs;
  final weeklyEarnings = 3500.0.obs;
  final pendingAmount = 2500.0.obs;
  final selectedPeriod = 'This Month'.obs;
  final earningsHistory = <EarningModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadEarnings();
  }

  void loadEarnings() {
    earningsHistory.value = [
      EarningModel(
        patientName: 'Visit with Eleanor',
        amount: 1500.0,
        date: DateTime(2025, 10, 11),
        status: 'Completed',
        careType: 'Health Care',
      ),
      EarningModel(
        patientName: 'Visit with Ahmed Ali',
        amount: 2000.0,
        date: DateTime(2025, 10, 8),
        status: 'Completed',
        careType: 'Sitter',
      ),
      EarningModel(
        patientName: 'Visit with Maha Mohammed',
        amount: 1800.0,
        date: DateTime(2025, 10, 5),
        status: 'Completed',
        careType: 'Health Care',
      ),
      EarningModel(
        patientName: 'Visit with Youssef Hassan',
        amount: 2200.0,
        date: DateTime(2025, 10, 3),
        status: 'Pending',
        careType: 'Emergency',
      ),
      EarningModel(
        patientName: 'Visit with Laila Mahmoud',
        amount: 1600.0,
        date: DateTime(2025, 10, 1),
        status: 'Completed',
        careType: 'Health Care',
      ),
    ];
  }

  void changePeriod(String period) {
    selectedPeriod.value = period;
    Get.snackbar('Period', 'Showing earnings for $period');
  }

  void requestWithdrawal() {
    Get.snackbar('Withdrawal', 'Withdrawal request submitted');
  }

  void viewEarningDetails(EarningModel earning) {
    Get.snackbar('Details', 'Viewing details for ${earning.patientName}');
  }

  void handleNotificationTap() {
    Get.snackbar('Notifications', 'Opening notifications');
  }
}

// ==================== MODELS ====================

class EarningModel {
  final String patientName;
  final double amount;
  final DateTime date;
  final String status;
  final String careType;

  EarningModel({
    required this.patientName,
    required this.amount,
    required this.date,
    required this.status,
    required this.careType,
  });
}

// ==================== MAIN SCREEN ====================

class NurseEarningsScreen extends StatelessWidget {
  const NurseEarningsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NurseEarningsController());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: EarningsAppBar(
        onNotificationTap: controller.handleNotificationTap,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                EarningsSummaryCard(controller: controller),
                const SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SectionHeading(title: 'Earnings History'),
                          PeriodFilterButton(controller: controller),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Obx(() => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.earningsHistory.length,
                        itemBuilder: (context, index) {
                          final earning = controller.earningsHistory[index];
                          return EarningHistoryCard(
                            earning: earning,
                            onTap: () => controller.viewEarningDetails(earning),
                          );
                        },
                      )),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ==================== WIDGETS ====================

class EarningsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onNotificationTap;

  const EarningsAppBar({
    Key? key,
    required this.onNotificationTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back, color: Colors.black87),
      ),
      title: const Text(
        'My Earnings',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: onNotificationTap,
          icon: const Icon(
            Icons.notifications_outlined,
            color: TColors.primary,
            size: 28,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class EarningsSummaryCard extends StatelessWidget {
  final NurseEarningsController controller;

  const EarningsSummaryCard({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.currency(
      locale: 'fr_DZ',
      symbol: '',
      decimalDigits: 2,
    );

    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [TColors.primary, Color(0xFF1976D2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: TColors.primary.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Earnings',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Obx(() => Text(
                      '${numberFormat.format(controller.totalEarnings.value)} DZD',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.07,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    )),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.05),
          Row(
            children: [
              Expanded(
                child: EarningStatBox(
                  label: 'This Month',
                  amount: controller.monthlyEarnings.value,
                  icon: Icons.calendar_month,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.03),
              Expanded(
                child: EarningStatBox(
                  label: 'This Week',
                  amount: controller.weeklyEarnings.value,
                  icon: Icons.calendar_today,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.03),
          Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pending Amount',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Obx(() => Text(
                        '${numberFormat.format(controller.pendingAmount.value)} DZD',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      )),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: controller.requestWithdrawal,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: TColors.primary,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                      vertical: MediaQuery.of(context).size.width * 0.025,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Withdraw',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EarningStatBox extends StatelessWidget {
  final String label;
  final double amount;
  final IconData icon;

  const EarningStatBox({
    Key? key,
    required this.label,
    required this.amount,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.currency(
      locale: 'fr_DZ',
      symbol: '',
      decimalDigits: 0,
    );

    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white70, size: MediaQuery.of(context).size.width * 0.05),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            '${numberFormat.format(amount)} DZD',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class SectionHeading extends StatelessWidget {
  final String title;

  const SectionHeading({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.045,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}

class PeriodFilterButton extends StatelessWidget {
  final NurseEarningsController controller;

  const PeriodFilterButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showPeriodOptions(context),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
          vertical: MediaQuery.of(context).size.width * 0.02,
        ),
        decoration: BoxDecoration(
          color: TColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: TColors.primary),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => Text(
              controller.selectedPeriod.value,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.035,
                fontWeight: FontWeight.w600,
                color: TColors.primary,
              ),
              overflow: TextOverflow.ellipsis,
            )),
            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
            Icon(
              Icons.keyboard_arrow_down,
              size: MediaQuery.of(context).size.width * 0.04,
              color: TColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  void _showPeriodOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPeriodOption('Today', context),
              _buildPeriodOption('This Week', context),
              _buildPeriodOption('This Month', context),
              _buildPeriodOption('This Year', context),
              _buildPeriodOption('All Time', context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPeriodOption(String period, BuildContext context) {
    return InkWell(
      onTap: () {
        controller.changePeriod(period);
        Get.back();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width * 0.04),
        child: Row(
          children: [
            Obx(() => Icon(
              controller.selectedPeriod.value == period
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: TColors.primary,
              size: MediaQuery.of(context).size.width * 0.05,
            )),
            SizedBox(width: MediaQuery.of(context).size.width * 0.03),
            Text(
              period,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EarningHistoryCard extends StatelessWidget {
  final EarningModel earning;
  final VoidCallback onTap;

  const EarningHistoryCard({
    Key? key,
    required this.earning,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.currency(
      locale: 'fr_DZ',
      symbol: '',
      decimalDigits: 2,
    );

    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.03),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
              decoration: BoxDecoration(
                color: TColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIconForCareType(earning.careType),
                color: TColors.primary,
                size: MediaQuery.of(context).size.width * 0.06,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    earning.patientName,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                  Wrap(
                    spacing: MediaQuery.of(context).size.width * 0.02,
                    runSpacing: 4,
                    children: [
                      Text(
                        DateFormat('MMM dd, yyyy').format(earning.date),
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                          color: Colors.grey[600],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.02,
                          vertical: MediaQuery.of(context).size.width * 0.005,
                        ),
                        decoration: BoxDecoration(
                          color: earning.status == 'Completed'
                              ? Colors.green.withOpacity(0.1)
                              : Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          earning.status,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                            fontWeight: FontWeight.w500,
                            color: earning.status == 'Completed'
                                ? Colors.green[700]
                                : Colors.orange[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            Text(
              '+${numberFormat.format(earning.amount)} DZD',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForCareType(String careType) {
    switch (careType) {
      case 'Sitter':
        return Icons.chair;
      case 'Emergency':
        return Icons.emergency;
      case 'Health Care':
      default:
        return Icons.medical_services;
    }
  }
}

