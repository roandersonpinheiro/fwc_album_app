import 'package:flutter/material.dart';
import 'package:fwc_album_app/app/core/ui/styles/text_styles.dart';
import 'package:fwc_album_app/app/core/ui/widgets/button.dart';
import 'package:fwc_album_app/app/pages/auth/register/presenter/register_presenter.dart';
import 'package:fwc_album_app/app/pages/auth/register/view/register_view_impl.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  final RegisterPresenter presenter;
  const RegisterPage({super.key, required this.presenter});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends RegisterViewImpl {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final confirmPasswordEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    confirmPasswordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 106.82,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/bola.png'),
                            fit: BoxFit.fill)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Cadastrar usuário',
                    style: context.textStyles.textBlack,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        TextFormField(
                          validator: Validatorless.required('Obrigatório'),
                          controller: nameEC,
                          decoration: const InputDecoration(
                              label: Text('Nome completo *')),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            validator: Validatorless.multiple([
                              Validatorless.required('Obrigatório'),
                              Validatorless.email('E-mail inválido'),
                            ]),
                            controller: emailEC,
                            decoration:
                                const InputDecoration(label: Text('E-mail *'))),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            obscureText: true,
                            validator: Validatorless.multiple([
                              Validatorless.required('Obrigatório'),
                              Validatorless.min(6,
                                  'Senha deve conter pelo menos 6 caracteres'),
                            ]),
                            controller: passwordEC,
                            decoration:
                                const InputDecoration(label: Text('Senha *'))),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            obscureText: true,
                            validator: Validatorless.multiple([
                              Validatorless.required('Obrigatório'),
                              Validatorless.min(6,
                                  'Senha deve conter pelo menos 6 caracteres'),
                              Validatorless.compare(confirmPasswordEC,
                                  'Senha diferente de confirma senha')
                            ]),
                            controller: confirmPasswordEC,
                            decoration: const InputDecoration(
                                label: Text('Confirmar senha *'))),
                        const SizedBox(
                          height: 20,
                        ),
                        Button.primary(
                            width: MediaQuery.of(context).size.width * .9,
                            onPressed: () {
                              final formValid =
                                  formKey.currentState?.validate() ?? false;
                              if (formValid) {
                                showLoader();
                                widget.presenter.register(
                                    name: nameEC.text,
                                    email: emailEC.text,
                                    password: passwordEC.text,
                                    confirmPassword: confirmPasswordEC.text);
                              }
                            },
                            label: 'Cadastrar')
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
