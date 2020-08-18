import '../snow_im_context.dart';

abstract class OutboundEncoder<T, R> {
  R encode(SnowIMContext context ,T data);
}
