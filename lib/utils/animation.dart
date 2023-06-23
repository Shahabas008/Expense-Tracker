import 'package:flutter/material.dart';
import 'package:money_management_app/UI/addBugdet/addbudget.dart';

class AnimationClass{
  //Animation for navigating the page to AddBudget Page.
  Route navigateToAddBudgetPage() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>  const AddBudget(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
}