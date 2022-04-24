// const String currencyCode = "₺";
// const String currencyCode = "RM";
const String currencyCode = "\$";

String formatPrice([double? price = 0]) {
  return "$currencyCode${price!.toStringAsFixed(2)}";
}
