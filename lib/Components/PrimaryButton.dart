import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String btnname;
  final VoidCallback onTap;

  const PrimaryButton({
    super.key,
    required this.btnname,
    required this.onTap,
    required Widget child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 50,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              btnname,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.background,
                  letterSpacing: 2),
            ),
          ],
        ),
      ),
    );

    Flexible(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: 300,
            height: 50,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  btnname,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.background,
                      letterSpacing: 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
