import '../snow_im_context.dart';

abstract class OutboundEncoder<T> {
  OutboundEncoder next;

  encodeSend(SnowIMContext context, T data);
}
