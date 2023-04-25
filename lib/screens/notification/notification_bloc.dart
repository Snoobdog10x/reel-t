import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

import '../../events/notification/retrieve_notification_nums/retrieve_notification_nums_event.dart';
import '../../generated/abstract_bloc.dart';
import 'notification_screen.dart';

class NotificationBloc extends AbstractBloc<NotificationScreenState> {}
