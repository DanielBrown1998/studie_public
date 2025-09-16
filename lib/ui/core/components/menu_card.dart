import 'package:app/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MenuCard extends StatefulWidget {
  final String description;
  final IconData? icon;
  final String? lottieURL;
  final int duration;
  final Function function;
  const MenuCard({
    super.key,
    required this.description,
    this.icon,
    this.lottieURL,
    required this.duration,
    required this.function,
  });

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> with TickerProviderStateMixin {
  late double tweenSize;
  late AnimationController? controllerAnimationLottie;

  @override
  void initState() {
    if (widget.lottieURL == null && widget.icon == null) {
      throw Exception("lottiURL e icon nao foram implementados");
    }
    super.initState();
    if (widget.lottieURL != null) {
      controllerAnimationLottie = AnimationController(vsync: this);
      controllerAnimationLottie!.duration = Duration(seconds: 1);
      controllerAnimationLottie!.reverseDuration = Duration(seconds: 1);
    } else {
      controllerAnimationLottie = null;
    }
    tweenSize = 10;
  }

  @override
  void dispose() {
    super.dispose();
    if (controllerAnimationLottie != null) controllerAnimationLottie!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    tweenSize = (widget.lottieURL == null) ? 50 : 65;
    return TweenAnimationBuilder<double>(
      duration: Duration(seconds: widget.duration + 1),
      curve: Curves.easeInCubic,
      tween: Tween<double>(begin: 0.0, end: tweenSize),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            widget.description,
            style: theme.textTheme.bodyLarge,
            softWrap: true,
          ),
        ),
      ),
      builder: (context, size, child) {
        return Card(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              width: 2,
              color: StudieTheme.secondaryColor,
              style: BorderStyle.solid,
            ),
          ),
          // color: StudieTheme.whiteSmoke,
          clipBehavior: Clip.hardEdge,
          shadowColor: theme.primaryColor,
          elevation: 10,
          child: InkWell(
            splashColor: StudieTheme.secondaryColor,
            onTap: () async {
              if (widget.lottieURL != null) {
                await controllerAnimationLottie!.forward();
                if (controllerAnimationLottie!.isForwardOrCompleted) {
                  await widget.function();
                }
                controllerAnimationLottie!.reset();
              } else {
                widget.function();
              }
            },
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                gradient: LinearGradient(
                  begin: AlignmentGeometry.topLeft,
                  end: AlignmentGeometry.bottomRight,
                  colors: [
                    StudieTheme.whiteSmoke,
                    StudieTheme.terciaryColor,
                    StudieTheme.secondaryColor,
                    StudieTheme.primaryColor,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  (widget.lottieURL != null)
                      ? Lottie.asset(
                        widget.lottieURL!,
                        animate: true,
                        controller: controllerAnimationLottie,
                        filterQuality: FilterQuality.medium,
                        repeat: true,
                        fit: BoxFit.fill,
                        width: size,
                        height: size,
                      )
                      : Icon(widget.icon, size: size),
                  child!,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
