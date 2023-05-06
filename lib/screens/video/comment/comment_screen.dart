import 'dart:math';

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
import 'package:collection/collection.dart';

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

class CommentScreenState extends AbstractState<CommentScreen> {
  late CommentBloc bloc;
  late TextEditingController _textComment = TextEditingController();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  FocusNode focusNode = FocusNode();

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
    bool atEdge = false;
    itemPositionsListener.itemPositions.addListener(() {
      var positions = itemPositionsListener.itemPositions.value;
      if (atEdge == false && positions.last.index == bloc.comments.length - 1) {
        bloc.sendRetrieveCommentEvent(widget.video.id);
        atEdge = true;
        print("atEdge");
        return;
      }

      if (positions.last.index != bloc.comments.length - 1) atEdge = false;
    });
    print(widget.video.id);
  }

  @override
  void onReady() {}

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
      physics: ClampingScrollPhysics(),
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
      itemBuilder: (context, index) {
        var comment = bloc.comments[index];
        var isReplyThisComment = bloc.replyComment == comment;
        return CommentBlockScreen(
          comment: comment,
          users: bloc.userCommentMap,
          isFocus: isReplyThisComment,
          replyCallback: () {
            bloc.replyComment = comment;
            itemScrollController.scrollTo(
              index: index,
              duration: Duration(milliseconds: 300),
            );

            if (!focusNode.hasFocus) focusNode.requestFocus();
            notifyDataChanged();
          },
          controller: _textComment,
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 8);
      },
      itemCount: bloc.comments.length,
    );
  }

  Widget buildBottomNav() {
    var isTextFieldEmpty = _textComment.text.isEmpty;
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 240, 240, 240),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
      ),
      child: Row(
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
              focusNode: focusNode,
              controller: _textComment,
              onChanged: (value) {
                notifyDataChanged();
              },
              textInputAction: TextInputAction.send,
              onSubmitted: (value) {
                if (value.isEmpty) {
                  focusNode.unfocus();
                  return;
                }
                bloc.sendComment(value);
                _textComment.clear();
              },
              decoration: InputDecoration(
                hintText: "Add comment...",
                hintStyle: TextStyle(color: Colors.black54),
              ),
            ),
          ),
          SizedBox(width: 15),
          GestureDetector(
            onTap: () {
              var value = _textComment.text;
              if (value.isEmpty) {
                focusNode.unfocus();
                return;
              }
              bloc.sendComment(value);
              _textComment.clear();
            },
            child: Icon(
              isTextFieldEmpty && focusNode.hasFocus ? Icons.close : Icons.send,
              color: isTextFieldEmpty ? Colors.black : Colors.blue,
              size: 20,
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  @override
  void onDispose() {}

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
