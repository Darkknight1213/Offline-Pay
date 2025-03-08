
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(OfflinePayApp());
}

class OfflinePayApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OfflinePay',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String? qrData;

  void generateQRCode() {
    final phone = phoneController.text;
    final amount = amountController.text;

    if (phone.isEmpty || amount.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enter phone number and amount')),
      );
      return;
    }

    setState(() {
      qrData = 'OfflinePay|$phone|$amount';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OfflinePay', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Enter Payment Details',
                    textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    speed: Duration(milliseconds: 100),
                  ),
                ],
                repeatForever: true,
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone Number', border: OutlineInputBorder()),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 15),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Amount (₹)', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: generateQRCode,
              icon: Icon(FontAwesomeIcons.qrcode),
              label: Text('Generate QR Code', style: TextStyle(fontSize: 18)),
              style: OutlinedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
            ),
            if (qrData != null) ...[
              SizedBox(height: 20),
              Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: QrImageView(
                    data: qrData!,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
              ),
            ],
            SizedBox(height: 30),
            Text('Payment Methods', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                OutlinedButton.icon(onPressed: () {}, icon: Icon(FontAwesomeIcons.simCard), label: Text('USSD')),
                OutlinedButton.icon(onPressed: () {}, icon: Icon(FontAwesomeIcons.qrcode), label: Text('Dynamic QR')),
                OutlinedButton.icon(onPressed: () {}, icon: Icon(FontAwesomeIcons.idCard), label: Text('Aadhaar Pay')),
                OutlinedButton.icon(onPressed: () {}, icon: Icon(FontAwesomeIcons.nfcDirectional), label: Text('NFC')),
                OutlinedButton.icon(onPressed: () {}, icon: Icon(FontAwesomeIcons.moneyBill), label: Text('UPI')),
                OutlinedButton.icon(onPressed: () {}, icon: Icon(FontAwesomeIcons.creditCard), label: Text('Card')),
                OutlinedButton.icon(onPressed: () {}, icon: Icon(FontAwesomeIcons.university), label: Text('Net Banking')),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(FontAwesomeIcons.history),
              label: Text('View Transaction History', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
            ),
          ],
        ),
      ),
    );
  }
}
