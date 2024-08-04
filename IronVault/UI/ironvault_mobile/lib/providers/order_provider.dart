import 'package:ironvault_mobile/models/order.dart';
import 'package:ironvault_mobile/providers/base_provider.dart';

class OrderProvider extends BaseProvider<Order> {
  OrderProvider() : super("KorisnikSuplement");

  @override
  fromJson(data) {
    // TODO: implement fromJson
    return Order();
  }
}