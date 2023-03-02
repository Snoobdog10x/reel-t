import 'package:reel_t/screens/abstracts/abstract_provider.dart';

class SampleProvider extends AbstractProvider {
  int count = 0;
  void onTapButton() {
    count++;
    notifyDataChanged();
  }
}
