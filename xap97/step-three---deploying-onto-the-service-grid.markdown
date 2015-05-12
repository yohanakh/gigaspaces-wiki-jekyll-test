---
layout: post97
title:  Step Three - Deploying onto the Service Grid
categories: XAP97
weight: 400
parent: your-first-xtp-application.html
---


**Tutorial summary**: In this tutorial you learn how to deploy the Hello World application onto the GigaSpaces Service Grid to achieve fail-over, scaling and self-healing capabilities for your application. {% sub %}Approx 10 min{% endsub %}

{% comment %}
=======================================================================
                  OVERVIEW
=======================================================================
{% endcomment %}

## Overview

{% comment %}
--------------------------------------------------------------------------
{% color grey %}   EXAMPLE FOLDER, SOURCES and INTRODUCED FEATURES (Overview)
   ==========================================================
   TODO: write path to the sample application inside the product and
   a link to the Wiki pages containing the sources
   the source should be in wiki pages under this page with names "- JAVA -.java"
   List GigaSpaces features introduced for the first time in this tutorial.
{% endcolor %}
-------------------------------------------------------------------------------
{% endcomment %}

{%folderopen%} Example Folder - <GigaSpaces Root>\examples\helloworld

{% note %}
Features Introduced - Service Grid, Grid Service Manager (GSM), Grid Service Container (GSC), Failover, Self-Healing, Deployment.
{%endnote%}

{% whr %}

{% comment %}
--------------------------------------------------------------------------
{% color grey %}   BEFORE YOU BEGIN (Overview)
   ===========================
   TODO: List tutorials/documentation artifacts to go through before view the current tutorial.
{% endcolor %}
-------------------------------------------------------------------------------
{% endcomment %}

{% comment %}
![Download arrow.bmp](/attachment_files/Download%20arrow.bmp) **
{% color green %}Find{% endcolor %}
** tutorial package at `\examples\tutorials\helloworld-gigaspaces`
{% endcomment %}

#### Before you Begin

We recommend that you go through the following steps before starting this tutorial:

1. [Download GigaSpaces and set up your development environment](./installation-guide.html) - this is needed to run the tutorial sample application.
1. [Step One - Using Processing Units For Scaling](./step-one---using-processing-units-for-scaling.html) - a short introduction to how processing units are used for scaling your application - **Recommended**.
1. [Step Two - Creating the Hello World Application](./step-two---creating-the-hello-world-application.html) - Create and run your first Processing Unit.

{% whr %}

{% comment %}
----------------------------------------------------------------------------------
{% color grey %}   GOALS (Overview)
   ================
   TODO: describe using a short sentence what the user does in this tutorial, how do I:
{% endcolor %}
---------------------------------------------------------------------------------------
{% endcomment %}

#### Goals

Start the Service Grid components, deploy and run the Hello World application on them, with and without backups. Test failover and SLA capabilities, and monitor the application at runtime.

{% comment %}
----------------------------------------------------------------------------
{% color grey %}   STEPS (Overview)
   ================
   TODO: List tasks executed in this tutorial in a "How do I" enumerated task list.
{% endcolor %}
---------------------------------------------------------------------------------
{% endcomment %}

#### Steps

1. [Deployment process](#Deployment Process)
1. [Failover to a backup instance](#Failover)
1. [Starting the service grid components - Grid Service Manager (GSM) and Grid Service Containers (GSCs)](#Deploy and Run)
1. [Deploying the Hello World application onto the Service Grid](#Prepare Single Instance).
1. [Running the feeder application](#Run Feeder)
1. [Undeploying the single instance deployment](#undeploy)
1. [Deploying the Hello World application with Primary-Backup mode to enable automatic failover](#deploy with backup)

{% comment %}
1. [Testing failover to a backup instance](#Test Failover)
{% endcomment %}

{% comment %}
----------------------------------------------------------------------------
{% color grey %}   LINK TO FAST RUN (Overview)
   ===========================
   TODO: add link to fast run
{% endcolor %}
---------------------------------------------------------------------------------
{% endcomment %}

Jump  ahead and [deploy the sample application](#Deploy and Run), in case you want to see the final result of the tutorial before we begin.

{% comment %}
-----------------------------------------------------------------------------------------
{% color grey %}   COMPONENTS (Overview)
   =====================
   List application components linked to their explanations later in the tutorial and add figures
{% endcolor %}
----------------------------------------------------------------------------------------------
{% endcomment %}

#### Application Components

{% section %}
{% column width=70% %}

The Processing Unit that we deploy onto the Service Grid is our Hello World Processor from the [previous step](./step-two---creating-the-hello-world-application.html).
Reminder - the Feeder application writes each Message object to the processor Processing Unit, which in turn processes them.
{% align center %}

![Application Components.jpg](/attachment_files/Application Components.jpg)
{% sub %}**Figure 1. The Hello World Feeder and Processor Processing Unit**{% endsub %}
{% endalign %}

{% endcolumn %}
{% column %}

{% endcolumn %}
{% endsection %}

{% section %}

{% column width=70% %}

#### Infrastructure (Service Grid) Components

The _Service Grid_ is a set of containers (_Grid Service Containers_ - GSCs) managed by one or more managers (_Grid Service Managers_ - GSMs).
Each Grid Service Container runs inside its own JVM. The containers themselves host _Processing Units_.
The Grid Service Manager manages the deployment of processing units and their provisioning to the the Grid Service Containers. In production scenarios you may want to have more than one manager, so it does not become a single point of failure.
The _GigaSpaces Management Center_ is the graphical user interface for administrating and monitoring the _Service Grid_ and the deployed applications.

{% align center %}

![Infra Components.jpg](/attachment_files/Infra Components.jpg)
{% sub %}**Figure 2. A Service Grid consisting of a Grid Service Manager and two Grid Service Containers**{% endsub %}
{% endalign %}

{% endcolumn %}
{% column %}

{% endcolumn %}
{% endsection %}

#### Deployment Overview

In this tutorial we deploy the Hello World Processor onto the service Grid, first as a single instance (Figure 3), then with an additional backup instance to support failover (Figure 4).

{% section %}
{% column width=40% %}
{% align center %}

![Application With Infra.jpg](/attachment_files/Application With Infra.jpg)
{% sub %}**Figure 3. The Hello World Processor deployed onto the Service Grid as a single instance**{% endsub %}
{% endalign %}

{% endcolumn %}
{% column width=40% %}
{% align center %}

![Sync2Backup With Infra.jpg](/attachment_files/Sync2Backup With Infra.jpg)
{% sub %}**Figure 4. The Hello World Processor deployed onto the Service Grid with one primary instance and one backup instance**{% endsub %}
{% endalign %}

{% endcolumn %}
{% endsection %}

{% comment %}
=======================================================================
                  DEPLOYMENT PROCESS
=======================================================================
{% endcomment %}

{% anchor Deployment Process %}

## Deployment Process

After the Hello World Processor application is [built and put into a JAR file](#Deploy and Run), we [start the Service Grid Components](#Start Service Grid). We use the _Management Center GUI_ to deploy the Hello World Processor to the Service Grid, first as a [single instance](#Deploy As Single Instance), and then [with a backup instance as well](#deploy with backup), to demonstrate failover.

**What happens during the deployment process**
Deploying a Processing Unit is done by selecting its JAR file for deployment from the _Management Center_ user interface. The JAR is then passed to the _Grid Service Manager_, which analyzes its deployment requirements (These requirements are expressed in a file called the _Deployment Descriptor_) The Grid Manager then provisions the Processing Unit instances into the _Grid Service Containers_, which in turn load the processing unit binaries from the _Grid Service Manager_ and start the Processing Unit instance - see Figure 5 below.

{% align center %}

![Deploying.jpg](/attachment_files/Deploying.jpg)
{% sub %}**Figure 5. Deploying the Processor Processing Unit onto the Service Grid**{% endsub %}
{% endalign %}

{% comment %}
=======================================================================
                  FAILOVER
=======================================================================
{% endcomment %}

{% anchor Failover %}

## Failover to a Backup Instance

To achieve failover capabilities and avoid a single point of failure, the Processing Unit is deployed with two instances - a primary and a backup. All objects written to the space of the primary instance are synchronously replicated to the backup instance, thus enabling quick failover to the backup instance in case the primary instance fails.
In addition, after the failover, the _Grid Service Manager_ provisions a new backup to another Grid Service Container (if it exists), to maintain high availability for the Processing Unit. This is the self-healing part of the GigaSpaces deployment mechanism.

{% align center %}

![Failover.jpg](/attachment_files/Failover.jpg)
{% sub %}**Figure 6. Failover to the backup instance after failure of the primary Processing Unit**{% endsub %}
{% endalign %}

#### Feeder View of the Failover Process

Since the feeder interacts with (writes objects to) the space, using a space proxy, which hides the actual deployment topology and runtime status from it, the whole failover process is completely transparent to it.
The only noticeable effect may be a slight delay in the space response time to the feeder calls.

{% align center %}

![Feeder Proxy.jpg](/attachment_files/Feeder Proxy.jpg)
{% sub %}**Figure 7. The Feeder is using a proxy that automatically connects to the primary Processing Unit**{% endsub %}
{% endalign %}

{% comment %}
-----------------------------------------------------------------------
{% color grey %}Take the following steps to build and run the sample application:

Compile TODO: Step by step on how to compile the package supplied.
In some tutorials this part can be called Build/Build and Package
{% endcolor %}
----------------------------------------------------------------------------
{% endcomment %}

{% comment %}
=======================================================================
                  START SERVICE GRID AND DEPLOY APPLICATION
=======================================================================
{% endcomment %}

{% anchor Deploy and Run %}

## Starting the Service Grid Components and Deploying the Application

**Steps to deploy the application:**

**Install GigaSpaces**

{% exclamation %} After going through the previous tutorial [Step Two - Creating the Hello World Application](./step-two---creating-the-hello-world-application.html), you should have GigaSpaces installed and the Hello World sample application environment set. If not, please [download GigaSpaces and set up your development environment](./installation-guide.html) to work with GigaSpaces - this is needed to run the tutorial sample application.

{% anchor Start Service Grid %}

#### Starting the Service Grid Components

1. Start **GigaSpaces Management Center (GS-UI)** by running `<GigaSpaces Root>/bin/gs-ui.bat(.sh)`.
1. Start a **GigaSpaces Agent (GSA)** by running `<GigaSpaces Root>/bin/gs-agent.(sh/bat)`.
The GSA, by default, will start 2 local Grid Service Containers, and manage a global Grid Service Manager and a global Lookup Service.

{% togglecloak id=AGENT %} What is a GigaSpaces Agent...{% endtogglecloak %}
{% gcloak AGENT %}
{% panel bgColor=white|borderStyle=solid %}

**The GigaSpaces Agent**

[The GigaSpaces Agent (GSA)](/product_overview/service-grid.html#gsa) acts as a process manager that can spawn and manage Service Grid processes (Operating System level processes) such as the Grid Service Manager (aka [The GigaSpaces Manager](/product_overview/service-grid.html#gsm)), the Grid Service Container (aka [The GigaSpaces Container](/product_overview/service-grid.html#gsc)), and Lookup Service.

{% endpanel %}
{% endgcloak %}

{% comment %}
---------------

{% togglecloak id=GLOBALLOCAL %} What is a Local/Global process type...{% endtogglecloak %}
{% gcloak GLOBALLOCAL %}
{% panel bgColor=white|borderStyle=solid %}

**Process Management**

The GSA manages Operating System processes. There are two types of process management, local and global.

Local processes simply start the process type (for example, a [GigaSpaces Container](/product_overview/service-grid.html#gsc)) without taking into account any other process types running by different GSAs.

Global processes take into account the number of process types ([GigaSpaces Manager](/product_overview/service-grid.html#gsm) for example) that are currently running by other GSAs (within the same lookup groups or lookup locators). It will automatically try and run at least X number of processes **across** all the different GSAs (with a maximum of 1 process type per GSA). If a GSA running a process type that is managed globally fails, another GSA will identify the failure and start it in order to maintain at least X number of global process types.

{% endpanel %}
{% endgcloak %}
---------------------
{% endcomment %}

A new Grid Service Manager starts on your local machine, and its output can be viewed by clicking its name **gsm-1** inside the **Hosts** tab.
A new Grid Service Containers start on your local machine, and its output can be viewed by clicking their names **gsc-1**/**gsc-2** inside the **Hosts** tab.
The Grid Service Manger automatically detects the Grid Service Containers. Now we have a Service Grid with one manager and two containers up and running!

{% sub %}(The Service Grid Components started here are _local_ services, all running on your own machine. Naturally, in a production environment, they are started on separate machines, using the startup scripts that the product provides.){% endsub %}

{% anchor Prepare Single Instance %}

#### Deploying the Application with No Backup Instances

**Prepare the Processor Processing Unit for deployment with No Backups**

1. Build the processor Processing Unit by running `<Hello World Example Root>/build.bat(.sh) dist`.
 This compiles the Processor source files and creates the processing unit JAR file, ready for deployment under `<Hello World Example Root>/processor/pu/hello-processor.jar`.

{% anchor Deploy As Single Instance %}
**Deploying the Hello World Processor with No Backup**

1. Click the **Deploy Processing Unit Button** ![deploy_processing_unit_button.jpg](/attachment_files/deploy_processing_unit_button.jpg) to open the **Deployment Wizard** dialog.
1. Click the **Processing Unit** field **...** button, to browse for the processing unit JAR file.
1. Browse to the **hello-processor.jar** JAR file, located at `<Hello World Example Root>/processor/pu` folder, and select it.
1. Click the **Deploy** button, to deploy and wait for the processing unit to be provisioned to the running Grid Service Container.

{% anchor Run Feeder %}

#### Running the Feeder

1. Start the feeder by running `<Hello World Example root>/build.bat(.sh) run-feeder`.

Before deploying the application with a backup, we first undeploy the current single instance deployment:

{% anchor undeploy %}

#### Undeploying the Single Instance Deployment

1. In the **Deployed Processing Units tab**, under the **Processing Units** tree, right click the **hello-processor* deployment and click *Undeploy**.
1. Click **Yes** to approve.

{% anchor deploy with backup %}

#### Deploying as a Single Instance with Backup

{% note title=For Community Edition Users %}
If you are a community edition user, please note that you will not be able to perform this step since the community edition limits the number of space instances to one
{% endnote %}

{% anchor Prepare Single With Backup %}
**Prepare the Processor Processing Unit for deployment as a single instance with backup**

1. Edit the processor's  **pu.xml** configuration file located under `<GigaSpaces root>/examples/helloworld/processor/src/META-INF/spring` folder.
1. Uncomment (Remove the surrounding <!-- -->), or add the following SLA bean definition, which contains the deployment configuration, to the **pu.xml** file:

{% highlight xml %}
<os-sla:sla
	cluster-schema="partitioned-sync2backup"
	number-of-instances="1"
	number-of-backups="1"
	max-instances-per-vm="1">
</os-sla:sla>
{% endhighlight %}

1. Build the processor Processing Unit by running `<Hello World Example Root>/build.bat(.sh) dist`.
This compiles the processor into a JAR file, ready for deployment, located under `<Hello World Example Root>/processor/pu/hello-processor.jar`.

{% anchor Deploy as a Single Instance with Backup %}
**Deploying the Hello World Processor as a Single Instance with Backup**

{% comment %}
# Start an additional Grid Service Container by by clicking **Launch > Local Services (GSM\GSC) > _Grid Service Container_**.

A new Grid Service Container starts on your local machine, and its output is shown inside a **GSC-1** tab, at the lower part of your screen.
{% endcomment %}

1. Click the **Deploy Processing Unit Button* ![deploy_processing_unit_button.jpg](/attachment_files/deploy_processing_unit_button.jpg) to open the *Deployment Wizard** dialog.
1. Click the **Processing Unit** field **...** button, to browse for the processing unit JAR file.
1. Browse to the **hello-processor.jar** JAR file, located at `<Hello World Example Root>/processor/pu` folder, and select it.
1. Click the **Deploy** button, to deploy and wait for the processing unit instances to be provisioned to the running Grid Service Containers.

{% anchor Run Feeder2 %}

#### Running the Feeder

1. Start the feeder by running `<Hello World Example root>/build.bat(.sh) run-feeder`

{% comment %}
----------------------------------------------------------------------------
{% color grey %}What's Next?
{% endcolor %}
---------------------------------------------------------------------------------
{% endcomment %}

## What's Next?

Step Four - [Scaling the Hello World Application](./step-four---scaling-the-hello-world-application.html)

Or return to the [Quick Start Guide](./index.html).
