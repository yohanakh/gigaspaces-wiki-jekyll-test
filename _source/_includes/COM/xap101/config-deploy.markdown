
{: .table .table-bordered .table-condensed}
| Property name | Description | Default   |
|-----|---|--|
| com.gs.home | XAP home directory. Not required, if not set explicitly, it is resolved | GSHOME |
| com.gs.deploy | The location of the deploy directory of the GSM. | GSHOME/deploy |
| com.gs.work | The location of the work directory of the GSM and GSC. | GSHOME/work |
|com.gs.pu-common|The location of common classes used across multiple processing units. The libraries located within this folder loaded into each PU instance classloader (and not into the system classloader as with the `com.gigaspaces.lib.platform.ext`.|GSHOME\lib\optional\pu-common  |
|com.gigaspaces.lib.platform.ext|PUs shared classloader libraries folder. PU jars located within this folder loaded once into the JVM system classloader and shared between all the PU instances classloaders within the GSC. In most cases this is a better option than the com.gs.pu-common for JDBC drivers and other 3rd party libraries. This is useful option when you want multiple processing units to share the same 3rd party jar files and do not want to repackage the processing unit jar whenever one of these 3rd party jars changes.|GSHOME\lib\platform\ext|
