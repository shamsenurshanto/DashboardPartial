class DatabaseConstants {

  static const String tableBasicInfo = 'basic_info';
  static const String columnAccessToken = 'access_token';
  static const String columnRefreshToken = 'refresh_token';
  static const String columnBusinessType = 'business_type';
  static const String columnBinNo = 'bin';
  static const String columnBinHolderName = 'name';
  static const String columnBinHolderAddress = 'address';
  static const String columnBinHolderPhone = 'phone';
  static const String columnBinHolderEmail = 'email';
  static const String columnLastLoginTime = 'last_login_time';

  static const String tableOutletInfo = 'outlet_info';
  static const String columnOutletId = 'id';
  static const String columnOutletStatus = 'status';
  static const String columnOutletNameEn = 'name_en';
  static const String columnOutletNameBn = 'name_bn';
  static const String columnOutletDistrict = 'district';
  static const String columnOutletThana = 'thana';
  static const String columnOutletCity = 'city';
  static const String columnOutletMarketArea = 'market_area';
  static const String columnOutletAddressLine1 = 'address_line_1';
  static const String columnOutletAddressLine2 = 'address_line_2';
  static const String columnOutletLatitude = 'latitude';
  static const String columnOutletLongitude = 'longitude';
  static const String columnOutletWeekend = 'weekend';
  static const String columnOutletPhone = 'phone';
  static const String columnOutletEmail = 'email';
  static const String columnOutletOpeningTime = 'opening_time';
  static const String columnOutletClosingTime = 'closing_time';

  static const String tableUserInfo = 'user_info';
  static const String columnUsername = 'username';
  static const String columnPassword = 'password';
  static const String columnUserRole = 'role';
  static const String columnIsLoggedIn = 'is_logged_in';

  static const String tableProduct = 'product';
  static const String columnProductId = 'id';
  static const String columnProductName = 'name';
  static const String columnProductPrice = 'price';
  static const String columnProductUnit = 'unit';
  static const String columnProductCategory = 'category';
  static const String columnProductImage = 'image';

  static const String tableProductCategory = 'product_category';
  static const String columnProductCategoryId = 'id';
  static const String columnProductCategoryName = 'name';
  static const String columnProductCategoryStatus = 'status';

  static const String tableAttribute = 'attribute';
  static const String columnAttributeId = 'id';
  static const String columnAttributeName = 'name';
  static const String columnAttributeValues = 'values';

  static const String tableCartMaster = 'cart';
  static const String columnCartMasterId = 'id';
  static const String columnCartMasterTotalPrice = 'total_price';

  static const String tableCartItem = 'cart_item';
  static const String columnCartId = 'cart_id';
  static const String columnCartProductId = 'product_id';
  static const String columnCartProductQuantity = 'quantity';
  static const String columnCartProductAttribute = 'attribute';

  static const String tableOrderMaster = 'cart';
  static const String columnOrderMasterId = 'id';
  static const String columnOrderMasterTotalPrice = 'total_price';
  static const String columnOrderMasterStatus = 'status';
  static const String columnOrderMasterPaidAmountCash = 'cash';
  static const String columnOrderMasterPaidAmountCard = 'card';
  static const String columnOrderMasterPaidAmountMfs = 'mfs';

  static const String tableOrderItem = 'cart_item';
  static const String columnOrderId = 'cart_id';
  static const String columnOrderProductId = 'product_id';
  static const String columnOrderProductQuantity = 'quantity';
  static const String columnOrderProductAttribute = 'attribute';
  static const String columnOrderProductDiscount = 'discount';
}