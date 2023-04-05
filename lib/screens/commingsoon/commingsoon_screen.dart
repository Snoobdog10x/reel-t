import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../generated/abstract_bloc.dart';
import '../../generated/abstract_state.dart';
import 'commingsoon_bloc.dart';
import '../../shared_product/widgets/default_appbar.dart';
import 'package:google_fonts/google_fonts.dart';

class CommingsoonScreen extends StatefulWidget {
  const CommingsoonScreen({super.key});

  @override
  State<CommingsoonScreen> createState() => _CommingsoonScreenState();
}

class _CommingsoonScreenState extends AbstractState<CommingsoonScreen> {
  late CommingsoonBloc bloc;
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
    bloc = CommingsoonBloc();
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
        return Consumer<CommingsoonBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              appBar: DefaultAppBar(),
              body: body,
            );
          },
        );
      },
    );
  }

  Widget buildBody() {
    return Container(
      height: screenHeight(),
      width: screenWidth(),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Colors.yellow,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Comming soon...',
            style: GoogleFonts.pacifico(
                fontSize: 48, color: Color.fromARGB(255, 247, 247, 247)),
          ),
          SizedBox(height: screenHeight() * 0.4),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(60, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Color.fromARGB(255, 210, 210, 210),
              elevation: 0,
              side: BorderSide(color: Colors.transparent),
            ),
            onPressed: () {
              popTopDisplay();
            },
            child: Icon(
              CupertinoIcons.back,
              size: 40,
            ),
          )
        ],
      ),
    );
  }

  @override
  void onDispose() {}
}
