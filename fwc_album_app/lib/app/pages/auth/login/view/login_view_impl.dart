import 'package:fwc_album_app/app/core/ui/helpers/loader.dart';
import 'package:fwc_album_app/app/core/ui/helpers/messages.dart';
import 'package:fwc_album_app/app/pages/auth/login/login_page.dart';
import 'package:flutter/widgets.dart';
import 'package:fwc_album_app/app/pages/auth/login/view/login_view.dart';

abstract class LoginViewImpl extends State<LoginPage>
    with Loader<LoginPage>, Messages<LoginPage>
    implements LoginView {
  @override
  void initState() {
    widget.presenter.view = this;
    super.initState();
  }

  @override
  void error(String message) {
    hideLoader();
    showError(message);
  }

  @override
  void sucess() {
    hideLoader();
     Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (route) => false);
  }
}
