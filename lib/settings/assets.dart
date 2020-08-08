import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';

void showAlert(BuildContext context, String title, String message,
    bool isFromTop, bool statut) {
  EdgeAlert.show(context,
      backgroundColor: statut ? Colors.green : Colors.red,
      icon: statut ? Icons.error : Icons.check_circle,
      title: title,
      description: message,
      gravity: isFromTop ? EdgeAlert.TOP : EdgeAlert.BOTTOM);
}
