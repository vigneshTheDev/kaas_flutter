import 'package:flutter/material.dart';

@immutable
class User {
  const User({
    required this.email,
    required this.name,
  });

  final String email;
  final String name;

  @override
  String toString() {
    return '$name, $email';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is User && other.name == name && other.email == email;
  }

  @override
  int get hashCode => Object.hash(email, name);
}

class AutocompleteCustomTypeExample extends StatelessWidget {
  const AutocompleteCustomTypeExample({Key? key}) : super(key: key);

  static const List<User> _userOptions = <User>[
    User(name: 'Alice', email: 'alice@example.com'),
    User(name: 'Bob', email: 'bob@example.com'),
    User(name: 'Charlie', email: 'charlie123@gmail.com'),
    User(name: 'One', email: 'charlie123@gmail.com'),
    User(name: 'Two', email: 'charlie123@gmail.com'),
    User(name: 'Three', email: 'charlie123@gmail.com'),
    User(name: 'Four', email: 'charlie123@gmail.com'),
    User(name: 'Five', email: 'charlie123@gmail.com'),
    User(name: 'Six', email: 'charlie123@gmail.com'),
  ];

  static String _displayStringForOption(User option) => option.name;

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<User>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        return _userOptions.where((User option) {
          // Search based on User.toString, which includes both name and
          // email, even though the display string is just the name.
          return option
              .toString()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      displayStringForOption: _displayStringForOption,
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          onFieldSubmitted: (String value) {
            onFieldSubmitted();
          },
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<User> onSelected, Iterable<User> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              height: 200.0,
              color: const Color(0xFFEEEEEE),
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final User option = options.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: ListTile(
                      title: Text(_displayStringForOption(option)),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
