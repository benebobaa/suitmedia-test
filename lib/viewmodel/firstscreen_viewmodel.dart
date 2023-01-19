class FirstScreenViewModel {
  
  bool isPalindrome(String word) {
    int n = word.length;
    for (int i = 0; i < n / 2; i++) {
      if (word[i] != word[n - i - 1]) {
        return false;
      }
    }
    return true;
  }
}
