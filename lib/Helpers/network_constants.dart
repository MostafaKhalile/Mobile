class NetworkConstants {
  // #############app Contstants################
  static const String appName = "Tech Time";
  static const String baseUrl =
      "https://www.test.techtime.app"; //"https://www.techtime.app";
  static const String placeHolder = "https://via.placeholder.com/150";

// #############Routes##################
  static const String login = "/api/login";
  static const String homeAllCategories = "/api/home/all-category";
  static const String homeRecommendedCo = "/api/home/favorite-companies";
  static const String homeLeastCo = "/api/home/Lest-companies";
  static const String homeAdsAbove = "/api/home/ads-above-home";
  static const String homeCompaniesList =
      "/api/home/filter-category-companies/";
  static const String companyView = "/api/companies/company/view/";
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

  // Notifications Routes
  static const String allUserNotification =
      "/api/companies/notification/all-user-notification";
  static const String readUserNotification =
      "/api/companies/notification/read-user-notification/";
  static const String deleteUserNotification =
      "/api/companies/notification/clear-user-notification/";
  static const String readAllUserNotifications =
      "/api/companies/notification/read-all-user-notification";
  static const String clearAllUserNotifications =
      "/api/companies/notification/clear-all-user-notification";

  // User Wallet Routes
  static const String walletTotal = "/api/my-wallet/total-data";
  static const String walletPointsToPrice = "/api/my-wallet/total-point-price";
  static const String walletTransformPointsToPrice =
      "/api/my-wallet/transformation-point-to-price";
  static const String walletTransformPromocode =
      "/api/my-wallet/transformation-promo-code";

  // Branche Profile Data Routes
  static const String viewBranche = "/api/companies/company/view/branche/";
  static const String brancheAddRemoveFavorite =
      "/api/companies/company/branche/add-or-remove-favorite/";
  static const String viewBranchServices =
      "/api/companies/company/view/branche/services/";
  static const String viewBranchemployees =
      "/api/companies/company/view/branche/employees/";
  static const String viewBranchReviews =
      "/api/companies/company/branche/review/";
  static const String viewBranchOffers =
      "/api/companies/company/view/branche/offers/";
  static const String viewBranchWorkingDays =
      "/api/companies/company/view/branche/work-days/";

  //Order Routes
  static const String orderDateTime = "/api/companies/order/date-time-order/";

  //Reservations Routes
  static const String previousReservations =
      "/api/companies/order/notification/history/";
  static const String upcomingReservations =
      "/api/companies/order/notification/upcoming/";
}
