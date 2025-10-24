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
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  String _displayAmount = '0,00';
  final List<String> _quickAmounts = ['50', '100', '150', '200', '250', '300'];

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
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
    });
  }

  void _onBackspace() {
    setState(() {
      String currentValue = _displayAmount.replaceAll(',', '').replaceAll('.', '');

      if (currentValue.length <= 3) {
        _displayAmount = '0,00';
        _amountController.text = '0';
        return;
      }

      currentValue = currentValue.substring(0, currentValue.length - 1);
      final intValue = int.parse(currentValue);
      final doubleValue = intValue / 100.0;

      final formatter = NumberFormat('#,##0.00', 'tr_TR');
      _displayAmount = formatter.format(doubleValue);
      _amountController.text = doubleValue.toString();
    });
  }

  void _setQuickAmount(String amount) {
    setState(() {
      final doubleValue = double.parse(amount);
      final formatter = NumberFormat('#,##0.00', 'tr_TR');
      _displayAmount = formatter.format(doubleValue);
      _amountController.text = doubleValue.toString();
    });
  }

  void _handlePayment() {
    final amount = double.tryParse(_amountController.text) ?? 0;

    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen geçerli bir tutar girin'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // TODO: Implement SoftPOS deeplink
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ödeme Onayı'),
        content: Text(
          'Ödeme tutarı: ₺${_displayAmount}\n\nSoftPOS uygulamasına yönlendirileceksiniz.',
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
              '₺$_displayAmount',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.accent,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ödeme Al'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Amount Display
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Tutar',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 12),
                                child: Text(
                                  '₺',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _displayAmount,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Quick Amount Buttons
                    Text(
                      'Hızlı Tutarlar',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _quickAmounts.map((amount) {
                        return InkWell(
                          onTap: () => _setQuickAmount(amount),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundSecondary,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Text(
                              '₺$amount',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),
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
