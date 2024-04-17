import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:mygymbuddy/features/payment.dart/function/esewa.dart';

class KhaltiPage extends StatefulWidget {
  KhaltiPage({
    Key? key,
    required this.type,
  }) : super(key: key);

  final String type;

  @override
  State<KhaltiPage> createState() => _KhaltiPageState();
}

class _KhaltiPageState extends State<KhaltiPage> {
  String getPaymentDuration() {
    switch (widget.type) {
      case '1':
        return '1 Month';
      case '2':
        return '6 Months';
      case '3':
        return '1 Year';
      default:
        return '';
    }
  }

  String getPaymentAmount() {
    switch (widget.type) {
      case '1':
        return '10';
      case '2':
        return '45';
      case '3':
        return '75';
      default:
        return '0';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.payment,
                size: 100,
                color: Colors.blueAccent,
              ),
              SizedBox(height: 20),
              Text(
                'Pay for ${getPaymentDuration()} Subscription',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () { 
                  ESEWA esewa = ESEWA();
                  esewa.pay(widget.type);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Pay Rs. ${getPaymentAmount()}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
