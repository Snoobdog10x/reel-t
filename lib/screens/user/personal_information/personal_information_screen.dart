import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/shared_product/widgets/button/three_row_button.dart';
import 'package:reel_t/shared_product/widgets/image/image_gallery_picker/image_gallery_picker_screen.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import '../../../shared_product/widgets/image/circle_image.dart';
import '../../../shared_product/widgets/text_field/custom_text_field.dart';
import 'personal_information_bloc.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      PersonalInformationScreenState();
}

class PersonalInformationScreenState
    extends AbstractState<PersonalInformationScreen> {
  late PersonalInformationBloc bloc;
  bool isDisplayBirtday = false;
  bool isBirthdayFocus = false;
  DateTime userBirthday = new DateTime(2001);
  @override
  AbstractBloc initBloc() {
    return bloc;
  }

  @override
  BuildContext initContext() {
    return context;
  }

  @override
  void onCreate() {
    bloc = PersonalInformationBloc();
  }

  @override
  void onReady() {
    // TODO: implement onReady
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => bloc,
      builder: (context, child) {
        return Consumer<PersonalInformationBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              isPushLayoutWhenShowKeyboard: true,
              padding: EdgeInsets.symmetric(
                horizontal: 18,
              ),
              appBar: DefaultAppBar(
                appBarTitle: "Personal Information",
                onTapBackButton: () {
                  popTopDisplay();
                },
              ),
              body: body,
            );
          },
        );
      },
    );
  }

  Widget buildBody() {
    return ListView(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        SizedBox(height: 8 * 6),
        buildAvatar(),
        SizedBox(height: 8),
        buildText(),
        SizedBox(height: 8),
        SizedBox(height: 8 * 3),
        submitButton(),
        SizedBox(height: 8),
      ],
    );
  }

  Widget getAvatar() {
    if (bloc.avatar == null)
      return Container(
        height: 130,
        width: 130,
        child: Icon(
          Icons.people,
          size: 80,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[300],
        ),
      );

    return Container(
      height: 130,
      width: 130,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
        image: DecorationImage(
          image: MemoryImage(bloc.avatar!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildAvatar() {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (appStore.isWeb()) {
              bloc.pickImage();
              return;
            }
            showMobileImagePicker();
          },
          child: Container(
            alignment: Alignment.center,
            child: getAvatar(),
            height: 140,
            width: 140,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  void showMobileImagePicker() {
    showScreenBottomSheet(
      Container(
        height: screenHeight() * 0.7,
        child: ImageGalleryPickerScreen(
          isPickMultiple: false,
          onFileSelected: (files) async {
            bloc.avatar = await files.first.readAsBytes();
            notifyDataChanged();
          },
        ),
      ),
    );
  }

  Widget buildText() {
    return Container(
      width: screenWidth(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            hintText: "First name",
            onTextChanged: (value) {},
          ),
          SizedBox(height: 8),
          CustomTextField(
            hintText: "Last name",
            onTextChanged: (value) {},
          ),
          SizedBox(height: 8),
          CustomTextField(
            hintText: "User name",
            onTextChanged: (value) {},
          ),
          SizedBox(height: 8),
          CustomTextField(
            hintText: "Phone number",
            onTextChanged: (value) {},
          ),
          SizedBox(height: 8),
          buildBirthday(),
        ],
      ),
    );
  }

  Widget buildBirthday() {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        hintText: bloc.formatDate(userBirthday),
        hintStyle: TextStyle(fontSize: 16),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.green,
            width: 1,
          ),
        ),
        contentPadding: EdgeInsets.all(16),
        suffixIcon: GestureDetector(
          onTap: () {
            showScreenBottomSheet(buildBirtDayPicker());
            notifyDataChanged();
          },
          child: Icon(
            Icons.calendar_month,
            color: Colors.grey,
          ),
        ),
      ),
      onChanged: (value) {},
    );
  }

  Widget buildBirtDayPicker() {
    return Container(
      color: Colors.white,
      height: 400,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        initialDateTime: userBirthday,
        onDateTimeChanged: (DateTime newDateTime) {
          userBirthday = newDateTime;
          notifyDataChanged();
        },
      ),
    );
  }

  Widget submitButton() {
    return ThreeRowButton(
      color: Colors.green,
      title: Text(
        "SUBMIT",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  void onDispose() {}
}
