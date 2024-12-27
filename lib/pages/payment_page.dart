import 'package:flutter/material.dart';


class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});


  @override
  State<PaymentPage> createState() => _PaymentPageState();
}


class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();


  String? _paymentMethod = 'cod';
  bool _showCardDetails = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Details'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fullscreen Background Image
          Image.asset(
            'assets/foods/gr1.jpg',
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.5),
            colorBlendMode: BlendMode.darken,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter Your Details',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    _buildTextFormField(
                      controller: _nameController,
                      label: 'Name',
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter your name' : null,
                    ),
                    const SizedBox(height: 20),
                    _buildTextFormField(
                      controller: _addressController,
                      label: 'Address',
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter your address' : null,
                    ),
                    const SizedBox(height: 20),
                    _buildTextFormField(
                      controller: _phoneController,
                      label: 'Phone Number',
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter phone number' : null,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Select Payment Method',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'cod',
                          groupValue: _paymentMethod,
                          onChanged: (value) {
                            setState(() {
                              _paymentMethod = value;
                              _showCardDetails = false;
                            });
                          },
                        ),
                        Text('Cash on Delivery', style: TextStyle(color: Colors.white)),
                        const SizedBox(width: 20),
                        Radio<String>(
                          value: 'card',
                          groupValue: _paymentMethod,
                          onChanged: (value) {
                            setState(() {
                              _paymentMethod = value;
                              _showCardDetails = true;
                            });
                          },
                        ),
                        Text('Credit Card', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (_showCardDetails) ...[
                      _buildTextFormField(
                        controller: _cardNumberController,
                        label: 'Card Number',
                        keyboardType: TextInputType.number,
                        validator: (value) => value == null || value.length != 16
                            ? 'Enter valid card number'
                            : null,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextFormField(
                              controller: _expiryDateController,
                              label: 'Expiry Date (MM/YY)',
                              keyboardType: TextInputType.datetime,
                              validator: (value) =>
                                  value == null || value.isEmpty ? 'Enter expiry date' : null,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildTextFormField(
                              controller: _cvvController,
                              label: 'CVV',
                              keyboardType: TextInputType.number,
                              validator: (value) =>
                                  value == null || value.length != 3 ? 'Enter valid CVV' : null,
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 50),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Processing payment via $_paymentMethod',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
                          elevation: 10,
                        ),
                        child: Text(
                          'Submit Payment',
                          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: validator,
    );
  }
}



