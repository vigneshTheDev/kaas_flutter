import 'package:flutter/material.dart';
import 'package:kaas/shared_components/text_input.dart';

const _CurrencyList = [
  {"code": "AUD", "name": "Australian Dollar"},
  {"code": "BGN", "name": "Bulgarian Lev"},
  {"code": "BRL", "name": "Botswana Pula"},
  {"code": "CAD", "name": "Canadian Dollar"},
  {"code": "CHF", "name": "Swiss Franc"},
  {"code": "CNY", "name": "Chinese Yuan Renminbi"},
  {"code": "CZK", "name": "Czech Koruna"},
  {"code": "DKK", "name": "Danish Krone"},
  {"code": "EUR", "name": "European Euro"},
  {"code": "GBP", "name": "Pound Sterling"},
  {"code": "HKD", "name": "Hong Kong Dollar"},
  {"code": "HRK", "name": "Croatian Kuna"},
  {"code": "HUF", "name": "Hungarian Forint"},
  {"code": "IDR", "name": "Indonesian Rupiah"},
  {"code": "ILS", "name": "Israeli New Shekel"},
  {"code": "INR", "name": "Indian Rupee", "symbol": "₹"},
  {"code": "ISK", "name": "Icelandic Krona"},
  {"code": "JPY", "name": "Japanese Yen"},
  {"code": "KRW", "name": "South Korean Won"},
  {"code": "MXN", "name": "Mexican Peso"},
  {"code": "MYR", "name": "Malaysian Ringgit"},
  {"code": "NOK", "name": "Norwegian Krone"},
  {"code": "NZD", "name": "New Zealand Dollar"},
  {"code": "PHP", "name": "Philippine Peso"},
  {"code": "PLN", "name": "Polish Zloty"},
  {"code": "RON", "name": "Romanian Leu"},
  {"code": "RUB", "name": "Russian Ruble"},
  {"code": "SEK", "name": "Swedish Krona"},
  {"code": "SGD", "name": "Singapore Dollar"},
  {"code": "THB", "name": "Thai Baht"},
  {"code": "TRY", "name": "Turkish Lira"},
  {"code": "USD", "name": "United States Dollar", "symbol": "\$"},
  {"code": "ZAR", "name": "South African Rand"},
];

class CurrencyPicker extends StatefulWidget {
  final String label;
  final ValueChanged onChanged;
  const CurrencyPicker({
    Key? key,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  @override
  State<CurrencyPicker> createState() => _CurrencyPickerState();
}

class _CurrencyPickerState extends State<CurrencyPicker> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete<Map<String, String>>(
      displayStringForOption: (option) => option['name']!,
      fieldViewBuilder:
          ((context, textEditingController, focusNode, onFieldSubmitted) {
        return TextInput(
          label: widget.label,
          hintText: "E.g. USD",
          focusNode: focusNode,
          controller: textEditingController,
          onSubmitted: onFieldSubmitted,
          onChanged: (value) {},
        );
      }),
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: SizedBox(
              height: 200,
              child: Container(
                width: MediaQuery.of(context).size.width - 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE6E6E6)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: options
                        .map((e) => InkWell(
                              onTap: () {
                                onSelected(e);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(e['name']!),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      optionsBuilder: (textEditingValue) {
        var searchTerm = textEditingValue.text.toLowerCase();
        if (searchTerm == '') {
          return _CurrencyList;
        }

        return _CurrencyList.where(
          (element) =>
              element['name']!.toLowerCase().contains(searchTerm) ||
              element['code']!.toLowerCase().contains(searchTerm) ||
              element['symbol'] != null &&
                  element['symbol']!.contains(searchTerm),
        );
      },
      onSelected: (value) {
        widget.onChanged(value);
      },
    );
  }
}
