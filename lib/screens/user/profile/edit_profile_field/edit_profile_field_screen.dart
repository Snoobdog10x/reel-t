import 'package:flutter/material.dart';
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
  final TextEditingController _controller = TextEditingController();

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
                        print(_controller.text.toString());
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
    var newText = bloc.currentUserProfile.fullName.toString();
    final updatedText = _controller.text + newText;
    _controller.value = _controller.value.copyWith(
      text: updatedText,
      selection: TextSelection.collapsed(offset: updatedText.length),
    );
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
          ),
          SizedBox(height: 8),
          Text(
            _controller.text.length.toString() + '/' + '30',
          ),
          SizedBox(height: 10),
          Text(
            'Your nickname can only be changed once every 7 days',
          ),
        ],
      ),
    );
  }

  @override
  void onDispose() {
    _controller.dispose();
    super.dispose();
  }
}
