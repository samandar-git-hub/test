enum DeviceType {
  iphone17Pro,
  samsungS26,
}

class DeviceConfig {
  final DeviceType type;
  final String name;
  final String icon;
  final double width;
  final double height;
  final double screenRadius;
  final double bezelRadius;
  final double bezelPadding;
  final double statusBarHeight;

  const DeviceConfig({
    required this.type,
    required this.name,
    required this.icon,
    required this.width,
    required this.height,
    required this.screenRadius,
    required this.bezelRadius,
    required this.bezelPadding,
    required this.statusBarHeight,
  });
}

const Map<DeviceType, DeviceConfig> deviceConfigs = {
  DeviceType.iphone17Pro: DeviceConfig(
    type: DeviceType.iphone17Pro,
    name: 'iPhone 17 Pro',
    icon: '📱',
    width: 393,
    height: 852,
    screenRadius: 50,
    bezelRadius: 60,
    bezelPadding: 10,
    statusBarHeight: 36,
  ),
  DeviceType.samsungS26: DeviceConfig(
    type: DeviceType.samsungS26,
    name: 'Samsung Galaxy S26',
    icon: '🤖',
    width: 360,
    height: 800,
    screenRadius: 28,
    bezelRadius: 36,
    bezelPadding: 8,
    statusBarHeight: 32,
  ),
};
