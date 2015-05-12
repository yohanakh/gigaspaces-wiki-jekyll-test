
{: .table .table-bordered .table-condensed}
| Property name | Description | Default   |
|-----|---|--|
|gs.admin.jvm.probe.details |  Implementation of `JVMDetailsProbe`,probing the jvm, `JVMDetails` is used to return the details of the jvm such as jvm name, version vendor, start time, heap data etc.|   SigarJVMDetailsProbe|
|gs.admin.jvm.probe.statistics|Implementation of `JVMStatisticsProbe`, provides JVM statistics | SigarJVMStatisticsProbe|
|gs.admin.os.probe.statistics |Implementation of `OSStatistics`, provides OS statistics such as memory and network usage.| SigarOSStatisticsProbe|
|gs.admin.os.probe.details|    Implementation of `OSDetailsProbe`, provides OS details `OSDetails` like uid, name, architecture, version, processors number, host name and address etc.| SigarOSDetailsProbe|