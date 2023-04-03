import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/abstract_provider.dart';
import '../../../generated/abstract_state.dart';
import '../../../shared_product/widgets/text_field/custom_text_field.dart';
import 'personal_information_provider.dart';
import '../../../shared_product/widgets/default_appbar.dart';
import 'package:flutter_datetime_picker_pro/flutter_datetime_picker_pro.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState
    extends AbstractState<PersonalInformationScreen> {
  late PersonalInformationProvider provider;
  bool isDisplayBirtday = false;
  @override
  AbstractProvider initProvider() {
    return provider;
  }

  @override
  BuildContext initContext() {
    return context;
  }

  @override
  void onCreate() {
    provider = PersonalInformationProvider();
  }

  @override
  void onReady() {
    // TODO: implement onReady
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => provider,
      builder: (context, child) {
        return Consumer<PersonalInformationProvider>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              appBar: DefaultAppBar(appBarTitle: "sample appbar"),
              body: body,
            );
          },
        );
      },
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 9,
          child: Column(
            children: [
              buildTitle(),
              SizedBox(height: 8),
              buildText(),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTitle() {
    return Container(
      width: screenWidth(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(),
          Text("Enter your Name, Email, and Password for sign up."),
          GestureDetector(
            onTap: () {
              popTopDisplay();
            },
            child: Text(
              "Already have account?",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
        ],
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
          buildBirtDay(),
        ],
      ),
    );
  }

  Widget buildBirtDay() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                isDisplayBirtday = true;
                notifyDataChanged();
              },
              child: Icon(
                Icons.calendar_month,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        if (isDisplayBirtday) ...[
          SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime(1969, 1, 1),
              onDateTimeChanged: (DateTime newDateTime) {
                // Do something
                print(newDateTime);
              },
            ),
          ),
        ],
      ],
    );
  }

  @override
  void onDispose() {}
}
