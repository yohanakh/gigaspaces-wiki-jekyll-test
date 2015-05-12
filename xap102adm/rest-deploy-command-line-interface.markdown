---
layout: post102
title:  Deploying REST service with Command Line
categories: XAP102ADM
parent: administration-tools.html
weight: 250
---



XAP provides an interactive command line tool as part of the product. This can be started using gs.sh/bat command (referred to as **GigaSpaces CLI**).

This tool provides many commands that can be used to manage and gather information about the various GigaSpaces runtime components. This section describes the commands supported by GigaSpaces CLI.


# Deploy Rest service

### Syntax

{%highlight bash%}
gs> deploy-rest -spacename [space name] -port [port number]
{%endhighlight%}

### Description

Deploys a [Rest Processing Unit]({%currentjavaurl%}/rest-service-overview.html), which starts an embedded jetty and enables interactions with the provided `spacename`.

The processing unit's name will be `spacename`-rest unless the -puname [name] option is provided.


{% togglecloak id=1 %}**<u>Example</u>**{% endtogglecloak %}
{% gcloak 1 %}


The following deploys rest processing unit and starts a rest service on port 8888 that connects to mySpace.

    gs> deploy-rest -spacename mySpace -port 8888


{% endgcloak %}

{% togglecloak id=2 %}**<u>Options</u>**{% endtogglecloak %}
{% gcloak 2 %}

{: .table .table-bordered .table-condensed}
|Syntax|Description|
|:-----|:----------|
| `-spacename [space name]` | **Required** - Name of the Space that the rest should connect to.|
| `-port [number]` | **Required** - The port which the rest service will be available on. |
| `-puname [processing unit name]` |  Specify the processing unit's name. Defaults to [spacename]-rest |
| `-lookup-groups [comma separated list]` |  The lookup groups to be used when locating the specified space. |
| `-lookup-locators [comma separated list of host:port]` | The lookup locators to be used when locating the specified space. |
| `-instances [number]` |  Specify the amount of instances to be deployed. Default to 1 |
| `-max-instances-per-vm [number]` |  Specify the number of instances per VM. |
| `-max-instance-per-machine [number]` |  Specify the number of instances per machine. |
| `-zones [comma separated list]` |  Specify the zones that the rest pu can be deployed on |
| `-primary-zone [zone name]` |  Set the primary zone where the processing unit is allowed to be deployed on. |
| `-timeout [time in seconds]` |  Set the timeout for deploying the rest processing unit. Default to 30 |
{% endgcloak %}

