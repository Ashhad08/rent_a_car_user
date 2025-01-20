import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/app_text_field/app_text_field_bloc.dart';
import '../../constants/extensions.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.onChanged,
    this.textInputType,
    this.isPasswordField = false,
    this.readOnly,
    this.textCapitalization,
    this.prefixIcon,
    this.maxLines,
    this.suffix,
    this.isDense = false,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
    this.onTap,
    this.isDarkMode = false,
  });

  /// Named constructor for the dark version
  const AppTextField.dark({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.onChanged,
    this.textInputType,
    this.readOnly,
    this.textCapitalization,
    this.prefixIcon,
    this.maxLines,
    this.suffix,
    this.isDense = false,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
    this.onTap,
    this.isPasswordField = false,
  }) : isDarkMode = true;

  final TextEditingController controller;
  final String hintText;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final void Function(String?)? onFieldSubmitted;
  final TextInputType? textInputType;
  final bool isPasswordField;
  final bool? readOnly;
  final TextCapitalization? textCapitalization;
  final Widget? prefixIcon;
  final int? maxLines;
  final Widget? suffix;
  final TextInputAction? textInputAction;
  final bool isDense;
  final GestureTapCallback? onTap;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AppTextFieldBloc()..add(InitObscureTextEvent(isPasswordField)),
      child: BlocBuilder<AppTextFieldBloc, AppTextFieldState>(
        builder: (context, state) {
          final textStyle = GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.white : Colors.black,
          );
          final hintStyle = GoogleFonts.poppins(
            fontSize: isDarkMode ? 14 : 12,
            fontWeight: FontWeight.w400,
            color:
                isDarkMode ? const Color(0xff4F585F) : const Color(0xff6A6A6A),
          );
          final fillColor = isDarkMode
              ? const Color(0xff323B42)
              : context.colorScheme.onPrimary;

          return TextFormField(
            onTap: onTap,
            focusNode: focusNode,
            maxLines: maxLines ?? 1,
            validator: validator,
            textInputAction: textInputAction,
            onFieldSubmitted: onFieldSubmitted,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            readOnly: readOnly ?? false,
            style: textStyle,
            obscureText: state.obscureText,
            controller: controller,
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            keyboardType: textInputType ?? TextInputType.text,
            decoration: InputDecoration(
              isDense: isDense,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: context.colorScheme.primary,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: context.colorScheme.error,
                ),
              ),
              hintText: hintText,
              filled: true,
              fillColor: fillColor,
              prefixIconColor: isDarkMode ? Color(0xff8F8F8F) : null,
              prefixIcon: prefixIcon == null
                  ? null
                  : Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: prefixIcon,
                    ),
              hintStyle: hintStyle,
              suffixIcon: isPasswordField
                  ? IconButton(
                      onPressed: () {
                        context
                            .read<AppTextFieldBloc>()
                            .add(ToggleObscureTextEvent());
                      },
                      icon: state.obscureText
                          ? Icon(
                              CupertinoIcons.eye_slash,
                              color: isDarkMode
                                  ? const Color(0xff8F8F8F)
                                  : context.colorScheme.onPrimary,
                            )
                          : Icon(
                              CupertinoIcons.eye,
                              color: isDarkMode
                                  ? const Color(0xff8F8F8F)
                                  : context.colorScheme.onPrimary,
                            ),
                    )
                  : suffix,
            ),
          );
        },
      ),
    );
  }
}
