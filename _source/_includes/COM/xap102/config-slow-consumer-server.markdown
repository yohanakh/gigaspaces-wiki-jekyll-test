

{: .table .table-bordered .table-condensed}
| Property name | Description | Default   | Unit|
|-----|---|--|
|com.gs.transport_protocol.lrmi.slow-consumer.enabled| Specify whether slow consumer protection is enabled | false | |
|<nobr>com.gs.transport_protocol.lrmi.slow-consumer.throughput</nobr>| Specify what is the lower bound of notification network traffic consumption (in bytes) by a client which below it, is suspected as a slow consumer. | 5000 | bytes/second  |
|com.gs.transport_protocol.lrmi.slow-consumer.latency| Specify a time period the space will evaluate a client suspected as slow consumer until it will be identified as a slow consumer. At the end of this time period, a client identified as a slow consumer will have its notification lease canceled.| 500 | milliseconds|
|com.gs.transport_protocol.lrmi.slow-consumer.retries| Specify the number of times within the specified latency limitation a space will retry to send notification into a client suspected as a slow consumer. | 3 | retries|


