
{: .table .table-bordered .table-condensed}
| Property name | Description | Default |
|-----|---|--|
|com.gs.multicast.enabled|Global property allowing you to completely enable or disable multicast in the system.| true|
|com.gs.multicast.announcement|the multicast address that controls the lookup service announcement. The lookup service uses this address to periodically announce its existence. |224.0.1.188|
|com.gs.multicast.request|the multicast address that controls the request of clients (when started) to available lookup services. | 224.0.1.187|
|com.gs.multicast.discoveryPort|the port used during discovery for multicast requests. Defaults to **4174**. Note that in case the property **com.sun.jini.reggie.initialUnicastDiscoveryPort** system property is not defined it is also used as the default post for unicast requests.|4174|
|com.gs.multicast.ttl|The multicast packet time to live. | 3|

{%wbr%}