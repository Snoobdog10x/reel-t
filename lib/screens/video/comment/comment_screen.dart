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
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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
  late TextEditingController _textComment = TextEditingController();
  final ItemScrollController itemScrollController = ItemScrollController();
  ScrollController controller = ScrollController();

  _onChange(String value) {
    _textComment.text = value;
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
    bloc = CommentBloc();
    bloc.init();
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
    return ScrollablePositionedList.separated(
      itemScrollController: itemScrollController,
      itemBuilder: (context, index) {
        var comment = bloc.comments[index];
        return CommentBlockScreen(
          comment: comment,
          users: bloc.userCommentMap,
          replyCallback: () {
            bloc.replyComment = comment;
            itemScrollController.scrollTo(
              index: index,
              duration: Duration(milliseconds: 500),
            );
          },
          controller: _textComment,
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 8);
      },
      itemCount: bloc.comments.length,
    );
    // return SingleChildScrollView(
    //   controller: controller,
    //   child: Column(
    //     children: bloc.comments
    //         .map(
    //           (comment) => CommentBlockScreen(
    //             comment: comment,
    //             users: bloc.userCommentMap,
    //             replyCallback: () {
    //               controller.jumpTo();
    //             },
    //           ),
    //         )
    //         .toList(),
    //   ),
    // );
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
            controller: _textComment,
            onChanged: _onChange,
            textInputAction: TextInputAction.send,
            onSubmitted: (value) {
              bloc.sendComment(value);
              _textComment.clear();
            },
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
          onTap: () {
            bloc.sendComment(_textComment.text.toString());
            _textComment.clear();
          },
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
