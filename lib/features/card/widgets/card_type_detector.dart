class CardTypeDetector {
  static String detectCardType(String cardNumber) {
    if (cardNumber.startsWith('9860') ||
        cardNumber.startsWith('9861') ||
        cardNumber.startsWith('9862')) {
      return 'HUMO';
    } else if (cardNumber.startsWith('8600') ||
        cardNumber.startsWith('8601') ||
        cardNumber.startsWith('8602') ||
        cardNumber.startsWith('8603')) {
      return 'UZCARD';
    } else if (cardNumber.startsWith('4')) {
      return 'VISA';
    } else if (cardNumber.startsWith('5')) {
      return 'MASTERCARD';
    } else {
      return 'CARD';
    }
  }

  static bool isHumo(String cardNumber) {
    return cardNumber.startsWith('986');
  }

  static bool isUzcard(String cardNumber) {
    return cardNumber.startsWith('860');
  }

  static bool isVisa(String cardNumber) {
    return cardNumber.startsWith('4');
  }

  static bool isMastercard(String cardNumber) {
    return cardNumber.startsWith('5');
  }
}