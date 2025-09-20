import 'package:flutter/material.dart';

import 'colors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool loading;

  const RoundButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          backgroundColor: AppColors.purpleColor,
          fixedSize: Size(MediaQuery.of(context).size.width * 0.5, MediaQuery.of(context).size.height * 0.005), //responsive size
        ),

        child: loading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(title, style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );
  }
}


//
// ///keep in mind this is stateless widget
// class RoundButton extends StatelessWidget {
//   String title;
//   final VoidCallback onPressed;
//   final bool loading;
//   RoundButton({super.key, required this.title, required this.onPressed, this.loading = false});
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       child: loading ? CircularProgressIndicator(color: Colors.white) : Text(title, style: TextStyle(color: Colors.white, fontSize: 20)),
//       style: ElevatedButton.styleFrom(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//         backgroundColor: AppColors.purpleColor,
//         fixedSize: Size(MediaQuery.of(context).size.width * 0.5, MediaQuery.of(context).size.height * 0.005), //responsive size
//       ),
//     );
//   }
// }
