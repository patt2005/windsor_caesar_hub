class OnboardingInfo {
  final String title;
  final String description;
  final String imageAssetPath;
  final bool onRight;

  OnboardingInfo({
    required this.onRight,
    required this.imageAssetPath,
    required this.title,
    required this.description,
  });
}

List<OnboardingInfo> onboardingPages = [
  OnboardingInfo(
    onRight: true,
    imageAssetPath: "images/onboarding1.png",
    title: "Stay updated on Windsor’s events!",
    description:
        "Keep track of local news, city projects, roadworks, and public transport changes. Everything happening in your city is just a tap away!",
  ),
  OnboardingInfo(
    onRight: false,
    imageAssetPath: "images/onboarding2.png",
    title: "Contribute to the city’s growth!",
    description:
        "Propose ideas to improve Windsor, vote on initiatives, and help make a difference. Your ideas matter!",
  ),
  OnboardingInfo(
    onRight: true,
    imageAssetPath: "images/onboarding1.png",
    title: "Join volunteer projects!",
    description:
        "Find volunteer events, participate in city projects, and create your own activities. Together, we can make Windsor a better place!",
  ),
];
