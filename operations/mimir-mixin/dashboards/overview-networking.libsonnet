local utils = import 'mixin-utils/utils.libsonnet';
local filename = 'mimir-overview-networking.json';

(import 'dashboard-utils.libsonnet') {
  [filename]:
    ($.dashboard('Overview networking') + { uid: std.md5(filename) })
    .addClusterSelectorTemplates(false)
    .addRowIf($._config.gateway_enabled, $.jobNetworkingRow('Gateway', 'gateway'))
    .addRow($.jobNetworkingRow('Writes', 'write'))
    .addRow($.jobNetworkingRow('Reads', 'read'))
    .addRow($.jobNetworkingRow('Backend', 'backend'))
    + {
      templating+: {
        list: [
          // Do not allow to include all namespaces.
          l + (if (l.name == 'namespace') then { includeAll: false } else {})
          for l in super.list
        ],
      },
    },
}