
class ApplicationURLs {

  //Production Server

 static const BASE_URL = "http://51.222.110.138:83/api/";
 static const USER = 'User/';
 static const PARENT = 'Parent/';
 static const SERVICE_PROVIDER = 'ServiceProvider/';
 static const PAYMENT = "Payment/";
 static const COMMON = 'Common/';
 static const CHAT = 'Chat/';
 static const RATING = 'Rating/';
 static const BOOKING = 'Booking/';
 static const NOTIFICATIONS = 'Notification/';



 static const LOGIN_URL = BASE_URL + 'Login/UserLogin';
 static const FORGOT_PASSWORD_URL = BASE_URL + USER + 'RequestForgotPassword';
 static const CREATE_PARENT_URL = BASE_URL + PARENT + 'CreateParent';
 static const CREATE_SP_URL = BASE_URL + SERVICE_PROVIDER + 'CreateServiceProvider';
 static const SEED_DATA_URL = BASE_URL + COMMON + 'GetSeedData';
 static const GET_SERVICE_PROVIDER_TYPE = BASE_URL + SERVICE_PROVIDER + 'GetServiceProviderByType?serviceProviderType=';
 static const GET_SERVICE_PROVIDER_FILTER = BASE_URL + SERVICE_PROVIDER + 'GetServiceProviderByFilters';


 static const ADD_CREDIT_CARD_URL = BASE_URL + PAYMENT + 'SaveCreditCard';
 static const ADD_BANK_INFO_URL = BASE_URL + PAYMENT + 'SaveBankInfo';
 static const GET_CONVERSATIONS_URL = BASE_URL + CHAT + 'GetMessagesByUserId?userId=';
 static const GET_MESSAGES_URL = BASE_URL + CHAT + 'GetAllMessages?senderId=';
 static const SAVE_MESSAGES_URL = BASE_URL + CHAT + 'SaveMessage';
 static const REMOVE_CARD_INFO_URL = BASE_URL + PAYMENT + 'RemoveCreditCard?last4Digit=';
 static const ADD_BOOKING_URL = BASE_URL + BOOKING + 'AddBooking';

 static const GET_CARD_INFO_URL = BASE_URL + PAYMENT + 'GetCreditCardInfoByUserId?userId=';
 static const GET_BANK_INFO_URL = BASE_URL + PAYMENT + 'GetBankInfoByUserId?userId=';

 static const GET_ALL_RATINGS_URL = BASE_URL + RATING + 'GetRatingByRatedUserId?ratedUserId=';
 static const GET_USER_BY_ID = BASE_URL + USER + 'GetUser?userId=';
 static const GET_USER_BOOKINGS = BASE_URL + BOOKING + 'GetBookingByUserId?userId=';
 static const GET_USER_NOTIFICATION = BASE_URL + NOTIFICATIONS + 'GetAllNotificationsByUserId?userId=';
 static const CHANGE_BOOKING_STATUS = BASE_URL + BOOKING + 'ChangeBookingStatus?bookingID=';
 static const CHANGE_PASSWORD_URL = BASE_URL + USER + 'ChangePassword';
 static const GET_USER_URL = BASE_URL + USER + 'GetUser?userId=';


 static const ADD_RATING_URL = BASE_URL + RATING + 'AddRating';
 static const ADD_FAVOURITE_URL = BASE_URL + SERVICE_PROVIDER + 'AddFavourite?';
 static const REMOVE_FAVOURITE_URL = BASE_URL + SERVICE_PROVIDER + 'RemoveFavourite?';
 static const GET_FAVOURITE_URL = BASE_URL + SERVICE_PROVIDER + 'GetFavouriteServiceProvidersByParentId?parentId=';

 static const GET_PAYMENTS_URL = BASE_URL + PAYMENT + 'GetAllPaymentsByUserId?userId=';

 static const UPDATE_PARENT_URL = BASE_URL + PARENT + 'UpdateParent';

}
