import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../generated/abstract_bloc.dart';
import '../../generated/abstract_state.dart';
import '../../shared_product/assets/icon/tik_tok_icons_icons.dart';
import '../../shared_product/utils/text/shared_text_style.dart';
import '../../shared_product/widgets/button/three_row_button.dart';
import '../notification/notification_bloc.dart';
import '../../shared_product/widgets/default_appbar.dart';
import '../user/login/login_screen.dart';
import 'package:reel_t/models/notification/notification.dart' as reelN;

class NotificationScreen extends StatefulWidget {
  final List<reelN.Notification> listNotification;
  const NotificationScreen({super.key, this.listNotification = const []});

  @override
  State<NotificationScreen> createState() => NotificationScreenState();
}

class NotificationScreenState extends AbstractState<NotificationScreen> {
  late NotificationBloc bloc;
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
    bloc = NotificationBloc();
    bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => bloc,
      builder: (context, child) {
        return Consumer<NotificationBloc>(
          builder: (context, value, child) {
            print(widget.listNotification);
            var body = buildBody();
            return buildScreen(
              appBar: DefaultAppBar(appBarTitle: "Notification"),
              body: body,
              notLoggedBody: buildLoggedBody(),
            );
          },
        );
      },
    );
  }

  Widget buildLoggedBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          TikTokIcons.messages,
          size: 150,
          color: Colors.grey[300],
        ),
        SizedBox(height: 8),
        Text(
          "Notification will be shown here",
          style: TextStyle(
            fontSize: SharedTextStyle.SUB_TITLE_SIZE,
            fontWeight: SharedTextStyle.SUB_TITLE_WEIGHT,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 16),
        Container(
          width: screenWidth() * 0.6,
          child: ThreeRowButton(
            onTap: () {
              pushToScreen(LoginScreen());
            },
            title: Text(
              "Login",
              style: TextStyle(
                fontSize: SharedTextStyle.SUB_TITLE_SIZE,
                fontWeight: SharedTextStyle.SUB_TITLE_WEIGHT,
                color: Colors.white,
              ),
            ),
            color: Colors.red,
          ),
        )
      ],
    );
  }

  Widget buildBody() {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context, index) {
        return SizedBox(height: 8);
      },
      itemCount: 10,
      itemBuilder: ((context, index) {}),
    );
  }

  @override
  void onDispose() {}

  @override
  void onReady() {
    // TODO: implement onReady
  }
}
