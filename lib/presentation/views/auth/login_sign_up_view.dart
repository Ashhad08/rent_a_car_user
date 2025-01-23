import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../blocs/loading_bloc/loading_bloc.dart';
import '../../../constants/extensions.dart';
import '../../../domain/implementations/auth/auth_repository.dart';
import '../../../domain/services/image_services.dart';
import '../../../domain/services/session_manager.dart';
import '../../../generated/assets.dart';
import '../../../navigation/navigation_helper.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../home_view/home_view.dart';

class LoginSignUpView extends StatelessWidget {
  const LoginSignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoadingBloc(),
      child: DefaultTabController(
        length: 2,
        child: Builder(builder: (context) {
          return LoadingOverlay(
            isLoading:
                context.select((LoadingBloc bloc) => bloc.state.isLoading),
            progressIndicator: CircularProgressIndicator.adaptive(),
            child: Scaffold(
              body: SafeArea(
                  child: Stack(
                children: [
                  Positioned.fill(child: ColoredBox(color: Colors.black)),
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.4,
                      child: Image.asset(
                        Assets.imagesLoginBg,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Column(
                      children: [
                        Container(
                          height: 140,
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: Color(0xff636363).withOp(0.3),
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(30),
                            ),
                          ),
                          child: Image.asset(Assets.imagesAppLogo),
                        ),
                        30.height,
                        TabBar(
                          tabs: [
                            Tab(
                              text: 'Sign In',
                            ),
                            Tab(
                              text: 'Sign Up',
                            )
                          ],
                          dividerHeight: 0,
                          indicatorColor: Colors.white,
                          labelColor: Colors.white,
                          labelStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                          tabAlignment: TabAlignment.center,
                        ),
                        Expanded(
                            child: TabBarView(children: [
                          LoginView(),
                          SignupView(),
                        ]))
                      ],
                    ),
                  )
                ],
              )),
            ),
          );
        }),
      ),
    );
  }
}

class SignupView extends StatefulWidget {
  const SignupView({
    super.key,
  });

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailAddress = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final ValueNotifier<File?> _profileImage = ValueNotifier(null);
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _emailAddress.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _profileImage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              ValueListenableBuilder(
                  valueListenable: _profileImage,
                  builder: (context, image, _) {
                    return GestureDetector(
                      onTap: () {
                        getIt<ImageServices>().pickImage(
                          ImageSource.gallery,
                          (p0) {
                            _profileImage.value = p0;
                          },
                        );
                      },
                      child: Container(
                        height: 92,
                        width: 92,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.colorScheme.onPrimary,
                          image: image != null
                              ? DecorationImage(
                                  fit: BoxFit.cover, image: FileImage(image))
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: image != null
                            ? null
                            : Text(
                                'Select Image',
                                style: TextStyle(
                                    fontSize: 8, fontWeight: FontWeight.w500),
                              ),
                      ),
                    );
                  }),
              34.height,
              AppTextField(
                controller: _fullNameController,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Enter full name';
                  }
                  return null;
                },
                hintText: 'Full Name',
              ),
              16.height,
              AppTextField(
                controller: _phoneNumberController,
                textInputType: TextInputType.phone,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Enter full name';
                  } else if (v.isNotEmpty && !v.isMobileNumber) {
                    return 'Enter valid number';
                  }
                  return null;
                },
                hintText: 'Phone number with country code',
              ),
              16.height,
              AppTextField(
                controller: _emailAddress,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Kindly enter email';
                  } else if (v.isNotEmpty && !v.isEmail) {
                    return 'Enter valid email';
                  }
                  return null;
                },
                hintText: 'Email Address',
              ),
              16.height,
              AppTextField(
                controller: _passwordController,
                isPasswordField: true,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Kindly enter password';
                  }
                  return null;
                },
                hintText: 'Password',
              ),
              16.height,
              AppTextField(
                controller: _confirmPasswordController,
                isPasswordField: true,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Kindly confirm password';
                  } else if (v != _passwordController.text) {
                    return 'Password dose not match';
                  }
                  return null;
                },
                hintText: 'Confirm Password',
              ),
              24.height,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final utils = getIt<Utils>();
                    if (_profileImage.value == null) {
                      utils.showErrorFlushBar(context,
                          message: 'Select Profile Image');
                    }
                    if (_key.currentState!.validate() &&
                        !context.read<LoadingBloc>().state.isLoading) {
                      final repo = getIt<AuthRepository>();

                      try {
                        context.read<LoadingBloc>().add(StartLoading());
                        final res = await repo.signUp(
                            email: _emailAddress.text.trim(),
                            fullName: _fullNameController.text.trim(),
                            phoneNumber: _phoneNumberController.text.trim(),
                            imagePath: _profileImage.value?.path,
                            password: _passwordController.text.trim());
                        if (mounted && context.mounted) {
                          context.read<LoadingBloc>().add(StopLoading());
                          DefaultTabController.of(context).animateTo(0);
                          utils.showSuccessFlushBar(context,
                              message: "${res.message}, Kindly Login");
                        }
                      } catch (e, stackTrace) {
                        if (context.mounted) {
                          debugPrint(stackTrace.toString());
                          context.read<LoadingBloc>().add(StopLoading());
                          utils.showErrorFlushBar(context,
                              message: e.toString());
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: context.colorScheme.secondary),
                  child: Text(
                    'Create Account',
                  ),
                ).space(height: 54, width: double.infinity),
              ),
              24.height,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                        onPressed: () async {
                          await SessionManager().setUserIsAsGuest();
                          if (mounted && context.mounted) {
                            getIt<NavigationHelper>()
                                .pushReplacement(context, const HomeView());
                          }
                        },
                        child: Text('Continue as a Guest'))
                    .space(height: 54, width: double.infinity),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _emailNode = FocusNode();
  final _passwordController = TextEditingController();
  final _passwordNode = FocusNode();
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _emailNode.dispose();
    _passwordController.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              AppTextField(
                controller: _emailController,
                focusNode: _emailNode,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Kindly enter email';
                  } else if (v.isNotEmpty && !v.isEmail) {
                    return 'Enter valid email';
                  }
                  return null;
                },
                onFieldSubmitted: (p0) {
                  FocusScope.of(context).requestFocus(_passwordNode);
                },
                hintText: 'Email Address',
              ),
              16.height,
              AppTextField(
                controller: _passwordController,
                focusNode: _passwordNode,
                isPasswordField: true,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Kindly enter password';
                  }
                  return null;
                },
                hintText: 'Password',
              ),
              24.height,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final utils = getIt<Utils>();
                    if (_key.currentState!.validate() &&
                        !context.read<LoadingBloc>().state.isLoading) {
                      final repo = getIt<AuthRepository>();

                      try {
                        context.read<LoadingBloc>().add(StartLoading());
                        final res = await repo.login(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim());
                        if (mounted && context.mounted) {
                          context.read<LoadingBloc>().add(StopLoading());
                          getIt<NavigationHelper>()
                              .pushReplacement(context, const HomeView());
                          utils.showSuccessFlushBar(context,
                              message: res.message ?? "LoggedIn Successfully");
                        }
                      } catch (e, stackTrace) {
                        if (context.mounted) {
                          debugPrint(stackTrace.toString());
                          context.read<LoadingBloc>().add(StopLoading());
                          utils.showErrorFlushBar(context,
                              message: e.toString());
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: context.colorScheme.secondary),
                  child: Text(
                    'Login',
                  ),
                ).space(height: 54, width: double.infinity),
              ),
              40.height,
              Align(
                alignment: Alignment.center,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: context.colorScheme.onPrimary),
                    )),
              ),
              24.height,
              ElevatedButton(
                      onPressed: () async {
                        await SessionManager().setUserIsAsGuest();
                        if (mounted && context.mounted) {
                          getIt<NavigationHelper>()
                              .pushReplacement(context, const HomeView());
                        }
                      },
                      child: Text('Continue as a Guest'))
                  .space(height: 54, width: double.infinity)
            ],
          ),
        ),
      ),
    );
  }
}
