import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class TextStyles {
  static final titleHome = GoogleFonts.fredokaOne(
    fontSize: 48,
    fontWeight: FontWeight.normal,
    color: AppColors.titleWhite,
  );
  static final buttonGray = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );
  static final pinkTitle = GoogleFonts.sunflower(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );
  static final pinkTitleThin = GoogleFonts.sunflower(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.primary,
  );
}
