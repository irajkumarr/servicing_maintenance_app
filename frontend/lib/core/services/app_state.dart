class AppStateService {
  static bool isInitialized = false;

  static void initialize() {
    // Initialize any app-wide services here
    isInitialized = false;
  }

  static void setInitialized() {
    isInitialized = true;
  }
}