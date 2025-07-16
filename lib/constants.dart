import 'package:flutter/material.dart';

export 'dart:async';
export 'dart:convert';

export 'package:auto_size_text/auto_size_text.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:carousel_slider/carousel_slider.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
export 'package:firebase_auth/firebase_auth.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:firebase_storage/firebase_storage.dart';
export 'package:flutter/cupertino.dart' hide RefreshCallback;
export 'package:flutter/foundation.dart' show kIsWeb;
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
export 'package:flutter_spinkit/flutter_spinkit.dart';
export 'package:flutter_swiper_3/flutter_swiper_3.dart';
export 'package:furnday/controllers/cart_controller.dart';
export 'package:furnday/controllers/products_controller.dart';
export 'package:furnday/firebase_options.dart';
export 'package:furnday/helpers/grid_determiners.dart';
export 'package:furnday/models/api/create_order_model.dart';
export 'package:furnday/models/order/track_order_model.dart';
export 'package:furnday/models/product/cart_model.dart';
export 'package:furnday/models/product/product_model.dart';
export 'package:furnday/models/user/user_address_model.dart';
export 'package:furnday/screens/auth_screens/reset_password_screen.dart';
export 'package:furnday/screens/auth_screens/signin_screen.dart';
export 'package:furnday/screens/auth_screens/signup_screen.dart';
export 'package:furnday/screens/main_screens/all_products_screen.dart';
export 'package:furnday/screens/main_screens/categories_screen.dart';
export 'package:furnday/screens/main_screens/furniture_screen.dart';
export 'package:furnday/screens/main_screens/hardware_screen.dart';
export 'package:furnday/screens/main_screens/hire_a_carpenter_screen.dart';
export 'package:furnday/screens/main_screens/home_screen.dart';
export 'package:furnday/screens/main_screens/main_screen.dart';
export 'package:furnday/screens/main_screens/my_cart_screen.dart';
export 'package:furnday/screens/main_screens/refurbished_screen.dart';
export 'package:furnday/screens/product/product_3d_view_screen.dart';
export 'package:furnday/screens/product/product_screen.dart';
export 'package:furnday/screens/user_profile_screens/address/my_addresses_screen.dart';
export 'package:furnday/screens/user_profile_screens/my_orders/my_orders_screen.dart';
export 'package:furnday/services/cashfree_services.dart';
export 'package:furnday/services/product_services.dart';
export 'package:furnday/controllers/user_address_controller.dart';
export 'package:furnday/size_config.dart';
export 'package:furnday/widgets/auth/auth_form.dart';
export 'package:furnday/widgets/auth/auth_text_field.dart';
export 'package:furnday/widgets/auto_swipe_ads.dart';
export 'package:furnday/widgets/cart/cart_item_count_btn.dart';
export 'package:furnday/widgets/cart/my_cart_card.dart';
export 'package:furnday/widgets/decorated_card.dart';
export 'package:furnday/widgets/heading_section_text.dart';
export 'package:furnday/widgets/loading_overlay.dart';
export 'package:furnday/widgets/my_appbar.dart';
export 'package:furnday/widgets/product/product_card.dart';
export 'package:furnday/widgets/product/product_grid.dart';
export 'package:furnday/widgets/product/product_grid_type.dart';
export 'package:furnday/widgets/product/product_img.dart';
export 'package:furnday/widgets/product/product_photo_viewer.dart';
export 'package:furnday/widgets/product/product_price.dart';
export 'package:furnday/widgets/product/product_quantity.dart';
export 'package:furnday/widgets/product/product_review_section.dart';
export 'package:furnday/widgets/product/product_section.dart';
export 'package:furnday/widgets/star_ratings.dart';
export 'package:furnday/widgets/user_profile/address_card.dart';
export 'package:furnday/widgets/user_profile/user_profile_img.dart';
export 'package:get/get.dart';
export 'package:google_sign_in/google_sign_in.dart';
export 'package:im_stepper/stepper.dart';
export 'package:imageview360/imageview360.dart';
export 'package:intl/intl.dart' hide TextDirection;
export 'package:mailer/mailer.dart';
export 'package:photo_view/photo_view.dart';
export 'package:provider/provider.dart';
export 'package:furnday/controllers/shiprocket_services_controller.dart';

final kGreyDiscountedPriceColor = Colors.grey.shade600;
const kGreyMRPColor = Color(0xffc8c8c8);
const kGreyTextColor = Color.fromARGB(255, 158, 157, 152);
const kWhiteBackground = Color.fromARGB(255, 248, 247, 243);
const kYellowColor = Color(0xffF6C33C);
const kLightYellowColor = Color(0xfff5e8c4);
const kOrangeColor = Color(0xffF39F86);
final kBorderRadiusCard = BorderRadius.circular(10);
const kRadius = Radius.circular(8);
const kScrollPhysics = BouncingScrollPhysics();
const kHighlightColor = Color(0xffF7CC59);
const kProductMRPTextStyle = TextStyle(
  fontWeight: FontWeight.w700,
  decoration: TextDecoration.lineThrough,
  color: kGreyMRPColor,
);
const kProductDiscountPriceTextStyle = TextStyle(
  fontWeight: FontWeight.w700,
  color: kGreyTextColor,
);
