import 'package:cached_network_image/cached_network_image.dart';
import 'package:comment_tree/comment_tree.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/abstract_provider.dart';
import '../../../generated/abstract_state.dart';
import '../../../models/comment/comment.dart' as ReelComment;
import '../../../shared_product/utils/format_utlity.dart';
import '../../../shared_product/widgets/image/circle_image.dart';
import 'comment_provider.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class CommentScreen extends StatefulWidget {
  final int commentsNum;
  const CommentScreen({
    super.key,
    this.commentsNum = 0,
  });

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends AbstractState<CommentScreen> {
  late CommentProvider provider;
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
    provider = CommentProvider();
    provider.init();
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
        return Consumer<CommentProvider>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              appBar: DefaultAppBar(
                appBarTitle: "${FormatUtility.formatNumber(widget.commentsNum)} comments",
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
      child: Column(
        children: buildCommentsTree(),
      ),
    );
  }

  List<Widget> buildCommentsTree() {
    List<Widget> commentTrees = provider.comments.map((comment) {
      bool hasSub = comment.subComments.isNotEmpty;
      return StatefulBuilder(builder: (context, setState) {
        return CommentTreeWidget<ReelComment.Comment, ReelComment.Comment>(
          comment,
          comment.subComments,
          treeThemeData: TreeThemeData(
            lineColor: hasSub ? Colors.grey[200]! : Colors.white,
            lineWidth: 2,
          ),
          avatarRoot: (context, data) => PreferredSize(
            preferredSize: Size.fromRadius(20),
            child: CircleImage(
              provider.mockAvatar,
              radius: 40,
            ),
          ),
          avatarChild: (context, data) => PreferredSize(
            preferredSize: Size.fromRadius(20),
            child: CircleImage(
              provider.mockAvatar,
              radius: 30,
            ),
          ),
          contentChild: (context, data) {
            return buildComment(data, data == comment.subComments.last);
          },
          contentRoot: (context, data) {
            return buildComment(data, comment.subComments.isEmpty);
          },
        );
      });
    }).toList();
    return commentTrees;
  }

  Widget buildComment(ReelComment.Comment comment, bool isLast) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: screenWidth() * 0.6,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
              color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'dangngocduc',
                style: Theme.of(context).textTheme.caption?.copyWith(
                    fontWeight: FontWeight.w600, color: Colors.black),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                '${comment.content}',
                style: Theme.of(context).textTheme.caption?.copyWith(
                    fontWeight: FontWeight.w300, color: Colors.black),
              ),
            ],
          ),
        ),
        DefaultTextStyle(
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: Colors.grey[700], fontWeight: FontWeight.bold),
          child: Padding(
            padding: EdgeInsets.only(top: 4),
            child: Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                Text('Like'),
                SizedBox(
                  width: 24,
                ),
                Text('Reply'),
              ],
            ),
          ),
        ),
        if (isLast) ...[
          Container(
            padding: EdgeInsets.only(top: 8, left: 8),
            child: Text("Load more"),
          )
        ]
      ],
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
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Write message...",
              hintStyle: TextStyle(color: Colors.black54),
              border: InputBorder.none,
            ),
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
          ),
        ),
        SizedBox(width: 15),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              Icons.send,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  void onDispose() {}
}
