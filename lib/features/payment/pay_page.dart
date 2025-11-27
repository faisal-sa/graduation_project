import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'webview_screen.dart';

// ==================  Payment Request Models  =================== //

class PaymentSource {
  final String type;
  final String name;
  final String number;
  final int month;
  final int year;
  final int cvc;
  final String statementDescriptor;
  final bool threeDS;
  final bool manual;
  final bool saveCard;

  PaymentSource({
    required this.type,
    required this.name,
    required this.number,
    required this.month,
    required this.year,
    required this.cvc,
    required this.statementDescriptor,
    required this.threeDS,
    required this.manual,
    required this.saveCard,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'name': name,
      'number': number,
      'month': month,
      'year': year,
      'cvc': cvc,
      'statement_descriptor': statementDescriptor,
      '3ds': threeDS,
      'manual': manual,
      'save_card': saveCard,
    };
  }
}

class PaymentMetadata {
  final String cartId;
  final String customerEmail;
  final String customerId;

  PaymentMetadata({
    required this.cartId,
    required this.customerEmail,
    required this.customerId,
  });

  Map<String, dynamic> toMap() {
    return {
      'cart_id': cartId,
      'customer_email': customerEmail,
      'customer_id': customerId,
    };
  }

  factory PaymentMetadata.fromMap(Map<String, dynamic> map) {
    return PaymentMetadata(
      cartId: map['cart_id'] as String? ?? '',
      customerEmail: map['customer_email'] as String? ?? '',
      customerId: map['customer_id'] as String? ?? '',
    );
  }
}

class PayRequest {
  final String givenId;
  final int amount;
  final String currency;
  final String description;
  final String callbackUrl;
  final PaymentSource source;
  final PaymentMetadata metadata;
  final bool applyCoupon;

  PayRequest({
    required this.givenId,
    required this.amount,
    required this.currency,
    required this.description,
    required this.callbackUrl,
    required this.source,
    required this.metadata,
    required this.applyCoupon,
  });

  Map<String, dynamic> toMap() {
    return {
      'given_id': givenId,
      'amount': amount,
      'currency': currency,
      'description': description,
      'callback_url': callbackUrl,
      'source': source.toMap(),
      'metadata': metadata.toMap(),
      'apply_coupon': applyCoupon,
    };
  }
}

// ==================  Payment Response Models  =================== //

class PaymentSourceResponse {
  final String type;
  final String? company;
  final String name;
  final String number;
  final String? gatewayId;
  final String? referenceNumber;
  final String? token;
  final String? message;
  final String? transactionUrl;
  final String? responseCode;
  final String? authorizationCode;
  final String? issuerName;
  final String? issuerCountry;
  final String? issuerCardType;
  final String? issuerCardCategory;

  PaymentSourceResponse({
    required this.type,
    this.company,
    required this.name,
    required this.number,
    this.gatewayId,
    this.referenceNumber,
    this.token,
    this.message,
    this.transactionUrl,
    this.responseCode,
    this.authorizationCode,
    this.issuerName,
    this.issuerCountry,
    this.issuerCardType,
    this.issuerCardCategory,
  });

  factory PaymentSourceResponse.fromMap(Map<String, dynamic> map) {
    return PaymentSourceResponse(
      type: map['type'] as String? ?? '',
      company: map['company'] as String?,
      name: map['name'] as String? ?? '',
      number: map['number'] as String? ?? '',
      gatewayId: map['gateway_id'] as String?,
      referenceNumber: map['reference_number'] as String?,
      token: map['token'] as String?,
      message: map['message'] as String?,
      transactionUrl: map['transaction_url'] as String?,
      responseCode: map['response_code'] as String?,
      authorizationCode: map['authorization_code'] as String?,
      issuerName: map['issuer_name'] as String?,
      issuerCountry: map['issuer_country'] as String?,
      issuerCardType: map['issuer_card_type'] as String?,
      issuerCardCategory: map['issuer_card_category'] as String?,
    );
  }
}

class PayResponse {
  final String id;
  final String status;
  final int amount;
  final int fee;
  final String currency;
  final int refunded;
  final String? refundedAt;
  final int captured;
  final String? capturedAt;
  final String? voidedAt;
  final String description;
  final String amountFormat;
  final String feeFormat;
  final String refundedFormat;
  final String capturedFormat;
  final String? invoiceId;
  final String ip;
  final String callbackUrl;
  final String createdAt;
  final String updatedAt;
  final PaymentMetadata metadata;
  final PaymentSourceResponse source;
  final List<dynamic> splits;

  PayResponse({
    required this.id,
    required this.status,
    required this.amount,
    required this.fee,
    required this.currency,
    required this.refunded,
    this.refundedAt,
    required this.captured,
    this.capturedAt,
    this.voidedAt,
    required this.description,
    required this.amountFormat,
    required this.feeFormat,
    required this.refundedFormat,
    required this.capturedFormat,
    this.invoiceId,
    required this.ip,
    required this.callbackUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.metadata,
    required this.source,
    required this.splits,
  });

  factory PayResponse.fromMap(Map<String, dynamic> map) {
    return PayResponse(
      id: map['id'] as String? ?? '',
      status: map['status'] as String? ?? '',
      amount: map['amount'] as int? ?? 0,
      fee: map['fee'] as int? ?? 0,
      currency: map['currency'] as String? ?? '',
      refunded: map['refunded'] as int? ?? 0,
      refundedAt: map['refunded_at'] as String?,
      captured: map['captured'] as int? ?? 0,
      capturedAt: map['captured_at'] as String?,
      voidedAt: map['voided_at'] as String?,
      description: map['description'] as String? ?? '',
      amountFormat: map['amount_format'] as String? ?? '',
      feeFormat: map['fee_format'] as String? ?? '',
      refundedFormat: map['refunded_format'] as String? ?? '',
      capturedFormat: map['captured_format'] as String? ?? '',
      invoiceId: map['invoice_id'] as String?,
      ip: map['ip'] as String? ?? '',
      callbackUrl: map['callback_url'] as String? ?? '',
      createdAt: map['created_at'] as String? ?? '',
      updatedAt: map['updated_at'] as String? ?? '',
      metadata: PaymentMetadata.fromMap(
        map['metadata'] as Map<String, dynamic>? ?? {},
      ),
      source: PaymentSourceResponse.fromMap(
        map['source'] as Map<String, dynamic>? ?? {},
      ),
      splits: map['splits'] as List<dynamic>? ?? [],
    );
  }
}

// ==================  Moyasar Payment Service  =================== //

class MoyasarPaymentService {
  // API Configuration
  static const String baseUrl = 'https://api.moyasar.com';
  static const String apiKey =
      'pk_test_oCkYSAKky59z4HrK2erLewjzCU1CeVQxLsE37KuK';
  static const String apiPassword = ''; // Empty password for basic auth

  final Dio dio;

  MoyasarPaymentService()
    : dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      ) {
    // Setup Basic Authentication
    dio.options.headers['Authorization'] =
        'Basic ${base64Encode(utf8.encode('$apiKey:$apiPassword'))}';
  }

  // Process Payment
  Future<PayResponse> processPayment(PayRequest request) async {
    try {
      final response = await dio.post('/v1/payments', data: request.toMap());

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null) {
          return PayResponse.fromMap(response.data as Map<String, dynamic>);
        } else {
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            message: 'Invalid response from server',
          );
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: 'Payment request failed with status ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // Server responded with error status code
        final statusCode = e.response?.statusCode;
        final errorMessage =
            e.response?.data?['message'] ??
            e.response?.data?['error'] ??
            'Payment failed (${statusCode ?? 'Unknown'})';
        throw Exception(errorMessage);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Connection timeout. Please try again');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
          'Connection error. Please check your internet connection',
        );
      } else {
        throw Exception('Unexpected error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Payment processing error: ${e.toString()}');
    }
  }
}

// ==================  Payment Page UI  =================== //

class PayPage extends StatefulWidget {
  const PayPage({super.key});

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  // Service instance
  final service = MoyasarPaymentService();
  final _uuid = const Uuid();

  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController(text: '20000');

  // Card details controllers
  final _cardNameController = TextEditingController(text: 'abdulaziz adel');
  final _cardNumberController = TextEditingController(text: '4111111111111111');
  final _cardMonthController = TextEditingController(text: '12');
  final _cardYearController = TextEditingController(text: '2030');
  final _cardCvcController = TextEditingController(text: '123');

  // Hidden/default values (not shown in UI)
  static const String _defaultCurrency = 'SAR';
  static const String _defaultDescription = 'Test Payment';
  static const String _defaultCallbackUrl =
      'https://example.com/checkout/payer-return';
  static const String _defaultStatementDescriptor = 'Century Store';
  static const String _defaultCartId = '72e470a5-cbc4-47b3-a52a-e89fda6adb19';
  static const String _defaultCustomerId = '23432';
  static const String _defaultCustomerEmail = '';

  // State variables
  PayResponse? paymentResponse;
  bool isLoading = false;

  @override
  void dispose() {
    // Dispose all controllers
    _amountController.dispose();
    _cardNameController.dispose();
    _cardNumberController.dispose();
    _cardMonthController.dispose();
    _cardYearController.dispose();
    _cardCvcController.dispose();
    super.dispose();
  }

  // ==================  Payment Processing Method  =================== //

  Future<void> _processPayment() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
      paymentResponse = null;
    });

    try {
      // Auto-generate UUID v4 for given_id (for idempotency)
      final givenId = _uuid.v4();

      // Create payment request
      final paymentRequest = PayRequest(
        givenId: givenId,
        amount: int.parse(_amountController.text.trim()),
        currency: _defaultCurrency,
        description: _defaultDescription,
        callbackUrl: _defaultCallbackUrl,
        source: PaymentSource(
          type: 'creditcard',
          name: _cardNameController.text.trim(),
          number: _cardNumberController.text.trim().replaceAll(' ', ''),
          month: int.parse(_cardMonthController.text.trim()),
          year: int.parse(_cardYearController.text.trim()),
          cvc: int.parse(_cardCvcController.text.trim()),
          statementDescriptor: _defaultStatementDescriptor,
          threeDS: true,
          manual: false,
          saveCard: false,
        ),
        metadata: PaymentMetadata(
          cartId: _defaultCartId,
          customerEmail: _defaultCustomerEmail,
          customerId: _defaultCustomerId,
        ),
        applyCoupon: true,
      );

      // Process payment
      final response = await service.processPayment(paymentRequest);

      if (!mounted) return;

      setState(() {
        paymentResponse = response;
        isLoading = false;
      });

      // Check if transaction URL exists (for 3DS authentication)
      if (response.source.transactionUrl != null &&
          response.source.transactionUrl!.isNotEmpty) {
        // Navigate to WebView for 3DS authentication
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WebViewScreen(url: response.source.transactionUrl!),
          ),
        );
      } else {
        // Show success/error message based on status
        final statusColor = response.status == 'paid'
            ? Colors.green
            : Colors.orange;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment Status: ${response.status.toUpperCase()}'),
            backgroundColor: statusColor,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      final errorMessage = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : 'Payment processing failed';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  // ==================  UI Build Method  =================== //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Moyasar Payment'),
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ============================
              //    Payment Information Section
              // ============================
              _buildSectionTitle('Payment Information'),
              _buildTextField(
                controller: _amountController,
                label: 'Amount',
                hint: '20000',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // ============================
              //    Card Details Section
              // ============================
              _buildSectionTitle('Card Details'),
              _buildTextField(
                controller: _cardNameController,
                label: 'Cardholder Name',
                hint: 'abdulaziz adel',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter cardholder name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _cardNumberController,
                label: 'Card Number',
                hint: '4111111111111111',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter card number';
                  }
                  if (value.replaceAll(' ', '').length < 13) {
                    return 'Please enter a valid card number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _cardMonthController,
                      label: 'Month',
                      hint: '12',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        final month = int.tryParse(value);
                        if (month == null || month < 1 || month > 12) {
                          return 'Invalid';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(
                      controller: _cardYearController,
                      label: 'Year',
                      hint: '2030',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Invalid';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(
                      controller: _cardCvcController,
                      label: 'CVC',
                      hint: '123',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Invalid';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // ============================
              //    Submit Button
              // ============================
              ElevatedButton(
                onPressed: isLoading ? null : _processPayment,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: const Color(0xFF1976D2),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey[800],
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : const Text(
                        'Pay Now',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================  UI Helper Methods  =================== //

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(color: Colors.grey),
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
      ),
    );
  }
}
