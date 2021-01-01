import 'package:flutter/material.dart';
import 'package:padimall_app/providers/banners.dart';
import 'package:padimall_app/providers/cart.dart';
import 'package:padimall_app/providers/histories.dart';
import 'package:padimall_app/providers/product_categories.dart';
import 'package:padimall_app/providers/products.dart';
import 'package:padimall_app/providers/toko.dart';
import 'package:padimall_app/providers/user.dart';
import 'package:padimall_app/screens/checkout_screen.dart';
import 'package:padimall_app/screens/detail_pembelian.dart';
import 'package:padimall_app/screens/detail_penjualan.dart';
import 'package:padimall_app/screens/edit_password_screen.dart';
import 'package:padimall_app/screens/first_screen.dart';
import 'package:padimall_app/screens/forgot_pass_sent_screen.dart';
import 'package:padimall_app/screens/forgot_password_screen.dart';
import 'package:padimall_app/screens/info_agent_edit_screen.dart';
import 'package:padimall_app/screens/info_agent_screen.dart';
import 'package:padimall_app/screens/info_buyer_screen.dart';
import 'package:padimall_app/screens/info_toko_edit_screen.dart';
import 'package:padimall_app/screens/info_toko_screen.dart';
import 'package:padimall_app/screens/invoice_payment_screen.dart';
import 'package:padimall_app/screens/keranjang_screen.dart';
import 'package:padimall_app/screens/list_suppliers_product_screen.dart';
import 'package:padimall_app/screens/login_screen.dart';
import 'package:padimall_app/screens/pembelian_screen.dart';
import 'package:padimall_app/screens/penjualan_screen.dart';
import 'package:padimall_app/screens/product_by_category_screen.dart';
import 'package:padimall_app/screens/product_by_maincategory_screen.dart';
import 'package:padimall_app/screens/product_detail_screen.dart';
import 'package:padimall_app/screens/product_search_screen.dart';
import 'package:padimall_app/screens/produk_anda_screen.dart';
import 'package:padimall_app/screens/produk_edit_screen.dart';
import 'package:padimall_app/screens/produk_supplier_anda.dart';
import 'package:padimall_app/screens/produk_tambah_screen.dart';
import 'package:padimall_app/screens/produk_viewonly_screen.dart';
import 'package:padimall_app/screens/regis_agent_screen.dart';
import 'package:padimall_app/screens/regis_supplier_screen.dart';
import 'package:padimall_app/screens/register_screen.dart';
import 'package:padimall_app/screens/review_product_screen.dart';
import 'package:padimall_app/screens/splash_screen.dart';
import 'package:padimall_app/screens/toko_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Map<int, Color> color = {
    50: Color.fromRGBO(206, 160, 30, 0.1),
    100: Color.fromRGBO(206, 160, 30, 0.2),
    200: Color.fromRGBO(206, 160, 30, 0.3),
    300: Color.fromRGBO(206, 160, 30, 0.4),
    400: Color.fromRGBO(206, 160, 30, 0.5),
    500: Color.fromRGBO(206, 160, 30, 0.6),
    600: Color.fromRGBO(206, 160, 30, 0.7),
    700: Color.fromRGBO(206, 160, 30, 0.8),
    800: Color.fromRGBO(206, 160, 30, 0.9),
    900: Color.fromRGBO(206, 160, 30, 1),
  };

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ProviderUser(),),
        ChangeNotifierProvider(create: (ctx) => ProviderHistories(),),
        ChangeNotifierProvider(create: (ctx) => ProviderToko(),),
        ChangeNotifierProvider(create: (ctx) => ProviderProductCategories(),),
        ChangeNotifierProvider(create: (ctx) => ProviderProduct(),),
        ChangeNotifierProvider(create: (ctx) => ProviderBanner(),),
        ChangeNotifierProvider(create: (ctx) => ProviderCart(),),
      ],
      child: MaterialApp(
        title: 'PadiMall',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: MaterialColor(0xFF84B214, color),
          primaryColor: MaterialColor(0xFF84B214, color),
          accentColor: MaterialColor(0xFFF97C2D, color),
          toggleableActiveColor: MaterialColor(0xFF84B214, color),
          indicatorColor: MaterialColor(0xFF84B214, color),
          backgroundColor: Colors.grey[100],
          scaffoldBackgroundColor: Colors.grey[100],
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
        routes: {
          LoginScreen.routeName: (ctx) => LoginScreen(),
          RegisterScreen.routeName: (ctx) => RegisterScreen(),
          FirstScreen.routeName: (ctx) => FirstScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          ProdukAndaScreen.routeName: (ctx) => ProdukAndaScreen(),
          ProdukTambahScreen.routeName: (ctx) => ProdukTambahScreen(),
          ProdukEditScreen.routeName: (ctx) => ProdukEditScreen(),
          KeranjangScreen.routeName: (ctx) => KeranjangScreen(),
          CheckoutScreen.routeName: (ctx) => CheckoutScreen(),
          PenjualanScreen.routeName: (ctx) => PenjualanScreen(),
          PembelianScreen.routeName: (ctx) => PembelianScreen(),
          DetailPembelianScreen.routeName: (ctx) => DetailPembelianScreen(),
          DetailPenjualanScreen.routeName: (ctx) => DetailPenjualanScreen(),
          InfoTokoScreen.routeName: (ctx) => InfoTokoScreen(),
          InfoBuyerScreen.routeName: (ctx) => InfoBuyerScreen(),
          RegisterSupplierScreen.routeName: (ctx) => RegisterSupplierScreen(),
          ProductByCategoryScreen.routeName: (ctx) => ProductByCategoryScreen(),
          InfoTokoEditScreen.routeName: (ctx) => InfoTokoEditScreen(),
          InfoAgentScreen.routeName: (ctx) => InfoAgentScreen(),
          EditPasswordScreen.routeName: (ctx) => EditPasswordScreen(),
          InfoAgentEditScreen.routeName: (ctx) => InfoAgentEditScreen(),
          RegisterAgentScreen.routeName: (ctx) => RegisterAgentScreen(),
          ListSupplierProductScreen.routeName: (ctx) => ListSupplierProductScreen(),
          ProdukSupplierAnda.routeName: (ctx) => ProdukSupplierAnda(),
          ProdukViewOnlyScreen.routeName: (ctx) => ProdukViewOnlyScreen(),
          ForgotPasswordScreen.routeName: (ctx) => ForgotPasswordScreen(),
          ForgotPassSentScreen.routeName: (ctx) => ForgotPassSentScreen(),
          ProductSearchScreen.routeName: (ctx) => ProductSearchScreen(),
          ProductByMainCategoryScreen.routeName: (ctx) => ProductByMainCategoryScreen(),
          InvoicePaymentScreen.routeName: (ctx) => InvoicePaymentScreen(),
          TokoProductScreen.routeName: (ctx) => TokoProductScreen(),
          ReviewProductScreen.routeName: (ctx) => ReviewProductScreen(),
        },
      ),
    );
  }
}