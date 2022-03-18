import 'package:car_e_commerce/bloc/cubit/login_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/auth_repository.dart';

// ? can i change of the stateful to be statless without changing keyform for validation

class SignScreen extends StatefulWidget {
  SignScreen({Key? key}) : super(key: key);

  static Page pageRoute() {
    return MaterialPage(
      child: SignScreen(),
    );
  }

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthRepository _auth = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Form(
          key: _formKey,
          child: BlocProvider(
            create: (context) => LoginCubit(_auth),
            child: Column(
              children: [
                _EmailTextField(emailController: _emailController),
                SizedBox(height: 40),
                _PasswordTextField(passwordController: _passwordController),
                SizedBox(height: 40),
                _SignInBtn(
                    formKey: _formKey,
                    emailController: _emailController,
                    passwordController: _passwordController),
                _SignInWithGoogleBtn(),
                // * error handler from the firebase
                Builder(builder: (context) {
                  String? error =
                      context.watch<LoginCubit>().state.errorMessage ??
                          'no error occur';
                  return Text(error);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField({
    Key? key,
    required TextEditingController emailController,
  })  : _emailController = emailController,
        super(key: key);

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          controller: _emailController,
          onChanged: (value) {
            context.read<LoginCubit>().emailChange(value);
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'required field';
            }
          },
        );
      },
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField({
    Key? key,
    required TextEditingController passwordController,
  })  : _passwordController = passwordController,
        super(key: key);

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          controller: _passwordController,
          onChanged: (value) {
            context.read<LoginCubit>().passwordChange(value);
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'password is required';
            }
          },
        );
      },
    );
  }
}

class _SignInBtn extends StatelessWidget {
  _SignInBtn({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final AuthRepository _auth = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == LoginStatus.submitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  primary: const Color(0xFFFFD600),
                ),
                onPressed: () => context
                    .read<LoginCubit>()
                    .signInWithFirebaseByEmailAndPassword(),
                child: const Text('LOGIN'),
              );
      },
    );
  }
}

class _SignInWithGoogleBtn extends StatelessWidget {
  final AuthRepository _auth = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == LoginStatus.submitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  primary: const Color(0xFFFFD600),
                ),
                onPressed: () => context
                    .read<LoginCubit>()
                    .signInWithGoogle(),
                child: const Text('LOGIN USING GOOGLE'),
              );
      },
    );
  }
}
