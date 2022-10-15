import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fwc_album_app/app/core/ui/styles/button_styles.dart';
import 'package:fwc_album_app/app/core/ui/styles/colors_app.dart';
import 'package:fwc_album_app/app/core/ui/styles/text_styles.dart';
import 'package:fwc_album_app/app/core/ui/widgets/button.dart';
import 'package:fwc_album_app/app/pages/auth/login/presenter/login_presenter.dart';
import 'package:fwc_album_app/app/pages/auth/login/view/login_view_impl.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;
  const LoginPage({super.key, required this.presenter});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends LoginViewImpl {
  final formKey = GlobalKey<FormState>();

  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primary,
      body: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background_login.png'),
                    fit: BoxFit.cover)),
            child: CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildListDelegate.fixed([
                  SizedBox(
                    height: MediaQuery.of(context).size.height *
                        (MediaQuery.of(context).size.width > 350 ? .30 : .25),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Center(
                      child: Text(
                        'Login',
                        style: context.textStyles.titleWhite,
                      ),
                    ),
                  ),
                  TextFormField(
                      validator: Validatorless.multiple([
                        Validatorless.required('Obrigatório'),
                        Validatorless.email('E-mail inválido'),
                      ]),
                      decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          label: Text('E-mail'))),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      obscureText: true,
                      validator: Validatorless.multiple([
                        Validatorless.required('Obrigatório'),
                        Validatorless.min(
                            6, 'Senha deve conter pelo menos 6 caracteres'),
                      ]),
                      decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          label: Text('Senha'))),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Text(
                      'Esqueceu a senha ?',
                      style: context.textStyles.textSecondaryMedium
                          .copyWith(color: context.colors.yellow),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Button(
                      width: MediaQuery.of(context).size.width * .9,
                      onPressed: () {
                        final formValid =
                            formKey.currentState?.validate() ?? false;
                        if (formValid) {
                          showLoader();
                          widget.presenter.login(emailEC.text, passwordEC.text);
                        }
                      },
                      style: context.buttonStyles.yellowButton,
                      labelStyle:
                          context.textStyles.textSecondaryExtraBoldPrimaryColor,
                      label: 'Entrar')
                ])),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      const Spacer(),
                      Text.rich(
                        style: context.textStyles.textSecondaryMedium
                            .copyWith(color: Colors.white),
                        TextSpan(text: 'Não possui uma conta?', children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context)
                                    .popAndPushNamed('/auth/register'),
                              text: 'Cadastra-se',
                              style: context.textStyles.textSecondaryMedium
                                  .copyWith(color: context.colors.yellow))
                        ]),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
