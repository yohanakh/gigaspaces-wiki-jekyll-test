
{: .table .table-bordered .table-condensed}
| Property name | Description | Default   |
|-----|---|--|
| space-config.proxy.router.active-server-lookup-timeout |  If an operation cannot be executed because the target member is not available, the maximum time (in milliseconds) the router is allowed to wait while searching for an active member. | 20000 |
| <nobr>space-config.proxy.router.active-server-lookup-sampling-interval</nobr> | The interval (in milliseconds) between active member lookup samples. | 100 |
| space-config.proxy.router.threadpool-size | Number of threads in the dedicated thread pool used by the space proxy router | 2 * number of cores |
| space-config.proxy.router.load-balancer-type | Load balancer type to be used by the router for active-active topologies (STICKY or ROUND_ROBIN) | STICKY |
