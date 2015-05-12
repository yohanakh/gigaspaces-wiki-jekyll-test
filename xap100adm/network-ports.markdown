---
layout: post100
title:  Port usage Control
categories: XAP100ADM
parent: network.html
weight: 700
---



XAP space and client components open different ports in various situations. The following list describes the different ports used by XAP and how these can be modified:

{% refer %}Learn how to **[set XAP over a firewall](./network-over-firewall.html)**.{% endrefer %}

{: .table .table-bordered .table-condensed}
| Property name | Description |   Default value |
|:--------|:------------|:----------------------|
|com.sun.jini.reggie.initialUnicastDiscoveryPort|Lookup Service listening port<br>Used as part of the unicast lookup discovery protocol.|XAP 6:4162{% wbr %}XAP 7:4164{% wbr %}XAP 8:4166{% wbr %}XAP 9:4170{% wbr %}<nobr>XAP 9.5:4174</nobr>|
|com.gs.transport_protocol.lrmi.bind-port|LRMI listening port<br>Used with client-space and space-space communication.  |variable , random|
|com.gigaspaces.system.registryPort|RMI registry listening port <br>Used as an alternative directory service.|10098 and above.|
|com.gigaspaces.system.registryRetries|RMI registry Retries <br>Used as an alternative directory service.|Default is 20.|
|com.gigaspaces.start.httpPort|Webster listening port<br>Internal web service used as part of the application deployment process. |9813|


- When starting a space and providing the port as part of the URL - i.e. `java://localhost:PORT/container/space` - the specified port will be used both for the RMI registry listener and also for the container to register into the RMI registry.
- The Jini Lookup Service uses unicast and multicast announcements and requests.
- The **multicast** discovery protocol uses ports 4170.
- You can **completely disable multicast announcement traffic**. Refer to the [Lookup Service Configuration](./network-lookup-service-configuration.html) or [Setting XAP Over Firewall](./network-over-firewall.html) sections for more details.
- When running a clustered space using replication via multicast, additional ports are used.

{% comment %}
| Webster | linux: `NO_HTTP` Windows: `noHTTP` | `0` | `\-Dcom.gigaspaces.start.httpPort=0 \-Dcom.gigaspaces.start.httpServerRetries=20`
   | [How to Control the Used Ports](webster.xml) | Additional properties can also be overridden (for example: `httpServerRetries`, `hostAddress`)

   `httpServerRetries` retries N-1 consecutive ports if the initial port is used (relevant if the initial port is different than zero). Default is 20.
   |
| JMX | linux: `NO_JMX` Windows: `noJMX` | `10098` | `\-Dcom.gigaspaces.system.registryPort=10098` | XML override using
   `com.gigaspaces.start.jmx.svcDesc` | `registryRetries` retries N-1 consecutive ports if the initial port is used (for example: `10098`, `10099`, `..\[10098+(N-1)\]`) |
{% endcomment %}
