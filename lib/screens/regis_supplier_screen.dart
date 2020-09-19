import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:padimall_app/providers/toko.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:provider/provider.dart';

class RegisterSupplierScreen extends StatelessWidget {
  static final routeName = 'regis-supplier-screen';

  var _formRegister = GlobalKey<FormState>();
  String _storeName, _address, _NIB, _agentId;
  ProviderToko _providerToko;

  @override
  Widget build(BuildContext context) {
    _providerToko = Provider.of(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registrasi Supplier',
          style: PadiMallTextTheme.sz16weight700(context),
        ),
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 15,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formRegister,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nama Toko',
                      hintText: 'Masukkan nama toko anda',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    maxLength: 30,
                    style: PadiMallTextTheme.sz14weight500(context),
                    validator: (input) {
                      return input.isEmpty ? 'Kolom ini hendak diisi' : null;
                    },
                    onSaved: (input) => _storeName = input,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Alamat Toko',
                      hintText: 'Masukkan alamat lengkap toko anda',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: PadiMallTextTheme.sz14weight500(context),
                    validator: (input) {
                      return input.isEmpty ? 'Kolom ini hendak diisi' : null;
                    },
                    onSaved: (input) => _storeName = input,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'NIB',
                          hintText: 'Cth: 1234567890',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: PadiMallTextTheme.sz14weight500(context),
                        validator: (input) {
                          return input.isEmpty
                              ? 'Kolom ini hendak diisi'
                              : null;
                        },
                        onSaved: (input) => _NIB = input,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4, top: 4),
                        child: Text(
                          'NIB merupakan data yang diberikan oleh Administrator',
                          style: PadiMallTextTheme.sz11weight500Grey(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Kode Agen',
                          hintText: 'Cth: AGEN-002',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: PadiMallTextTheme.sz14weight500(context),
                        validator: (input) {
                          return input.isEmpty
                              ? 'Kolom ini hendak diisi'
                              : null;
                        },
                        onSaved: (input) => _agentId = input,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4, top: 4),
                        child: Text(
                          'Kode agen merupakan data yang diberikan oleh Agen anda',
                          style: PadiMallTextTheme.sz11weight500Grey(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formRegister.currentState.validate()) {
                        _formRegister.currentState.save();
                        _providerToko.setIsAlreadyHaveToko(true);
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                          msg: 'Selamat bergabung dengan PadiMall',
                          fontSize: 13,
                          backgroundColor: Theme.of(context).primaryColor,
                          toastLength: Toast.LENGTH_LONG,
                        );
                      }
                    },
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    child: Text(
                      'Jadi Supplier',
                      style: PadiMallTextTheme.sz16weight700White(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
