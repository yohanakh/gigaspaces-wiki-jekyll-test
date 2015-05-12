
#### ESM

{: .table-responsive  .table-condensed   .table-bordered}
| Property name | Description | Default   |
|-----|---|--|
|org.openspaces.grid.esm.ESMFaultDetectionHandler.invocationDelay  |Time interval | 1000 ms |
|org.openspaces.grid.esm.ESMFaultDetectionHandler.retryCount    |Number of retries|    1  |
|org.openspaces.grid.esm.ESMFaultDetectionHandler.retryTimeout   |Retry timeout |   5000 ms  |

#### GSM

{: .table-responsive  .table-condensed   .table-bordered}
| Property name | Description | Default   |
|-----|---|--|
|com.gigaspaces.grid.gsm.GSMFaultDetectionHandler.invocationDelay |Time interval| 1000 ms   |
|com.gigaspaces.grid.gsm.GSMFaultDetectionHandler.retryCount     |Number of retries|  1   |
|com.gigaspaces.grid.gsm.GSMFaultDetectionHandler.retryTimeout    |Retry timeout| 500 ms   |

#### GSA

{: .table-responsive  .table-condensed   .table-bordered}
| Property name | Description | Default   |
|-----|---|--|
|com.gigaspaces.grid.gsa.GSAFaultDetectionHandler.invocationDelay  |Time interval| 1000 ms  |
|com.gigaspaces.grid.gsa.GSAFaultDetectionHandler.retryCount      |Number of retries|  0  |

{%comment%}
|com.gigaspaces.grid.gsa.GSAFaultDetectionHandler.retryTimeout    ||   |
{%endcomment%}

#### GSC

{: .table-responsive  .table-condensed   .table-bordered}
| Property name | Description | Default   |
|-----|---|--|
|com.gigaspaces.grid.gsc.GSCFaultDetectionHandler.invocationDelay  |Time interval|  1000 ms |
|com.gigaspaces.grid.gsc.GSCFaultDetectionHandler.retryCount        |Number of retries| 0 |

{%comment%}
|com.gigaspaces.grid.gsc.GSCFaultDetectionHandler.retryTimeout      || 0 ms |
{%endcomment%}

#### PU

{: .table-responsive  .table-condensed   .table-bordered}
| Property name | Description | Default   |
|-----|---|--|
|org.openspaces.pu.container.servicegrid.PUFaultDetectionHandler.invocationDelay |Time interval | 5000 ms  |
|org.openspaces.pu.container.servicegrid.PUFaultDetectionHandler.retryCount  |Number of retries|    3   |
|org.openspaces.pu.container.servicegrid.PUFaultDetectionHandler.retryTimeout |Retry timeout|   500 ms   |
