import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import 'mqtt_controller.dart';
import 'mqtt_server.dart';

late MQTTManager manager;
late MQTTAppState currentAppState = MQTTAppState();

// Utility functions
String prepareStateMessageFrom(MQTTAppConnectionState state) {
  switch (state) {
    case MQTTAppConnectionState.connected:
      return 'Connected';
    case MQTTAppConnectionState.connecting:
      return 'Connecting';
    case MQTTAppConnectionState.disconnected:
      return 'Disconnected';
  }
}

configureAndConnect(topic) {
  var aqui = currentAppState;
  String osPrefix = 'Aplicativo';
  if (Platform.isAndroid) {
    osPrefix = 'Flutter_Android';
  }
  manager = MQTTManager(
      host: 'e55ab74b.us-east-1.emqx.cloud',
      topic: topic,
      identifier: osPrefix,
      state: aqui);
  manager.initializeMQTTClient();
  manager.connect();
}

disconnect() {
  manager.disconnect();
}

publishMessage(String text) {
  String osPrefix = 'Aplicativo';
  if (Platform.isAndroid) {
    osPrefix = 'Aplicativo';
  }
  final String message = text;
  manager.publish(message);
}
