---
layout: post101
title:  Monitoring
categories: XAP101ADM
parent: web-management-console.html
weight: 540
---


{% summary %}{% endsummary %}


The `Monitoring` view lets you view `Processing Unit Infrastructure` and  `Processing Unit properties` statistics. XAP provides
default templates for this. All default dashboard templates can be changed. They are located under `[XAP_HOME]/config/webui/dashboards`.

The monitoring view relies on [InfluxDB](http://influxdb.com/). InfluxDB is used to store the time series values that are generated from the XAP infrastructure.
[Grafana](http://grafana.org)  runs in the browser and connects to InfluxDB to present the time series data that is stored there.

# InfluxDB

Please refer to the InfluxDB website for [installation](http://influxdb.com/docs/v0.8/introduction/installation.html) instructions.
Once InfluxDB is installed you need to create two data bases and then connect XAP to the repositories.  Follow the steps below to configure InfluxDB and connect your XAP environment to it.


### Create the data bases

After you installed the InfluxDB, login into the web console and create two data bases that will be used by XAP to store the time series values.

The first data base we will call `metrics` and the second one is called `grafana`.

Create the data bases:

![hosts1.jpg](/attachment_files/web-console/influxdb-create-db.jpg)

<br>

![hosts1.jpg](/attachment_files/web-console/influxdb-create-db2.jpg)

<br>


# Configure XAP

We need to configure the connection between XAP and InfluxDB. This is done by modifying the `metrics.xml` file which you can find in the XAP distribution
folder `[XAP_HOME]/config/metrics`.

First we configure the reporters:

{%highlight xml%}
<metrics-configuration>
    <reporters>
        <reporter name="influxdb-http">
            <property name="host" value="influxdb-host"/>
            <property name="database" value="metrics"/>
            <property name="username" value="root"/>
            <property name="password" value="root"/>
        </reporter>
    </reporters>
</metrics-configuration>
{%endhighlight%}

{%refer%}
Please refer to the [InfluxDB Reporter](./metrics-influxdb-reporter.html) section for detailed configuration instructions.
{%endrefer%}

Then you configure the dashboard connection for Grafana:

{%highlight xml%}
   <grafana>
        <datasources>
            <datasource name="influxdb">
                <property name="type" value="influxdb"/>
                <property name="url" value="http://influxdb-host:8086/db/metrics"/>
                <property name="username" value="root"/>
                <property name="password" value="root"/>
            </datasource>
            <datasource name="grafana">
                <property name="type" value="influxdb"/>
                <property name="url" value="http://influxdb-host:8086/db/grafana"/>
                <property name="username" value="root"/>
                <property name="password" value="root"/>
                <property name="grafanaDB" value="true"/>
            </datasource>
        </datasources>
    </grafana>
{%endhighlight%}


After this configuration, restart XAP. Your XAP infrastructure should now be connected and generate data in InfluxDB with the default configuration.


# Monitor view

When you open the `Monitor` tab in the XAP web console, you will see the following view:

![hosts1.jpg](/attachment_files/web-console/monitor.jpg)

<br>

# Dashboards

By selecting the folder icon on the right in the menu bar, the available dashboards will be displayed:

![hosts1.jpg](/attachment_files/web-console/monitor1.jpg)

<br>

## Default Space dashboard

![hosts1.jpg](/attachment_files/web-console/monitor2.jpg)

<br>

## Default Processing Unit dashboard

![hosts1.jpg](/attachment_files/web-console/monitor3.jpg)




{%comment%}




This view will be only available if:
1.       Either no secured login performed or in the case of secured login logged in user has both Monitor JVM and Monitor PU permissions.
2.       grafana section in monitoring.xml must be configured to existing running InfluxDb.

Two following dashboards are created for each processing unit:
1.       Processing Unit Infrastructure – exposes VM and LRMI information about vm used by deployed processing unit instances
2.       Processing Unit properties – processing unit information: events information
For each stateful processing unit additional space dashboard created, it exposes space related information: space operations, transactions, connections, replications etc.

All default dashboard templates can be changed and they are located under [XAP_HOME]/config/webui/dashboards, but please note that all changes will be affected only on new deployed processing units, existing and already stored in “grafana” db dashboards will not be changed.

{%endcomment%}
