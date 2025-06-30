const _epochTicks = 621356220000000000;

extension TicksOnDateTime on DateTime {
  int get ticks => microsecondsSinceEpoch * 10 + _epochTicks;
}
