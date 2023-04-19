import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/shared_product/utils/format/format_utlity.dart';
import '../../../../generated/abstract_bloc.dart';
import '../../../../generated/abstract_state.dart';
import '../../../../shared_product/services/cloud_storage.dart';
import '../../../../shared_product/widgets/image/image_gallery_picker/image_gallery_picker_screen.dart';
import '../edit_profile_field/edit_profile_field_screen.dart';
import 'edit_profile_bloc.dart';
import '../../../../shared_product/widgets/default_appbar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => EditProfileScreenState();
}

class EditProfileScreenState extends AbstractState<EditProfileScreen> {
  late EditProfileBloc bloc;
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
    bloc = EditProfileBloc();
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
        return Consumer<EditProfileBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              appBar: DefaultAppBar(
                appBarTitle: "Edit profile",
                onTapBackButton: () {
                  popTopDisplay();
                },
              ),
              body: body,
            );
          },
        );
      },
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        getPhoto(),
        SizedBox(height: 10),
        Text(
          'Change photo',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 18),
        buildAboutYou(),
        SizedBox(height: 18),
        buildSocial(),
      ],
    );
  }

  Widget buildChangePhoto() {
    if (bloc.avatar == null) {
      return Container(
        child: SizedBox(
          child: Stack(
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.matrix(<double>[
                  0.5,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0.5,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0.5,
                  0,
                  0,
                  0,
                  0,
                  0,
                  1,
                  0,
                ]),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                    image: bloc.currentUser.avatar.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(bloc.currentUser.avatar),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 100,
                child: Icon(
                  CupertinoIcons.camera,
                  color: Colors.white,
                  size: 30,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
        image: DecorationImage(
          image: MemoryImage(bloc.avatar!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget getPhoto() {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (appStore.isWeb()) {
              bloc.pickImage();
              return;
            }
            showMobileImagePicker();
          },
          child: Container(
            alignment: Alignment.center,
            child: buildChangePhoto(),
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  void showMobileImagePicker() {
    showScreenBottomSheet(
      Container(
        height: screenHeight() * 0.7,
        child: ImageGalleryPickerScreen(
          isPickMultiple: false,
          onFileSelected: (files) async {
            try {
              bloc.avatar = await files.first?.readAsBytes();
              var downloadUrl = await appStore.cloudStorage.uploadFile(
                  File_Type.IMAGE,
                  files.first!,
                  bloc.currentUser.id +
                      FormatUtility.getMillisecondsSinceEpoch().toString());
              print(downloadUrl);
              bloc.updateAvatar(downloadUrl);
              notifyDataChanged();
            } catch (e) {
              print(e);
            }
          },
        ),
      ),
    );
  }

  Widget buildAboutYou() {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12),
      height: screenHeight() * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              'About you',
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 130, 130, 130),
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Color.fromARGB(255, 248, 249, 249),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: buildOptionItem(
                        'Name',
                        () {
                          pushToScreen(
                            EditProfileFieldScreen(
                              fieldName: 'Name',
                            ),
                          );
                        },
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                        bloc.currentUser.fullName,
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        'Username',
                        () {
                          pushToScreen(
                            EditProfileFieldScreen(
                              fieldName: 'Username',
                            ),
                          );
                        },
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                        bloc.currentUser.userName,
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        '',
                        () {},
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                        'reelt.com/' + bloc.currentUser.userName,
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        'Bio',
                        () {
                          pushToScreen(
                            EditProfileFieldScreen(
                              fieldName: 'Bio',
                            ),
                          );
                        },
                        false,
                        Color.fromARGB(255, 160, 160, 160),
                        'Add a bio',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSocial() {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12),
      height: screenHeight() * 0.225,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              'Social',
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 130, 130, 130),
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Color.fromARGB(255, 248, 249, 249),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: buildOptionItem(
                        'Instagram',
                        () {},
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                        'Add Instagram',
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        'Youtube',
                        () {},
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                        'Add Youtube',
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        'Twitter',
                        () {},
                        false,
                        Color.fromARGB(255, 160, 160, 160),
                        'Add Twitter',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOptionItem(String optionTitle, Function onTapAction,
      bool isDivide, Color colors, String value) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: Colors.transparent,
        ),
      ),
      child: Container(
        width: screenWidth(),
        height: screenHeight(),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: isDivide
                    ? BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 0.05,
                          ),
                        ),
                      )
                    : null,
                child: Text(
                  optionTitle,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                alignment: Alignment.centerRight,
                height: screenHeight(),
                child: Text(
                  value,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Icon(
              CupertinoIcons.forward,
              size: 20,
              color: Color.fromARGB(255, 160, 160, 160),
            ),
          ],
        ),
      ),
      onPressed: () {
        onTapAction();
      },
    );
  }

  @override
  void onDispose() {}
}
