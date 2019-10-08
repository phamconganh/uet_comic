import 'package:flutter/material.dart';
import 'package:uet_comic/app.dart';
import 'package:uet_comic/provider_setup.dart' as ProviderSetup;
import 'package:uet_comic/src/core/models/config.dart';
import 'package:uet_comic/src/core/env/dev.dart';

void main() => runApp(UetComicApp(providers: ProviderSetup.getProviders(Config.fromJson(config))));
