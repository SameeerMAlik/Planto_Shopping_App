// App Strings - Centralized text management
class AppStrings {
  AppStrings._();

  // App Info
  static const String appName = 'Planto';
  static const String appTagline = 'Fresh Fruits & Vegetables';
  static const String appDescription = 'Your one-stop shop for fresh produce';

  // Authentication
  static const String welcomeBack = 'Welcome Back!';
  static const String signInToContinue = 'Sign in to continue to Planto';
  static const String joinPlanto = 'Join Planto!';
  static const String createAccountSubtitle = 'Create your account to get started';
  static const String dontHaveAccount = "Don't have an account? ";
  static const String alreadyHaveAccount = 'Already have an account? ';
  static const String signUp = 'Sign Up';
  static const String login = 'Login';
  static const String createAccount = 'Create Account';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String selectRole = 'Select Your Role:';

  // Roles
  static const String customerRole = 'Customer - I want to buy products';
  static const String adminRole = 'Admin - I want to sell products';
  static const String adminPanel = 'Admin Panel';
  static const String customerPanel = 'Customer Panel';

  // Validation Messages
  static const String emailRequired = 'Please enter your email';
  static const String emailInvalid = 'Please enter a valid email';
  static const String passwordRequired = 'Please enter your password';
  static const String passwordTooShort = 'Password must be at least 6 characters';
  static const String confirmPasswordRequired = 'Please confirm your password';
  static const String passwordMismatch = 'Passwords do not match';

  // Loading States
  static const String initializingApp = 'Initializing app...';
  static const String loadingUserInfo = 'Loading user information...';
  static const String welcomeBackLoading = 'Welcome back! Loading your panel...';

  // Error Messages
  static const String somethingWentWrong = 'Something went wrong';
  static const String noInternetConnection = 'No internet connection';
  static const String tryAgain = 'Try Again';

  // Success Messages
  static const String accountCreatedSuccess = 'Account created successfully!';
  static const String loginSuccess = 'Login successful!';
  static const String logoutSuccess = 'Logged out successfully';

  // Coming Soon
  static const String comingSoon = 'Coming Soon!';
  static const String productsComingSoon = 'Product catalog coming soon!';
  static const String cartComingSoon = 'Shopping cart coming soon!';
  static const String ordersComingSoon = 'Order history coming soon!';
  static const String manageProductsComingSoon = 'Products management coming soon!';
  static const String manageOrdersComingSoon = 'Orders management coming soon!';

  // Buttons
  static const String browseProducts = 'Browse Products';
  static const String myCart = 'My Cart';
  static const String myOrders = 'My Orders';
  static const String manageProducts = 'Manage Products';
  static const String manageOrders = 'Manage Orders';
  static const String logout = 'Logout';
}