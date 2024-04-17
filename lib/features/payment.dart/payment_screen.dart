import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/payment.dart/khalti_payment_page.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscription Plans'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WhyProWidget(),
            SizedBox(height: 20.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 1,
                mainAxisSpacing: 20.0,
                childAspectRatio: 2.5,
                children: [
                  buildSubscriptionCard(
                    type: '1',
                    duration: '1 Month',
                    price: 'Rs. 10',
                    color: Colors.blueAccent,
                    icon: Icons.star_border,
                  ),
                  buildSubscriptionCard(
                    type: '2',
                    duration: '6 Months',
                    price: 'Rs. 45',
                    color: Colors.orangeAccent,
                    icon: Icons.star_half,
                  ),
                  buildSubscriptionCard(
                    type: '3',
                    duration: '1 Year',
                    price: 'Rs. 75',
                    color: Colors.greenAccent,
                    icon: Icons.star,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSubscriptionCard(
      {required String duration,
      required String price,
      required Color color,
      required IconData icon,
      required String type}) {
    return GestureDetector(
      onTap: () {
        Get.to(KhaltiPage(
          type: type,
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.6), color.withOpacity(0.3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    duration,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    icon,
                    color: Colors.white,
                  ),
                ],
              ),
              Text(
                'Price: $price',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton.icon(
                onPressed: () {
                  Get.to(KhaltiPage(
                    type: type,
                  ));
                },
                icon: Icon(Icons.shopping_cart),
                label: Text(
                  'Subscribe',
                  style: TextStyle(fontSize: 16.0),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WhyProWidget extends StatelessWidget {
  const WhyProWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.blueAccent.withOpacity(0.6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Why Gym Buddy Subscription?",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            "1. Get access to all the features of the app.",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
