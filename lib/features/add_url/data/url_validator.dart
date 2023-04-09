abstract class IUrlValidator {
  bool isValid(String url);
}

class UrlValidator implements IUrlValidator {
  const UrlValidator();

  static final _regex = RegExp(r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?');

  @override
  bool isValid(String url) => _regex.hasMatch(url);
}
