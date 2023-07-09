// ignore_for_file: prefer_interpolation_to_compose_strings, constant_identifier_names

library chessy.globals;

import 'dart:io';

import 'package:chessy/models/UserAccess.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'dart:convert';

const String API = "chessy-backend.onrender.com";

const String VERSION = "/api/v1";

//AUTHENTICATE API

const String LOGIN_API = VERSION + "/authenticate/login";

const String REGISTER_API = VERSION + "/authenticate/register";

const String IS_VERIFY_API = VERSION + "/authenticate/isVerify";

//MUST HAVE ACCESS TOKEN
const String REGENERATE_API = VERSION + "/authenticate/regenerate";

const String VERIFY_API = VERSION + "/authenticate/verify";

const String FORGET_API = VERSION + "/authenticate/forget";

//USER API

const String GET_USER_API = VERSION + "/user/";
const String PUT_USER_API = VERSION + "/user/";

//GAME API

const String CREATE_API = "/api/v1/game/create";
const String CONNECT_API = "/api/v1/game/connect";
const String CONNECT_RANDOM_API = "/api/v1/game/connect/random";
const String START_API = "/api/v1/game/start";
const String GAMEPLAY_API = "/api/v1/game/gameplay";
const String LEAVE_API = "/api/v1/game/leave";
const String FINISH_API = "/api/v1/game/finish";

const String GET_ROOM_API = "/api/v1/game/rooms";
const String GET_HISTORY_USER = "/api/v1/game/history/";

UserAccess currentUser =
    UserAccess(username: "NULL", accessToken: "NULL", refreshToken: "NULL");

String avatarURL = "https://i.imgur.com/wfH8Koa.png";
String userEmail = "";
