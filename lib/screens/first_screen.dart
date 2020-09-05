import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:padimall_app/screens/akun_screen.dart';
import 'package:padimall_app/screens/beranda_screen.dart';
import 'package:padimall_app/screens/keranjang_screen.dart';

class FirstScreen extends StatefulWidget {
  static final routeName = 'first-screen';
  int _selectedIndex = 0;

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final tabs = [
    BerandaScreen(),
    Center(
      child: Text('Kategori'),
    ),
    KeranjangScreen(),
    AkunScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[widget._selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget._selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: FittedBox(
              child: Text(
                'Beranda',
                style: GoogleFonts.poppins().copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: FittedBox(
              child: Text(
                'Kategori',
                style: GoogleFonts.poppins().copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: FittedBox(
              child: Text(
                'Keranjang',
                style: GoogleFonts.poppins().copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: FittedBox(
              child: Text(
                'Akun',
                style: GoogleFonts.poppins().copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            widget._selectedIndex = index;
          });
        },
      ),
    );
  }
}
