import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import '../../../shared_product/utils/text/shared_text_style.dart';
import '../../../shared_product/widgets/image/circle_image.dart';
import '../../../shared_product/widgets/video_player_item.dart';
import 'create_post_bloc.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class CreatePostScreen extends StatefulWidget {
  final String filePath;
  final Widget recoredVideo;
  const CreatePostScreen({
    super.key,
    required this.filePath,
    required this.recoredVideo,
  });

  @override
  State<CreatePostScreen> createState() => CreatePostScreenState();
}

class CreatePostScreenState extends AbstractState<CreatePostScreen> {
  late CreatePostBloc bloc;
  late TextEditingController _controllerBio = TextEditingController();

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
    bloc = CreatePostBloc();
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
        return Consumer<CreatePostBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              isPushLayoutWhenShowKeyboard: true,
              appBar: DefaultAppBar(
                onTapBackButton: () {
                  popTopDisplay();
                },
                appBarTitle: "Post",
              ),
              body: body,
              bottomNavBar: buildConfirmVideo(),
            );
          },
        );
      },
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        height: screenHeight(),
        width: screenWidth(),
        child: widget.recoredVideo,
      ),
    );
  }

  Widget buildConfirmVideo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      width: screenWidth(),
      child: Column(
        children: [
          buildDescription(),
          SizedBox(height: 16),
          buildConfirmButton(
            Colors.white,
            "Your Feed",
            Colors.black,
            bloc.currentUser.avatar,
            () {
              bloc.createFeedPost(widget.filePath);
            },
          ),
        ],
      ),
    );
  }

  Widget buildDescription() {
    return TextField(
      controller: _controllerBio,
      onChanged: (value) {
        bloc.title = value;
      },
      decoration: InputDecoration(
        hintText:
            "Describe your post, add hashtags, or mention creators that inspired you",
        counterText: "",
      ),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.multiline,
      minLines: 6,
      maxLines: 6,
    );
  }

  Widget buildConfirmButton(Color color, String text, Color textColor,
      String? avatar, Function()? onTap) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        height: 50,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (avatar != null) ...[
              CircleImage(
                avatar,
                background: Colors.grey.shade300,
                radius: 30,
              ),
              SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: SharedTextStyle.NORMAL_SIZE,
                fontWeight: SharedTextStyle.SUB_TITLE_WEIGHT,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void onPopWidget(String previousScreen) {
    // TODO: implement onPopWidget
    super.onPopWidget(previousScreen);
    popTopDisplay();
  }

  @override
  void onDispose() {}
}
