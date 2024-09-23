import 'package:flutter/material.dart';
import 'package:ironvault_mobile/layouts/master_screen.dart';
import 'package:ironvault_mobile/models/faq.dart';
import 'package:ironvault_mobile/models/search_result.dart';
import 'package:ironvault_mobile/providers/faq_provider.dart';
import 'package:provider/provider.dart';
import 'loading_screen.dart';
import 'no_data_found.dart';

class FaqListScreen extends StatefulWidget {
  static const String routeName = "/faq";
  final int id;

  const FaqListScreen(this.id, {Key? key}) : super(key: key);

  @override
  State<FaqListScreen> createState() => _FaqListScreenState();
}

class _FaqListScreenState extends State<FaqListScreen> {
  FaqProvider? _faqProvider;
  SearchResult<Faq>? data;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _faqProvider = context.read<FaqProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _faqProvider?.get();
    setState(() {
      data = tmpData;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "FAQ",
      index: 5,
      id: widget.id,
      child: _isLoading
          ? LoadingScreen()
          : SingleChildScrollView(
              child: Column(
                children: [
                  (data?.result == null || data!.result.isEmpty)
                      ? Container(
                          height: MediaQuery.of(context).size.height - 300,
                          child: Scaffold(
                            body: noDataFound("FAQs nisu pronađeni"),
                          ),
                        )
                      : _buildFaqAccordion(),
                ],
              ),
            ),
    );
  }

Widget _buildFaqAccordion() {
  return Container(
    margin: const EdgeInsets.only(top: 40.0), // Adjust the value as needed
    child: ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data?.result.length ?? 0,
      itemBuilder: (context, index) {
        final faq = data!.result[index];
        return ExpansionTile(
          title: Text(
            faq.pitanje ?? "",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          children: [
            ListTile(
              title: Text(
                faq.odgovor ?? "",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.normal),
              ),
            ),
          ],
        );
      },
    ),
  );
}

}
