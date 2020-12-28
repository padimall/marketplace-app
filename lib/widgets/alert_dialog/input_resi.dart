import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:padimall_app/providers/histories.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:provider/provider.dart';

Future<String> showAlertDialogInputResi(BuildContext context, String invoiceId) {
  var _formResi = GlobalKey<FormState>();
  String receiptNumber;
  ProviderHistories _providerHistories = Provider.of(context, listen: false);

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Masukkan nomor resi',
          style: PadiMallTextTheme.sz14weight600(context),
        ),
        content: Form(
          key: _formResi,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'No. Resi',
                    hintText: 'PADISTIC-01020304',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  autofocus: true,
                  style: PadiMallTextTheme.sz14weight500(context),
                  validator: (input) {
                    return input.isEmpty ? 'Kolom ini harus diisi' : null;
                  },
                  onSaved: (input) => receiptNumber = input,
                ),
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    if (_formResi.currentState.validate()) {
                      _formResi.currentState.save();
                      _providerHistories.postAddReceiptToInvoice(context, invoiceId, receiptNumber);
                    }
                  },
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: PadiMallTextTheme.sz16weight700White(context),
                  ),
                ),
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
      );
    },
  );
}
