import 'package:cached_network_image/cached_network_image.dart';
import 'package:comment_tree/comment_tree.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

class CommentScreenState extends AbstractState<CommentScreen> {
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
        children: buildCommentsTree(),
      ),
    );
  }

  List<Widget> buildCommentsTree() {
    List<Widget> commentTrees = bloc.comments.map((comment) {
      bool hasSub = comment.subComments.isNotEmpty;
      return StatefulBuilder(builder: (context, setState) {
        return CommentTreeWidget<ReelComment.Comment, ReelComment.Comment>(
          comment,
          comment.subComments,
          treeThemeData: TreeThemeData(
            lineColor: hasSub ? Colors.grey[200]! : Colors.white,
            lineWidth: 2,
          ),
          avatarRoot: (context, comment) => PreferredSize(
            preferredSize: Size.fromRadius(20),
            child: CircleImage(
              bloc.getUserProfile(comment).avatar,
              radius: 40,
            ),
          ),
          avatarChild: (context, comment) => PreferredSize(
            preferredSize: Size.fromRadius(20),
            child: CircleImage(
              bloc.getUserProfile(comment).avatar,
              radius: 30,
            ),
          ),
          contentChild: (context, data) {
            return buildComment(data);
          },
          contentRoot: (context, data) {
            return buildComment(data);
          },
        );
      });
    }).toList();
    return commentTrees;
  }

  Widget buildComment(ReelComment.Comment comment) {
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
                bloc.getUserProfile(comment).fullName,
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
                  width: 14,
                ),
                Text('Reply'),
                SizedBox(
                  width: 80,
                ),
                GestureDetector(
                  onTap: () {
                    
                  },
                  child: Icon(CupertinoIcons.heart, size: 18),
                ),
                SizedBox(width: 2),
                Text('${comment.numLikes}')
              ],
            ),
          ),
        ),
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
}
