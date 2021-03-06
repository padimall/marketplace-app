import 'package:flutter/material.dart';
import 'package:padimall_app/providers/user.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:provider/provider.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class EditBuyerDialogWidget {
  static void show(BuildContext context, String label, String value, int indexProfile) {
    ProviderUser _providerUser = Provider.of(context, listen: false);
    var _formEdit = GlobalKey<FormState>();
    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = value;

    TextInputType _keyboardType;
    int _maxLength;
    var _validator;

    switch (indexProfile) {
      case 0:
        _keyboardType = TextInputType.text;
        _maxLength = 20;
        break;
      case 1:
        _keyboardType = TextInputType.number;
        _maxLength = 14;
        break;
      case 2:
        _keyboardType = TextInputType.text;
        _maxLength = 40;
        _validator = Validators.compose([
          Validators.required('Kolom ini hendak diisi'),
          Validators.patternRegExp(RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'), 'Format Email salah')
        ]);
        break;
      case 3:
        _keyboardType = TextInputType.text;
        _maxLength = 50;
        break;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Form(
            key: _formEdit,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: '$label',
                  ),
                  keyboardType: _keyboardType,
                  validator: _validator,
                  style: PadiMallTextTheme.sz14weight500(context),
                  controller: textEditingController,
                  textAlignVertical: TextAlignVertical.top,
                  maxLength: _maxLength,
                  maxLines: 2,
                  autofocus: true,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 8),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formEdit.currentState.validate()) {
                        _formEdit.currentState.save();
                        _providerUser.updateUserProfile(context, textEditingController, indexProfile);
                      }
                    },
                    child: Text(
                      'Simpan',
                      style: PadiMallTextTheme.sz14weight700White(context),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                )
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
}