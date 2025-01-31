import 'dart:math';

String generateUserId() {
  return 'user_${Random().nextInt(10000)}';
}
