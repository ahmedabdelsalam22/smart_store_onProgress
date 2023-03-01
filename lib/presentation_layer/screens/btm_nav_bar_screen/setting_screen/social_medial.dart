import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 16),
      child: Row(
        children: [
          buildIcon(
            FontAwesomeIcons.facebook,
            Uri.parse('https://www.facebook.com/prAhmed20'),
          ),
          const SizedBox(
            width: 15,
          ),
          buildIcon(
            FontAwesomeIcons.youtube,
            Uri.parse(
                'https://www.youtube.com/channel/UCdVxIQ47z0IVm9HdKiNT_2Q'),
          ),
          const SizedBox(
            width: 20,
          ),
          buildIcon(
            FontAwesomeIcons.github,
            Uri.parse('https://github.com/prAhmed20'),
          ),
        ],
      ),
    );
  }

  void _launchURL(url) async {
    await launchUrl(url) ? await launchUrl(url) : throw 'Could not launch $url';
  }

  Widget buildIcon(IconData icon, Uri url) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: Icon(
        icon,
        color: Colors.blue,
        size: 35,
      ),
    );
  }
}
