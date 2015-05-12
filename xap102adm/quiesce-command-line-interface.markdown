---
layout: post102
title:  Quiesce Command Line
categories: XAP102ADM
parent: administration-tools.html
weight: 400
---

{%summary%} {%endsummary%}

XAP allows putting a processing unit in quiesce mode (a.k.a maintenance mode). The quiesce mode can be invoked via the CLI. This page explains the usage of the CLI commands.

{%refer%}
For more information please refer to the [Quiesce documentation](./quiesce-overview.html)
{%endrefer%}

# Quiesce A Processing Unit

### Syntax

{%highlight bash%}
gs> quiesce [options] PU_NAME
{%endhighlight%}

### Description

Sends a quiesce request to the GSM for the provided processing unit's name.

{% togglecloak id=1 %}**<u>Example</u>**{% endtogglecloak %}
{% gcloak 1 %}

One option is to specify the processing unit's name in the command:

{% highlight bash %}
gs> quiesce -description some description myPU
Locating processing unit with name [myPU]
Sending quiesce request...
Waiting up to 300 seconds until the processing unit [myPU] is quiesced
Quiesce command completed successfully [token=ee16f577-92df-430b-afc7-2dd9f2c16998]
{%endhighlight%}

Another option is to run the command in interactive way; First it will look for deployed processing units and then you can choose one from the list:

{% highlight bash %}
gs> quiesce
Locating processing units ...
Total processing units: 1
[1]	myPU
Choose a processing unit or "c" to cancel: 1
Enter new value, or press ENTER for the default
	Quiesce description []: the description
	Timeout in seconds [300]: 
Locating processing unit with name [myPU]
Sending quiesce request...
Waiting up to 300 seconds until the processing unit [myPU] is quiesced
Quiesce command completed successfully [token=ee16f577-92df-430b-afc7-2dd9f2c16998]
{% endhighlight %}

{% endgcloak %}

{% togglecloak id=2 %}**<u>Options</u>**{% endtogglecloak %}
{% gcloak 2 %}

{: .table .table-bordered .table-condensed}
|Option|Description|Value Format|
|:-----|:----------|:-----------|
| `-description` | The quiesce request description | `-description [description]`|
| `-timeout` | Timeout for quiesce operation |`-timeout [timeout in seconds]`|
| `-help`  | Prints help | |
{% endgcloak %}




# Unquiesce A Processing Unit

### Syntax

{%highlight bash%}
gs> unquiesce [options] PU_NAME
{%endhighlight%}

### Description

Sends an unquiesce request to the GSM for the provided processing unit's name.

{% togglecloak id=3 %}**<u>Example</u>**{% endtogglecloak %}
{% gcloak 3 %}

Like the quiesce command, the unquiesce command can be executed with a processing unit name;

{% highlight bash %}
gs> unquiesce -description some description myPU
Locating processing unit with name [myPU]
Sending unquiesce request...
Waiting up to 300 seconds until the processing unit [myPU] is unquiesced
Unquiesce command completed successfully
{%endhighlight%}

Or run it in interactive mode:

{% highlight bash %}
gs> unquiesce
Locating processing units ...
Total processing units: 1
[1]	myPU
Choose a processing unit or "c" to cancel: 1
Enter new value, or press ENTER for the default
	Unquiesce description []: the description
	Timeout in seconds [300]: 
Locating processing unit with name [myPU]
Sending unquiesce request...
Waiting up to 300 seconds until the processing unit [myPU] is unquiesced
Unquiesce command completed successfully
{% endhighlight %}

{% endgcloak %}

{% togglecloak id=4 %}**<u>Options</u>**{% endtogglecloak %}
{% gcloak 4 %}

{: .table .table-bordered .table-condensed}
|Option|Description|Value Format|
|:-----|:----------|:-----------|
| `-description` | The unquiesce request description | `-description [description]`|
| `-timeout` | Timeout for unquiesce operation |`-timeout [timeout in seconds]`|
| `-help`  | Prints help | |
{% endgcloak %}
