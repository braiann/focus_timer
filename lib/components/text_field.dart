import 'package:flutter/cupertino.dart';
import 'package:focus_bits/constants.dart';

class TextField extends StatelessWidget {
  const TextField(
      {Key? key,
      this.placeholder,
      this.icon,
      this.obscureText,
      this.onChanged,
      this.keyboardType})
      : super(key: key);
  final String? placeholder;
  final IconData? icon;
  final bool? obscureText;
  final void Function(String value)? onChanged;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: kTextFieldDecoration,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: CupertinoTextField.borderless(
            prefix: icon == null
                ? null
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Icon(icon),
                  ),
            placeholder: placeholder,
            placeholderStyle: const TextStyle(color: kPrimaryColor77),
            obscureText: obscureText == null ? false : obscureText!,
            onChanged: onChanged,
            keyboardType: keyboardType,
          ),
        ),
      ),
    );
  }
}
