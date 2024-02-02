String toCamelCase(String? input) {
  if (input == null) {
    return '';
  }

  List<String> words = input.split('_');   String camelCase = '';

  for (int i = 0; i < words.length; i++) {
    String word = words[i];
    camelCase += i == 0 ? word.toLowerCase() : word.isNotEmpty ? word[0].toUpperCase() + word.substring(1).toLowerCase() : '';
  }

  return camelCase;
}
