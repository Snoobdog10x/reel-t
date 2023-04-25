import 'package:cached_network_image/cached_network_image.dart';
import 'package:comment_tree/comment_tree.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/screens/video/comment/comment_block/comment_block_screen.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import '../../../models/comment/comment.dart' as ReelComment;
import '../../../models/video/video.dart';
import '../../../shared_product/utils/format/format_utlity.dart';
import '../../../shared_product/widgets/image/circle_image.dart';
import 'comment_bloc.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class CommentScreen extends StatefulWidget {
  final int commentsNum;
  final Video video;
  const CommentScreen({
    super.key,
    this.commentsNum = 0,
    required this.video,
  });

  @override
  State<CommentScreen> createState() => CommentScreenState();
}

class CommentScreenState extends AbstractState<CommentScreen>
    with AutomaticKeepAliveClientMixin {
  late CommentBloc bloc;
  ScrollController controller = ScrollController();

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
    bloc = CommentBloc();
    bloc.sendRetrieveCommentEvent(widget.video.id);
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        bloc.sendRetrieveCommentEvent(widget.video.id);
        print('check');
      }
    });
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
        return Consumer<CommentBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              appBar: DefaultAppBar(
                appBarTitle:
                    "${FormatUtility.formatNumber(widget.commentsNum)} comments",
                appBarAction: GestureDetector(
                  onTap: () {
                    popTopDisplay();
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.close),
                  ),
                ),
              ),
              body: body,
              isSafeTop: false,
              isPushLayoutWhenShowKeyboard: true,
              padding: EdgeInsets.symmetric(horizontal: 8),
              bottomNavBar: buildBottomNav(),
            );
          },
        );
      },
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        children: bloc.comments
            .map(
              (comment) => CommentBlockScreen(
                comment: comment,
                users: bloc.userCommentMap,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget buildBottomNav() {
    return Row(
      children: <Widget>[
        SizedBox(width: 10),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(25),
            ),
            child: CircleImage(
              appStore.localUser.getCurrentUser().avatar,
              radius: 40,
            ),
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Add comment...",
              hintStyle: TextStyle(color: Colors.black54),
            ),
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
          ),
        ),
        SizedBox(width: 15),
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.send,
            color: Colors.black,
            size: 20,
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  void onDispose() {}

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
