import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:papeltaksi/core/constants/app_colors.dart';
import 'package:intl/intl.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _amountController = TextEditingController();
  String _displayAmount = '0,00';
  double _tripAmount = 0.0;
  double _serviceFee = 0.0;
  double _totalAmount = 0.0;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  double _calculateServiceFee(double tripAmount) {
    if (tripAmount < 1.01) {
      return 0.0;
    }
    // Minimum 8 TL hizmet bedeli, yolculuk tutarının %10'u (hangisi büyükse)
    return tripAmount * 0.10 < 8.0 ? 8.0 : tripAmount * 0.10;
  }

  void _updateAmounts() {
    _tripAmount = double.tryParse(_amountController.text) ?? 0.0;
    _serviceFee = _calculateServiceFee(_tripAmount);
    _totalAmount = _tripAmount + _serviceFee;
  }

  void _onNumberPressed(String number) {
    setState(() {
      String currentValue = _displayAmount.replaceAll(',', '').replaceAll('.', '');

      if (currentValue == '000' && number == '0') return;

      if (currentValue == '000') {
        currentValue = '';
      }

      currentValue += number;

      if (currentValue.length > 8) return;

      final intValue = int.parse(currentValue);
      final doubleValue = intValue / 100.0;

      final formatter = NumberFormat('#,##0.00', 'tr_TR');
      _displayAmount = formatter.format(doubleValue);
      _amountController.text = doubleValue.toString();
      _updateAmounts();
    });
  }

  void _onBackspace() {
    setState(() {
      String currentValue = _displayAmount.replaceAll(',', '').replaceAll('.', '');

      if (currentValue.length <= 3) {
        _displayAmount = '0,00';
        _amountController.text = '0';
        _updateAmounts();
        return;
      }

      currentValue = currentValue.substring(0, currentValue.length - 1);
      final intValue = int.parse(currentValue);
      final doubleValue = intValue / 100.0;

      final formatter = NumberFormat('#,##0.00', 'tr_TR');
      _displayAmount = formatter.format(doubleValue);
      _amountController.text = doubleValue.toString();
      _updateAmounts();
    });
  }

  void _handlePayment() {
    if (_tripAmount < 1.01) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Yolculuk tutarı en az 1,01 TL olmalıdır'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ödeme Onayı'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryRow('Yolculuk Tutarı:', _tripAmount),
            const SizedBox(height: 8),
            _buildSummaryRow('Hizmet Tutarı:', _serviceFee),
            const Divider(height: 24),
            _buildSummaryRow('Toplam:', _totalAmount, isBold: true),
            const SizedBox(height: 16),
            const Text(
              'SoftPOS uygulamasına yönlendirileceksiniz.',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showPaymentProcessing();
            },
            child: const Text('Devam Et'),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isBold = false}) {
    final formatter = NumberFormat.currency(locale: 'tr_TR', symbol: '₺');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 16 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          formatter.format(amount),
          style: TextStyle(
            fontSize: isBold ? 16 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: isBold ? AppColors.accent : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  void _showPaymentProcessing() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Ödeme işleniyor...'),
          ],
        ),
      ),
    );

    // Simulate payment processing
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close processing dialog
      _showPaymentSuccess();
    });
  }

  void _showPaymentSuccess() {
    final formatter = NumberFormat.currency(locale: 'tr_TR', symbol: '₺');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: AppColors.success,
                size: 48,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Ödeme Başarılı!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              formatter.format(_totalAmount),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.accent,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.backgroundSecondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildSmallSummaryRow('Yolculuk', _tripAmount),
                  const SizedBox(height: 4),
                  _buildSmallSummaryRow('Hizmet', _serviceFee),
                ],
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close success dialog
              Navigator.pop(context); // Go back to dashboard
            },
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallSummaryRow(String label, double amount) {
    final formatter = NumberFormat.currency(locale: 'tr_TR', symbol: '₺');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        Text(
          formatter.format(amount),
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: 'tr_TR', symbol: '₺');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ödeme Al'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Yolculuk Tutarı
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Yolculuk Tutarı:',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '₺$_displayAmount',
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.accent,
                                fontSize: 42,
                              ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Hizmet ve Toplam Bilgileri
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundSecondary,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.border,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          // Hizmet Tutarı
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.receipt_long,
                                    size: 20,
                                    color: AppColors.textSecondary,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Hizmet Tutarı',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                formatter.format(_serviceFee),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // Info Text
                          if (_serviceFee > 0)
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.info.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.info_outline,
                                    size: 14,
                                    color: AppColors.info,
                                  ),
                                  SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      'Minimum hizmet bedeli 8 TL',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: AppColors.info,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          const Divider(height: 24),

                          // Toplam
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'TOPLAM',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              Text(
                                formatter.format(_totalAmount),
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.accent,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Number Pad
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.backgroundSecondary,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildNumberRow(['1', '2', '3']),
                  const SizedBox(height: 12),
                  _buildNumberRow(['4', '5', '6']),
                  const SizedBox(height: 12),
                  _buildNumberRow(['7', '8', '9']),
                  const SizedBox(height: 12),
                  _buildNumberRow(['00', '0', 'back']),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _handlePayment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                      ),
                      child: const Text(
                        'Ödemeyi Başlat',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberRow(List<String> numbers) {
    return Row(
      children: numbers.map((number) {
        if (number == 'back') {
          return Expanded(
            child: InkWell(
              onTap: _onBackspace,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.backspace_outlined,
                  color: AppColors.error,
                ),
              ),
            ),
          );
        }

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: InkWell(
              onTap: () => _onNumberPressed(number),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    number,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
