
{: .table .table-bordered .table-condensed}
| Property name | Description | Default   |
|---|--|--|
|  com.gs.cluster.cluster_enabled  | Used by the space schema. | **false** |
|  com.gs.cluster.config-url  | Used by the space schema. | |
|  com.gs.cluster.cache-loader.shared-data-source  | Used by the cluster schemas for the **CacheLoader**. | |
|  com.gs.cluster.livenessMonitorFrequency  | Defines the frequency in which liveness of 'live' members in a cluster is monitored. See [Viewing Clustered Space Status](./troubleshooting-viewing-clustered-space-status.html) for more details. |  10000 ms  |
|  com.gs.cluster.livenessDetectorFrequency  | Defines the frequency in which liveness of members in a cluster is detected. See [Viewing Clustered Space Status](./troubleshooting-viewing-clustered-space-status.html) |  5000 ms |
| <nobr> com.gs.cluster.cache-loader.external-data-source</nobr>  | Boolean property. Must be set to **true** when working with external data source | **false** |
|  com.gs.cluster.cache-loader.central-data-source  | Boolean property. Must be set to **true** when the cluster uses external data source and{% wbr %}a central database to keep its data | **false** |
|  com.gs.cluster.url-protocol-prefix  | Used in clustered configuration to provide same prefix for all cluster members URL 0 i.e. **rmi:RMIRegistryMachineHostName**. | Not set by default |
|  com.gs.clusterXML.debug  | Boolean value. If **true**, display cluster configuration when space started. | **False** |
