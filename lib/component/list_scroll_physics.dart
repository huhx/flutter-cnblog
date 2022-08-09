import 'package:flutter/material.dart';

class ListScrollPhysics extends AlwaysScrollableScrollPhysics {

  const ListScrollPhysics() : super(parent: const BouncingScrollPhysics());
}
