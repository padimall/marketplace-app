import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:padimall_app/screens/akun_screen.dart';
import 'package:padimall_app/screens/beranda_screen.dart';
import 'package:padimall_app/screens/kategori_screen.dart';
import 'package:padimall_app/screens/keranjang_screen.dart';
import 'package:padimall_app/utils/check_app_version_services.dart';

class FirstScreen extends StatefulWidget {
  static final routeName = 'first-screen';
  int _selectedIndex = 0;

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final tabs = [
    BerandaScreen(),
    KategoriScreen(),
    KeranjangScreen(),
    AkunScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAppVersion(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[widget._selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget._selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: widget._selectedIndex == 0
                ? Image.asset(
                    'assets/images/home_on.png',
                    height: 20,
                  )
                : Image.asset(
                    'assets/images/home_off.png',
                    height: 20,
                  ),
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
            icon: widget._selectedIndex == 1
                ? Image.asset(
                    'assets/images/category_on.png',
                    height: 20,
                  )
                : Image.asset(
                    'assets/images/category_off.png',
                    height: 20,
                  ),
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
            icon: widget._selectedIndex == 2
                ? Image.asset(
                    'assets/images/cart_on.png',
                    height: 20,
                  )
                : Image.asset(
                    'assets/images/cart_off.png',
                    height: 20,
                  ),
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
            icon: widget._selectedIndex == 3
                ? Image.asset(
                    'assets/images/user_on.png',
                    height: 20,
                  )
                : Image.asset(
                    'assets/images/user_off.png',
                    height: 20,
                  ),
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
