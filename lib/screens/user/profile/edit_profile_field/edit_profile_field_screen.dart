import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/shared_product/widgets/text_field/custom_text_field.dart';
import '../../../../generated/abstract_bloc.dart';
import '../../../../generated/abstract_state.dart';
import '../../../../shared_product/utils/text/shared_text_style.dart';
import 'edit_profile_field_bloc.dart';

class EditProfileFieldScreen extends StatefulWidget {
  final String fieldName;
  const EditProfileFieldScreen({
    super.key,
    required this.fieldName,
  });

  @override
  State<EditProfileFieldScreen> createState() => EditProfileFieldScreenState();
}

class EditProfileFieldScreenState
    extends AbstractState<EditProfileFieldScreen> {
  late EditProfileFieldBloc bloc;
  late TextEditingController _controllerName = TextEditingController();
  late TextEditingController _controllerUserName = TextEditingController();
  late TextEditingController _controllerBio = TextEditingController();

  int charLengthName = 0;
  int charLengthBio = 0;
  _onChanged(String value) {
    _controllerUserName.text = value;
    charLengthName = value.length;
    charLengthBio = value.length;
    notifyDataChanged();
  }

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
    bloc = EditProfileFieldBloc();
    bloc.init();
    _controllerName.text = bloc.currentUserProfile.fullName;
    _controllerUserName.text = bloc.currentUserProfile.userName;
    _controllerBio.text = bloc.currentUserProfile.bio;

    charLengthName = bloc.currentUserProfile.fullName.length;
    charLengthBio = bloc.currentUserProfile.bio.length;
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
        return Consumer<EditProfileFieldBloc>(
          builder: (context, value, child) {
            var appBar = buildAppbar(widget.fieldName);
            var body = buildBody();
            return buildScreen(
              appBar: appBar,
              body: body,
            );
          },
        );
      },
    );
  }

  Widget buildAppbar(String fieldName) {
    return Padding(
      padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      popTopDisplay();
                    },
                    child: Text('Cancel'),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Center(
                  child: Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          fieldName,
                          style: TextStyle(
                            fontSize: SharedTextStyle.SUB_TITLE_SIZE,
                            fontWeight: SharedTextStyle.SUB_TITLE_WEIGHT,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        saveData();
                      },
                      child: Text('Save'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    if (widget.fieldName == "Name") {
      return Container(
        padding: EdgeInsets.only(left: 12, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controllerName,
              onChanged: _onChanged,
              maxLength: 30,
              decoration: InputDecoration(
                counterText: "",
                hintText: "Add your name",
                suffixIcon: IconButton(
                  onPressed: () {
                    _controllerName.text = "";
                  },
                  icon: Icon(CupertinoIcons.xmark_circle),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text('${charLengthName}/30'),
            SizedBox(height: 10),
            Text(
              'Your nickname can only be changed once every 7 days',
            )
          ],
        ),
      );
    } else if (widget.fieldName == "Username") {
      _controllerUserName.selection = TextSelection.fromPosition(
          TextPosition(offset: _controllerUserName.text.length));
      return Container(
        padding: EdgeInsets.only(left: 12, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controllerUserName,
              onChanged: _onChanged,
              decoration: InputDecoration(
                counterText: "",
                hintText: "Username",
                suffixIcon: bloc.isCheckUserName()
                    ? IconButton(
                        onPressed: () {},
                        icon: Icon(CupertinoIcons.xmark_circle),
                      )
                    : Icon(
                        CupertinoIcons.check_mark_circled_solid,
                        color: Colors.green,
                      ),
              ),
            ),
            SizedBox(height: 8),
            Text('www.reelt.com/${_controllerUserName.text}'),
            SizedBox(height: 10),
            Text(
              'Usernames can contain only letters, numbers, underscores, and periods. Changing your username will also change your profile',
            ),
            SizedBox(height: 10),
            Text('You can change your username once every 30 days'),
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(left: 12, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controllerBio,
              onChanged: _onChanged,
              maxLength: 80,
              decoration: InputDecoration(
                hintText: "Add a bio",
                counterText: "",
              ),
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 3,
            ),
            SizedBox(height: 8),
            Text('${charLengthBio}/80'),
          ],
        ),
      );
    }
  }

  void saveData() {
    if (widget.fieldName == "Name") {
      bloc.updateUserFullName(_controllerName.text);
    } else if (widget.fieldName == "Username") {
      bloc.updateUserName(_controllerUserName.text);
    } else {
      bloc.updateBio(_controllerBio.text);
    }
  }

  @override
  void onDispose() {}
}
