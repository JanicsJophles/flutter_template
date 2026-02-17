import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.all(Radius.circular(32)),
            boxShadow: [
              BoxShadow(
                blurRadius: 24,
                blurStyle: BlurStyle.outer,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            children: [
              NavBarIconButton(customIcon: Icon(Icons.home_outlined)),
              Spacer(),
              NavBarIconButton(customIcon: Icon(Icons.info_outlined)),
              Spacer(),
              NavBarIconButton(customIcon: Icon(Icons.chat_bubble_outline)),
              Spacer(),
              NavBarIconButton(customIcon: Icon(Icons.settings_outlined)),
            ],
          ),
        ),
      ],
    );
  }
}

class NavBarIconButton extends StatelessWidget {
  final Icon customIcon;
  const NavBarIconButton({required this.customIcon, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: customIcon,
      color: Colors.white,
      visualDensity: VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      alignment: Alignment.center,
      hoverColor: null,
    );
  }
}
