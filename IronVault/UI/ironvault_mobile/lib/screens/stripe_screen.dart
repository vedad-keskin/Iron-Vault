import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:ironvault_mobile/models/payment.dart';
import 'package:ironvault_mobile/utils/textfield.dart';

class StripeScreen extends StatefulWidget {
  final List<Map> items; // To receive items from CartScreen
  final double totalPrice; // Add totalPrice here

  const StripeScreen({required this.items, required this.totalPrice, Key? key})
      : super(key: key);

  @override
  State<StripeScreen> createState() => _StripeScreenState();
}

class _StripeScreenState extends State<StripeScreen> {
  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  final formkey = GlobalKey<FormState>();
  final formkey1 = GlobalKey<FormState>();
  final formkey2 = GlobalKey<FormState>();
  final formkey3 = GlobalKey<FormState>();
  final formkey4 = GlobalKey<FormState>();
  final formkey5 = GlobalKey<FormState>();
  final formkey6 = GlobalKey<FormState>();

  List<String> currencyList = <String>['USD', 'INR', 'EUR', 'JPY', 'GBP', 'AED'];
  String selectedCurrency = 'USD';

  bool hasDonated = false;

  Future<void> initPaymentSheet() async {
    try {
      final data = await createPaymentIntent(
        amount: (int.parse(amountController.text) * 100).toString(),
        currency: selectedCurrency,
        name: nameController.text,
        address: addressController.text,
        pin: pincodeController.text,
        city: cityController.text,
        state: stateController.text,
        country: countryController.text,
      );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customFlow: false,
          merchantDisplayName: 'Test Merchant',
          paymentIntentClientSecret: data['client_secret'],
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['id'],
          style: ThemeMode.dark,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Potvrda uplate"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: const AssetImage("assets/images/stripe.png"),
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            hasDonated
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Thanks for your ${amountController.text} $selectedCurrency donation",
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "We appreciate your support",
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent.shade400,
                            ),
                            child: const Text(
                              "Donate again",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            onPressed: () {
                              setState(() {
                                hasDonated = false;
                                amountController.clear();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: ReusableTextField(
                                  formkey: formkey,
                                  controller: amountController,
                                  isNumber: true,
                                  title: "Full amount",
                                  hint: "Full amount"),
                            ),
                            const SizedBox(width: 10),
                            DropdownMenu<String>(
                              inputDecorationTheme: InputDecorationTheme(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 0),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                              initialSelection: currencyList.first,
                              onSelected: (String? value) {
                                setState(() {
                                  selectedCurrency = value!;
                                });
                              },
                              dropdownMenuEntries: currencyList
                                  .map<DropdownMenuEntry<String>>((String value) {
                                return DropdownMenuEntry<String>(
                                    value: value, label: value);
                              }).toList(),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        ReusableTextField(
                          formkey: formkey1,
                          title: "Full name",
                          hint: "Ex. John Doe",
                          controller: nameController,
                        ),
                        const SizedBox(height: 10),
                        ReusableTextField(
                          formkey: formkey2,
                          title: "Adresa",
                          hint: "Ex. 123 Main St",
                          controller: addressController,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: ReusableTextField(
                                formkey: formkey3,
                                title: "City",
                                hint: "Ex. New York",
                                controller: cityController,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 5,
                              child: ReusableTextField(
                                formkey: formkey4,
                                title: "State (Short code)",
                                hint: "Ex. NY for New York",
                                controller: stateController,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: ReusableTextField(
                                formkey: formkey5,
                                title: "Country (Short Code)",
                                hint: "Ex. US for United States",
                                controller: countryController,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 5,
                              child: ReusableTextField(
                                formkey: formkey6,
                                title: "Pincode",
                                hint: "Ex. 123456",
                                controller: pincodeController,
                                isNumber: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent.shade400,
                            ),
                            child: const Text(
                              "Proceed to Pay",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            onPressed: () async {
                              if (formkey.currentState!.validate() &&
                                  formkey1.currentState!.validate() &&
                                  formkey2.currentState!.validate() &&
                                  formkey3.currentState!.validate() &&
                                  formkey4.currentState!.validate() &&
                                  formkey5.currentState!.validate() &&
                                  formkey6.currentState!.validate()) {
                                await initPaymentSheet();

                                try {
                                  await Stripe.instance.presentPaymentSheet();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Payment Done",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );

                                  setState(() {
                                    hasDonated = true;
                                  });
                                  nameController.clear();
                                  addressController.clear();
                                  cityController.clear();
                                  stateController.clear();
                                  countryController.clear();
                                  pincodeController.clear();
                                } catch (e) {
                                  print("payment sheet failed");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Payment Failed",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
