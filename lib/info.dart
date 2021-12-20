// @dart=2.9
import 'package:flutter/material.dart';
import 'package:Presente/utilities/constants.dart';
import 'package:Presente/main.dart';
import 'dart:async';

class Info extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kSecondaryGrayColor),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('FAQ', style: kTitleTextStyle),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: ListView(
          children: [
            SizedBox(height: 20.0),
            Text("¿Qué es Presente?", style:kInfoTitle),
            SizedBox(height: 5.0),
            Text("Presente es una app minimalista para practicar ejercicios respiratorios y ejercitar la presencia.", style:kInfoText),
            SizedBox(height: 30.0),
            Text("¿Por qué creé Presente?", style:kInfoTitle),
            SizedBox(height: 5.0),
            Text("En momentos cotidianos donde me sentía sola o desorientada, necesitaba un lugar seguro donde volver. Presente nace de esa necesidad de encauzar las emociones, respirando y sosteniendo hasta volver al presente.", style:kInfoText),
            SizedBox(height: 30.0),
            Text("Feedback", style:kInfoTitle),
            SizedBox(height: 5.0),
            Text("Presente es un trabajo en progreso e irá mejorando en futuras versionas."
                "\n\nPodés escribirme a delfi@presente.app. Leeré todo el feedback.", style:kInfoText),
          ],
        ),
      ),
    );
  }
}

