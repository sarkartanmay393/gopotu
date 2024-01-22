const bool isStaging = true;

//Live URL

// const baseUrl = "inhouse.gopotu.com"; --> changes
// const baseUrl = "dev.gopotu.com";
const baseUrl = "api.gopotu.com";
// const baseUrl = "prod.gopotu.com";
// const baseUrl = "uat.gopotu.com";
// const baseUrl = "admin.gopotu.com";
//const registerUrl = "/api/auth/register";
// const registerUrl = "/api/auth/signup";
const registerUrl = "/api/auth/voktoesache";
// const registerOTPVerifyUrl = "/api/otp/user-register/verify";
// const resendOTPVerifyUrl = "/api/otp/user-register/resend";
// const registerOTPVerifyUrl = "/api/otp/user-signup/verify";
// const resendOTPVerifyUrl = "/api/otp/user-signup/resend";
const registerOTPVerifyUrl = "/api/otp/voktoesache/verify";
const resendOTPVerifyUrl = "/api/otp/voktoesache/resend";
const loginUrl = "/api/auth/login";
const sendOtp = "/api/auth/send-otp";
const nameUpdateUrl = "/api/name-update";
const otpLogin = "/api/auth/otp-login";
const loginOTPVerifyUrl = "/api/otp/user-login/verify";
const loginResendOTPVerifyUrl = "/api/otp/user-login/resend";
const guestLoginUrl = "/api/guest/login";
const fetchAddressListUrl = "/api/user/address/fetch";
const setDefaultAddress = "/api/user/address/set-default";
const deleteAddress = "/api/user/address/delete";
const getAccount = "/api/auth/account";
const editAccount = "/api/user/update/basic-details";
const changePassword = "/api/user/update/password";
const getHomeData = "/api/homepage/load";
const getOrderTrack = "/api/tracking-order";
const getCategory = "/api/all-shops/23";
const getStoreDetails = "/api/shoppage/load";
const getShopByCategory = "/api/all-shops";
const subcategorycall = "/api/get-subcategories";
const subCategoryListUrl = "/api/categories/fetch";
const getProductDetails = "/api/product/details";
const getProductVariantDetails = "/api/product/variant-details";
const addToCart = "/api/cart/add";
const fetchCartCount = "/api/cart/count";
const fetchCartList = "/api/cart/list";
const makeFinalOrderUrl = "/api/order/create";
const orderListUrl = "/api/order/fetch";
const orderDetailsUrl = "/api/order/details";
const addOrdersUrl = "/api/user/address/add";
const productListBySubCategoryUrl = "/api/products/browse";
const cmsUrl = "/api/cms/contents";
const companyDetailUrl = "/api/company/details";
const getSocialLinksUrl = "/api/cms/sociallinks";
const resetPasswordUrl = "/api/auth/password/reset";
const getNotificationListUrl = "/api/user/notifications";
const applyCouponUrl = "/api/cart/coupon-add";
const initiatePaymentUrl = "/api/order/cash-order/initiate-payment";
const cancelOrderUrl = "/api/order/cancel-submit";
const cartCallBackUrl = "/api/order/payment-callback";
const orderRatingUrl = "/api/order/review-submit";
const setAsFavouriteUrl = "/api/wishlist/submit";
const favouriteListUrl = "/api/wishlist/list";
const searchListUrl = "/api/search/submit";
const supportUrl = "/api/support-ticket/submit";
const walletDashBoardUrl = "/api/wallet/dashboard/userwallet";
const walletTransactionHistoryUrl = "/api/wallet/statement/userwallet";
const fetchStateListUrl = "/api/states/fetch";
const fetchCancelReasonListUrl = "/api/user/cancellation-reasons/fetch";
const reurnDetailsUrl = "/api/order/return-replacement/details";
const getOrderTimeDetailsUrl = "/api/order/details/timer";
const resendOTPVerifyForResetUrl = "/api/otp/user-password-reset/resend";
const verifyOTPVerifyForResetUrl = "/api/otp/user-password-reset/verify";
const getAccountSettingUrl = "/api/app/user/settings";

//Development URL

// const baseUrl = "projectdemoclient.xyz";
// const registerUrl = "/gopotu-dev/public/api/auth/register";
// const registerOTPVerifyUrl = "/gopotu-dev/public/api/otp/user-register/verify";
// const resendOTPVerifyUrl = "/gopotu-dev/public/api/otp/user-register/resend";
// const registerOTPVerifyUrl = "/gopotu-dev/public/api/otp/user-signup/verify";
// const resendOTPVerifyUrl = "/gopotu-dev/public/api/otp/user-signup/resend";
// const loginUrl = "/gopotu-dev/public/api/auth/login";
// const loginOTPVerifyUrl = "/gopotu-dev/public/api/otp/user-login/verify";
// const loginResendOTPVerifyUrl = "/gopotu-dev/public/api/otp/user-login/resend";
// const guestLoginUrl = "/gopotu-dev/public/api/guest/login";
// const fetchAddressListUrl = "/gopotu-dev/public/api/user/address/fetch";
// const setDefaultAddress = "/gopotu-dev/public/api/user/address/set-default";
// const deleteAddress = "/gopotu-dev/public/api/user/address/delete";
// const getAccount = "/gopotu-dev/public/api/auth/account";
// const editAccount = "/gopotu-dev/public/api/user/update/basic-details";
// const changePassword = "/gopotu-dev/public/api/user/update/password";
// const getHomeData = "/gopotu-dev/public/api/homepage/load";
// const getStoreDetails = "/gopotu-dev/public/api/shoppage/load";
// const subCategoryListUrl = "/gopotu-dev/public/api/categories/fetch";
// const getProductDetails = "/gopotu-dev/public/api/product/details";
// const getProductVariantDetails =
//     "/gopotu-dev/public/api/product/variant-details";
// const addToCart = "/gopotu-dev/public/api/cart/add";
// const fetchCartCount = "/gopotu-dev/public/api/cart/count";
// const fetchCartList = "/gopotu-dev/public/api/cart/list";
// const makeFinalOrderUrl = "/gopotu-dev/public/api/order/create";
// const orderListUrl = "/gopotu-dev/public/api/order/fetch";
// const orderDetailsUrl = "/gopotu-dev/public/api/order/details";
// const addOrdersUrl = "/gopotu-dev/public/api/user/address/add";
// const productListBySubCategoryUrl = "/gopotu-dev/public/api/products/browse";
// const cmsUrl = "/gopotu-dev/public/api/cms/contents";
// const companyDetailUrl = "/gopotu-dev/public/api/company/details";
// const getSocialLinksUrl = "/gopotu-dev/public/api/cms/sociallinks";
// const resetPasswordUrl = "/gopotu-dev/public/api/auth/password/reset";
// const getNotificationListUrl = "/gopotu-dev/public/api/user/notifications";
// const applyCouponUrl = "/gopotu-dev/public/api/cart/coupon-add";
// const initiatePaymentUrl =
//     "/gopotu-dev/public/api/order/cash-order/initiate-payment";
// const cancelOrderUrl = "/gopotu-dev/public/api/order/cancel-submit";
// const cartCallBackUrl = "/gopotu-dev/public/api/order/payment-callback";
// const orderRatingUrl = "/gopotu-dev/public/api/order/review-submit";
// const setAsFavouriteUrl = "/gopotu-dev/public/api/wishlist/submit";
// const favouriteListUrl = "/gopotu-dev/public/api/wishlist/list";
// const searchListUrl = "/gopotu-dev/public/api/search/submit";
// const supportUrl = "/gopotu-dev/public/api/support-ticket/submit";
// const walletDashBoardUrl = "/gopotu-dev/public/api/wallet/dashboard/userwallet";
// const walletTransactionHistoryUrl =
//     "/gopotu-dev/public/api/wallet/statement/userwallet";
// const fetchStateListUrl = "/gopotu-dev/public/api/states/fetch";
// const fetchCancelReasonListUrl =
//     "/gopotu-dev/public/api/user/cancellation-reasons/fetch";
// const reurnDetailsUrl =
//     "/gopotu-dev/public/api/order/return-replacement/details";
// const getOrderTimeDetailsUrl = "/gopotu-dev/public/api/order/details/timer";

// const resendOTPVerifyForResetUrl =
//     "/gopotu-dev/public/api/otp/user-password-reset/resend";
// const verifyOTPVerifyForResetUrl =
//     "/gopotu-dev/public/api/otp/user-password-reset/verify";
// const getAccountSettingUrl = "/gopotu-dev/public/api/app/branch/settings";
