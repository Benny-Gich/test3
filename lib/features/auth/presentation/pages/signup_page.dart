import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test3/core/common/widgets/utils/loader.dart';
import 'package:test3/core/common/widgets/utils/show_snackbar.dart';
import 'package:test3/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:test3/features/auth/presentation/pages/login_page.dart';
import 'package:test3/features/auth/presentation/widgets/auth_button.dart';
import 'package:test3/features/auth/presentation/widgets/auth_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static String route = 'SignupRoute';
  static String path = '/signup';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthSignUp(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          passWord: _passwordController.text.trim(),
        ),
      );
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Center(
            child: SingleChildScrollView(
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthFailure) {
                    showSnackBar(context, state.message);
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return Loader();
                  }
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Sign Up',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 32),
                        AuthField(
                          controller: _nameController,
                          hintText: 'Name',
                          validator: _validateName,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 16),
                        AuthField(
                          controller: _emailController,
                          hintText: 'Email',
                          validator: _validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 16),
                        AuthField(
                          controller: _passwordController,
                          hintText: 'Password',
                          isObscure: true,
                          validator: _validatePassword,
                          textInputAction: TextInputAction.done,
                          //  onFieldSubmitted: (_) => _handleSignUp(),
                        ),
                        const SizedBox(height: 32),
                        BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is AuthFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.message),
                                  backgroundColor: theme.colorScheme.error,
                                ),
                              );
                            } else if (state is AuthSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Sign up successful!'),
                                  backgroundColor: theme.colorScheme.primary,
                                ),
                              );
                              Navigator.pop(context);
                            }
                          },
                          builder: (context, state) {
                            return AuthButton(
                              onPressed: _handleSignUp,
                              buttonName: 'Sign Up',
                              isLoading: state is AuthLoading,
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        GestureDetector(
                          onTap: () {
                            context.router.navigate(
                              NamedRoute(LogInPage.route),
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                color: theme.colorScheme.tertiary,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Sign In',
                                  style: TextStyle(
                                    color: theme.colorScheme.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
