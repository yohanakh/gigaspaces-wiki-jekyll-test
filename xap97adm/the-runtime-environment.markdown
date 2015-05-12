---
layout: post97adm
title:  The Runtime Environment
categories: XAP97ADM
parent: runtime-configuration.html
weight: 100
---

{% summary %}{% endsummary %}

{% anchor GSRuntimeEnv %}

A processing unit is deployed onto the XAP runtime environment, which is called the [Service Grid](/product_overview/the-runtime-environment.html). It is responsible for materializing the processing unit’s configuration, provisioning its instances to the runtime infrastructure and making sure they continue to run properly over time.


# Starting a Service Grid

In order to start the GSA, the `<GSHOME>/bin/gs-agent.(sh/bat)` can be used.

The preferable (and easiest) way to start a Service Grid is the [Grid Service Agent](/product_overview/service-grid.html#gsa). However, each of the components can be started manually.

The following table summarized how to start each component:

{: .table .table-bordered}
|Component | Linux (XAP) | Windows (XAP) | Windows (XAP.NET) |
|:---------|:------------|:--------------|:------------------|
| GSA | `gs-agent.sh` | `gs-agent.bat` | gs-agent.exe |
| GSC | `gsc.sh` | `gsc.bat` | `gsc.exe` |
| GSM | `gsm_nolus.sh` | `gsm_nolus.bat` | N\A |
| LUS | `startJiniLUS.sh` | `startJiniLUS.bat` | `lus.exe` |
| GSM + LUS | `gsm.sh` | `gsm.bat` | `gsm.exe` |

## GSA Parameters

The GSA parameters control how many local process the GSA will spawn on startup (per process type), and the number of globally managed process the GSA will maintain (in cooperation with other GSAs) (per process type). By default, the GSA is started with 2 local [Grid Service Containers](#gsc), and manage 2 global [Grid Service Manager](#gsm) and 2 global [Lookup Service](/product_overview/service-grid.html#lus). This is the equivalent of starting the GSA with the following parameters:

{% highlight java %}
gs-agent gsa.gsc 2 gsa.global.gsm 2 gsa.global.lus 2
{% endhighlight %}

In order to, for example, start 3 local GSCs, 2 global GSMs, and no global LUS, the following command can be used:

{% highlight java %}
gs-agent gsa.gsc 3 gsa.global.gsm 2 gsa.global.lus 0
{% endhighlight %}

In general, the `gsa.[process type]` followed by a number controls the number of local processes of the specific process type that will be spawned by the GSA. The `gsa.global.[process type]` following by a number controls the number of globally managed processes of the specific process type.

### Lookup Service Considerations

When starting a [Lookup Service](/product_overview/service-grid.html#lus) and other services in unicast mode (not multicast), it means that specific machines will be the ones that will run the [Lookup Service](/product_overview/service-grid.html#lus). This means that on the machines running the LUS, the following command will be used (assuming other defaults are used for GSM and GSC):

{% highlight java %}
gs-agent gsa.global.lus 0 gsa.lus 1
{% endhighlight %}

And on machines that will not run the LUS, the following command should be used:

{% highlight java %}
gs-agent gsa.global.lus 0
{% endhighlight %}

{% comment%}
For instructions on how to configure service grid components refer to [Service Grid Configuration](./service-grid-configuration.html)
{%endcomment%}

{%tip%}
You can use the [GigaSpaces Universal Deployer](/sbp/universal-deployer.html) to deploy complex multi processing unit applications.
{%endtip%}

# Customizing GSA Components

GSA manages different process types. Each process type is defined within the `<GSHOME>\config\gsa` directory in an xml file that identifies the process type by its name.

{% tip %}You can change the default location of the GSA configuration files using the `com.gigaspaces.grid.gsa.config-directory` system property.
{% endtip %}

The following are the process types that come out of the box:

{: .table .table-bordered .table-condensed}
|Processes Type|Description|XML config file name|Properties file name|
|:-------------|:----------|:-------------------|:-------------------|
|gsc|Defines a [Grid Service Container](/product_overview/service-grid.html#gsc)|gsc.xml|gsc.properties|
|gsm|Defines a [Grid Service Manager](/product_overview/service-grid.html#gsm)|gsm.xml|gsm.properties|
|lus|Defines a [Lookup Service](/product_overview/service-grid.html#lus)| lus.xml|lus.properties|
|gsm_lus|Defines a [Grid Service Manager](/product_overview/service-grid.html#gs) and [Lookup Service](/product_overview/service-grid.html#lus) within the same JVM|gsm_lus.xml|gsm_lus.properties|
|esm|Defines an Elastic Service Manager which is required for deploying [Elastic Processing Unit]({%currentjavaurl%}/elastic-processing-unit.html)|esm.xml|esm.properties |

Here is an example of the gsc xml configuration file:

{% highlight xml %}
<process initial-instances="script" shutdown-class="com.gigaspaces.grid.gsa.GigaSpacesShutdownProcessHandler" restart-on-exit="always">
 <script enable="true" work-dir="${com.gs.home}/bin"
  windows="${com.gs.home}/bin/gsc.bat"
  unix="${com.gs.home}/bin/gsc.sh">
  <argument></argument>
 </script>
 <vm enable="true" work-dir="${com.gs.home}/bin"
   main-class="com.gigaspaces.start.SystemBoot">
   <input-argument></input-argument>
   <argument>com.gigaspaces.start.services="GSC"</argument>
 </vm>
 <restart-regex>.*OutOfMemoryError.*</restart-regex>
</process>
{% endhighlight %}

The GSA can either spawn a script based process, or a pure JVM (with its arguments) process. The GSC for example, allows for both types of process spawning.

* The `initial-instances` parameter controls what type of spawning will be performed when the GSA spawns processes by itself (and not on demand by the Admin API). <br>
* The `shutdown-class` followed by the `restart-on-exit` flag, controls if the process will be restarted upon termination. There are three types of values: <br>
   * restart-on-exit="always": Always restarts the process if it exits<br>
   * restart-on-exit="never": Never restarts the process if it exists<br>
   * restart-on-exit="!0": Restarts the process only if the exit code is different than 0<br>
* The `shutdown-class` is an implementation of `com.gigaspaces.grid.gsa.ShutdownProcessHandler` interface and provides the default shutdown hooks before and after shutdown of a process, to make sure it is shutdown properly. The `shutdown-class` can be omitted.<br>
* The `restart-regex` (there can be more than one element) is applied to each console output line of the managed process, and if there is a match, the GSA will automatically restart the process. By default, the GSC will be restarted if there is an `OutOfMemoryError`.

# Grid Configuration

Service Grid configuration is often composed of two layers: system-wide configuration and component-specific configuration.
The system-wide configuration specifies settings which all components share, e.g. discovery (unicast/multicast), security, zones, etc. These are set in the `EXT_JAVA_OPTIONS` environment variable.
The component-specific configuration specifies settings per component type, e.g. the GSC memory limit is greater than the GSM and LUS. These are set in one or more of the following environment variables:

- `GSA_JAVA_OPTIONS`
- `GSC_JAVA_OPTIONS`
- `GSM_JAVA_OPTIONS`
- `LUS_JAVA_OPTIONS`

For example:

{% section %}
{% column width=50% %}
{% highlight java %}
Linux
export GSA_JAVA_OPTIONS=-Xmx256m
export GSC_JAVA_OPTIONS=-Xmx2048m
export GSM_JAVA_OPTIONS=-Xmx1024m
export LUS_JAVA_OPTIONS=-Xmx1024m

. ./gs-agent.sh
{% endhighlight %}
{% endcolumn %}

{% column width=45% %}
{% highlight java %}
Windows
set GSA_JAVA_OPTIONS=-Xmx256m
set GSC_JAVA_OPTIONS=-Xmx2048m
set GSM_JAVA_OPTIONS=-Xmx1024m
set LUS_JAVA_OPTIONS=-Xmx1024m

call gs-agent.bat

{% endhighlight %}
{% endcolumn %}
{% endsection %}

#### Configuring independent components

It is highly recommended that the Service Grid is started (and configured) using the gs-agent as shown above. If you do need to start a specific component separately, you can use the same environment variables shown above.

For example:

{% section %}
{% column width=50% %}
{% highlight java %}
Linux
export GSC_JAVA_OPTIONS=-Xmx1024m

. ./gsc.sh
{% endhighlight %}
{% endcolumn %}
{% column width=45% %}
{% highlight java  %}
Windows
set GSC_JAVA_OPTIONS=-Xmx1024m

call gsc.bat
{% endhighlight %}
{% endcolumn %}
{% endsection %}

{% note %}
Component specific configuration can be set using system properties (follows the [component name].[property name] notation).
{%endnote%}

{%comment%}

=======================================Old version=================================================================
# Overview

{%section%}
{%column width=50% %}
The basic unit of deployment in the GigaSpaces XAP platform is the [Processing Unit](./packaging-and-deployment.html).

Once packaged, a processing unit is deployed onto the GigaSpaces runtime environment, which is called the *Service Grid*. It is responsible for materializing the processing unit's configuration, provisioning its instances to the runtime infrastructure and making sure they continue to run properly over time.
{%endcolumn%}

{%column width=45% %}
![archi_deployenv.jpg](/attachment_files/archi_deployenv.jpg)
{%endcolumn%}
{%endsection%}

{% info %}When developing your processing unit, you can [run and debug the processing unit within your IDE](./running-and-debugging-within-your-ide.html). You will typically deploy it to the GigaSpaces runtime environment when it's ready for production or when you want to run it in the real-life runtime environment{% endinfo %}

# Service Grid Architecture

The service grid is composed of a number of components:

![gs_runtime.jpg](/attachment_files/gs_runtime.jpg)



## Core Components

A processing unit can be deployed to the Service Grid using one of GigaSpaces deployment tools (UI, CLI, API), which uploads it to the *GSM* [Grid Service Manager](/product_overview/service-grid.html#gsm), the component which manages the deployment and life cycle of the processing unit). The GSM analyzes the deployment descriptor and determines how many instances of the processing unit should be created, and which containers should run them. It then ships the processing unit code to the running *GSC*'s [Grid Service Container](./service-grid.html#gsc) and instructs them to instantiate the processing unit instances. The GSC provides an isolated runtime for the processing unit instance, and exposes its state to the GSM for monitoring. This phase in the deployment process is called *provisioning*.

Once provisioned, the GSM continuously monitors the processing unit instances to determine if they're functioning properly or not. When a certain instance fails, the GSM identifies that and re-provisions the failed instance on to another GSC, thus enforcing the processing unit's SLA.

In order to discover one another in the network, the GSCs and GSMs use a [Lookup Service](/product_overview/service-grid.html#lus), also called *LUS*. Each GSM and GSC registers itself in the LUS, and monitors the LUS to discover other GSM and GSC instances.

Finally, the *GSA* [Grid Service Agent](/product_overview/service-grid.html#gsa) component is used to start and manage the other components of the Service Grid (i.e. GSC, GSM, LUS). Typically, the GSA is started with the hosting machine's startup. Using the agent, you can bootstrap the entire cluster very easily, and start and stop additional GSCs, GSMs and lookup services at will.

All of the above components are fully manageable from the GigaSpaces management interfaces such as the [UI](./graphical-user-interface.html), CLI and [Admin API](./administration-and-monitoring-api.html).

## Optional Components

* The Elastic Service Manager (ESM) manages the [Elastic Processing Unit](./elastic-processing-unit.html) together with the GSM.

* The [Apache Load Balancer Agent](./apache-load-balancer-agent.html) is used when deploying web applications.

* The Transaction Manager (TXM) is an optional component. When executing transactions that spans multiple space partitions you should use the Jini Transaction Manager or the Distributed Transaction Manager. See the [Transaction Management](./transaction-management.html) section for details.

{%endcomment%}

