
import 'package:flutter/cupertino.dart';

class H1Title extends StatelessWidget {

  final String txt;
  const H1Title(this.txt, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(txt, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
  }
}

class H2Title extends StatelessWidget {

  final String txt;
  const H2Title(this.txt, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(txt, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  }
}

class H3Title extends StatelessWidget {

  final String txt;
  const H3Title(this.txt, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(txt, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }
}

class H4Title extends StatelessWidget {

  final String txt;
  const H4Title(this.txt, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(txt, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
  }
}