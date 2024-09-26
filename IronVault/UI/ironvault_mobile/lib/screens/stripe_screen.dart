import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ironvault_mobile/models/korisnik.dart';
import 'package:ironvault_mobile/models/payment.dart';
import 'package:ironvault_mobile/providers/korisnik_provider.dart';
import 'package:ironvault_mobile/providers/cart_provider.dart';
import 'package:ironvault_mobile/screens/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:ironvault_mobile/utils/app_constants.dart';

class StripeScreen extends StatefulWidget {
  final List<Map> items; // To receive items from CartScreen
  final double totalPrice; // Add totalPrice here
  final int id;

  const StripeScreen({
    required this.id,
    required this.items,
    required this.totalPrice,
    Key? key,
  }) : super(key: key);

  @override
  State<StripeScreen> createState() => _StripeScreenState();
}

class _StripeScreenState extends State<StripeScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  KorisnikProvider? _korisnikProvider;
  CartProvider? _cartProvider;

  Korisnik? _korisnik;
  bool _isLoading = true; // Declare loading state

    double amountInUsd = 0.0; // Add this variable to hold the amount in USD

  final commonDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.grey[200],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Colors.blue),
    ),
  );

  @override
  void initState() {
    super.initState();
    _korisnikProvider = context.read<KorisnikProvider>();
    _cartProvider = context.read<CartProvider>();
    loadData();

    amountInUsd = widget.totalPrice * AppConstants.bamToUsdConversionRate; // Calculate the converted amount

  }

  Future<void> loadData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      _korisnik = await _korisnikProvider?.getbyid(widget.id);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading data: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<String> currencyList = <String>[
    'USD',
  ];
  String selectedCurrency = 'USD';

  bool hasDonated = false;

  Future<void> initPaymentSheet(Map<String, dynamic> formData) async {
    try {


      final data = await createPaymentIntent(
        amount: (amountInUsd.toInt() * 100).toString(),
        currency: selectedCurrency.toString(),
        name: '${_korisnik?.ime} ${_korisnik?.prezime}',
        address: formData['address'],
        pin: formData['pincode'],
        city: formData['city'],
        state: formData['state'],
        country: formData['country'],
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator()) // Show loading indicator
              : Column(
                  children: [
                    const Image(
                      image: AssetImage("assets/images/stripe.png"),
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 16),
                    hasDonated
                        ? buildThanksMessage()
                        : buildPaymentForm(context),
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildThanksMessage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Narudžba uplaćena",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            "Zahvaljujemo vam se kupovini",
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
                "Vrati me na profil",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () {
                

                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProfileScreen(widget.id)));

              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPaymentForm(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildAmountAndCurrencyFields(),
          const SizedBox(height: 10),
          buildTextField('name', 'Full name',
              initialValue: '${_korisnik?.ime} ${_korisnik?.prezime}'),
          const SizedBox(height: 10),
          buildTextField('address', 'Adresa'),
          const SizedBox(height: 10),
          buildCityAndStateFields(),
          const SizedBox(height: 10),
          buildCountryAndPincodeFields(),
          const SizedBox(height: 50),
          buildSubmitButton(context),
        ],
      ),
    );
  }

  Widget buildAmountAndCurrencyFields() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: buildTextField('amount', 'Full amount',
              keyboardType: TextInputType.number,
              isNumeric: true,
              initialValue: amountInUsd.toString(), 
              readOnly: true // Make it read-only
              ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: DropdownButtonFormField<String>(
            value: selectedCurrency,
            items: currencyList
                .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
            onChanged: (String? value) {
              setState(() {
                selectedCurrency = value!;
              });
            },
            decoration: commonDecoration.copyWith(labelText: 'Converted to USD'),
          ),
        ),
      ],
    );
  }

  Widget buildCityAndStateFields() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: buildTextField('city', 'City'),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 5,
          child: buildTextField('state', 'State (Short code)'),
        ),
      ],
    );
  }

  Widget buildCountryAndPincodeFields() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: buildTextField('country', 'Country (Short code)'),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 5,
          child: buildTextField('pincode', 'Pincode',
              keyboardType: TextInputType.number, isNumeric: true),
        ),
      ],
    );
  }

  Widget buildTextField(String name, String labelText,
      {TextInputType keyboardType = TextInputType.text,
      bool isNumeric = false,
      String? initialValue,
      bool readOnly = false}) {
    return FormBuilderTextField(
      name: name,
      decoration: commonDecoration.copyWith(labelText: labelText),
      validator: isNumeric
          ? FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.numeric(),
            ])
          : FormBuilderValidators.required(),
      keyboardType: keyboardType,
      initialValue: initialValue,
      readOnly: readOnly,
    );
  }

  Widget buildSubmitButton(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent.shade400,
        ),
        child: const Text(
          "Proceed to Pay",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        onPressed: () async {
          if (formKey.currentState?.saveAndValidate() ?? false) {
            final formData = formKey.currentState?.value;
            await initPaymentSheet(formData!);

            print(formData);

            try {
              await Stripe.instance.presentPaymentSheet();
              setState(() {
                hasDonated = true;
              });
              final snackBar = SnackBar(
            content: const Text(
              "Kupovina izvršena.",
              style: TextStyle(color: Colors.white),
            ),
            duration: const Duration(seconds: 1), // Duration before the SnackBar disappears
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green, // Set background color to red
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          _cartProvider?.clearCart();
            } catch (e) {


              final snackBar = SnackBar(
            content: const Text(
              "Kupovina nije izvršena.",
              style: TextStyle(color: Colors.white),
            ),
            duration: const Duration(seconds: 1), // Duration before the SnackBar disappears
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red, // Set background color to red
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);


            }
          }
        },
      ),
    );
  }
}
