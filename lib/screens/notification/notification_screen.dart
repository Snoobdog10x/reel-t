import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../generated/abstract_bloc.dart';
import '../../generated/abstract_state.dart';
import '../../models/message/message.dart';
import '../../shared_product/assets/icon/tik_tok_icons_icons.dart';
import '../../shared_product/utils/format/format_utlity.dart';
import '../../shared_product/utils/text/shared_text_style.dart';
import '../../shared_product/widgets/button/three_row_button.dart';
import '../../shared_product/widgets/image/circle_image.dart';
import '../notification/notification_bloc.dart';
import '../../shared_product/widgets/default_appbar.dart';
import '../user/login/login_screen.dart';
import 'package:reel_t/models/notification/notification.dart' as reelN;

class NotificationScreen extends StatefulWidget {
  final void Function()? callBackNewNotification;
  const NotificationScreen({super.key, this.callBackNewNotification});

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
      itemCount: bloc.listNotification.length,
      itemBuilder: ((context, index) {
        return buildNotification(bloc.listNotification[index]);
      }),
    );
  }

  Widget buildNotification(reelN.Notification notification) {
    var message = bloc.parseNotificationToMessage(notification);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleImage(bloc.contactUser[message.userId]?.avatar ?? '',
              radius: 45),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 7,
                      child: Text(
                        bloc.contactUser[message.userId]?.fullName ?? '',
                        style: TextStyle(
                          fontSize: SharedTextStyle.SUB_TITLE_SIZE,
                          fontWeight: SharedTextStyle.SUB_TITLE_WEIGHT,
                          fontFamily: SharedTextStyle.DEFAULT_FONT_TITLE,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        " · " +
                            getNotificationTime(
                                bloc.parseNotificationToMessage(notification)),
                        style: TextStyle(
                          fontSize: SharedTextStyle.NORMAL_SIZE,
                          fontWeight: SharedTextStyle.NORMAL_WEIGHT,
                          fontFamily: SharedTextStyle.DEFAULT_FONT_TEXT,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  bloc.parseNotificationToMessage(notification).content,
                  style: TextStyle(
                    fontSize: SharedTextStyle.NORMAL_SIZE,
                    fontWeight: SharedTextStyle.NORMAL_WEIGHT,
                    fontFamily: SharedTextStyle.DEFAULT_FONT_TITLE,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getNotificationTime(Message? message) {
    if (message == null) return '';
    var currentDate = DateTime.now();
    var messageCreateAt = DateTime.fromMillisecondsSinceEpoch(message.createAt);
    List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    List<String> monthAbbreviations = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    if (DateUtils.isSameDay(currentDate, messageCreateAt)) {
      return DateFormat('hh:mm a').format(messageCreateAt);
    }
    if (!FormatUtility.isSameWeek(messageCreateAt, currentDate)) {
      return weekdays[messageCreateAt.weekday.toInt() - 1].toString();
    }
    if (FormatUtility.isSameWeek(messageCreateAt, currentDate)) {
      return "${monthAbbreviations[messageCreateAt.month.toInt() - 1].toString()} ${messageCreateAt.day}";
    }
    return '';
  }

  @override
  void onDispose() {}

  @override
  void onReady() {
    // TODO: implement onReady
  }
}
