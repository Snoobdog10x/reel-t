import 'package:comment_tree/comment_tree.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import '../../../../generated/abstract_bloc.dart';
import '../../../../generated/abstract_state.dart';
import '../../../../shared_product/widgets/image/circle_image.dart';
import 'comment_block_bloc.dart';
import '../../../../shared_product/widgets/default_appbar.dart';
import '../../../../models/comment/comment.dart' as ReelComment;

class CommentBlockScreen extends StatefulWidget {
  final ReelComment.Comment comment;
  final Map<String, UserProfile> users;
  const CommentBlockScreen(
      {super.key, required this.comment, required this.users});

  @override
  State<CommentBlockScreen> createState() => CommentBlockScreenState();
}

class CommentBlockScreenState extends AbstractState<CommentBlockScreen> {
  late CommentBlockBloc bloc;
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
    bloc = CommentBlockBloc();
    bloc.init(widget.users);
    bloc.sendStreamSubCommentEvent(widget.comment);
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
        return Consumer<CommentBlockBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              isWrapBody: true,
              isSafe: false,
              body: body,
            );
          },
        );
      },
    );
  }

  Widget buildCommentBlock() {
    var comment = widget.comment;
    var hasSub = comment.subComments.isNotEmpty;
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
                  onTap: () {},
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

  Widget buildBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildCommentBlock(),
      ],
    );
  }

  @override
  void onDispose() {}
}
