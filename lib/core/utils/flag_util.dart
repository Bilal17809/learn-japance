class FlagUtil {
  static String countryCodeToEmoji(String code) {
    code = code.toUpperCase();
    return code.runes.map((char) {
      return String.fromCharCode(0x1F1E6 + (char - 0x41));
    }).join();
  }
}
