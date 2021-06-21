class NetworkConstants {
  // User and Profile Routes
  static const String currentUserToken = "currentUserToken";
  static const String currentUser = "currentUser";
  static const String currentUserProfile = "currentUserProfile";
  static const String userProfileAPI = "/api/settings/profile/";
  static const String editFirstName = "/api/settings/profile/edit-first-name";
  static const String editLastName = "/api/settings/profile/edit-last-name";
  static const String editMobile = "/api/settings/profile/edit-mobile";
  static const String editPassword = "/api/settings/profile/edit-password";
  static const String editEmailAddress = "/api/settings/profile/edit-email";
  static const String uploadProfilePicture = "/api/settings/profile/edit-image";
  static const String uploadCoverPicture =
      "/api/settings/profile/edit-cover-image";

  // User Wallet Routes
  static const String walletTotal = "/api/my-wallet/total-data";
  static const String walletPointsToPrice = "/api/my-wallet/total-point-price";
  static const String walletTransformPointsToPrice =
      "/api/my-wallet/transformation-point-to-price";
  static const String walletTransformPromocode =
      "/api/my-wallet/transformation-promo-code";

  // Branche Profile Data Routes
  static const String ViewBranche = "/api/companies/company/view/branche/";
  static const String BrancheAddRemoveFavorite =
      "/api/companies/company/branche/add-or-remove-favorite/";
  static const String ViewBranchServices =
      "/api/companies/company/view/branche/services/";
  static const String ViewBranchEmployees =
      "/api/companies/company/view/branche/employees/";
  static const String ViewBranchReviews =
      "/api/companies/company/branche/review/";
  static const String ViewBranchOffers =
      "/api/companies/company/view/branche/offers/";
  static const String ViewBranchWorkingDays =
      "/api/companies/company/view/branche/work-days/";

  //Order Routes
  static const String orderDateTime = "/api/companies/order/date-time-order/";
}
