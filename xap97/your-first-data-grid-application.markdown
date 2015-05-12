---
layout: post97
title:  XAP in 5 Minutes
categories: XAP97
weight: 100
parent: tutorials.html
---

{%summary%}{%endsummary%}

This tutorial explains how to deploy and use a XAP [Data Grid](/product_overview/the-in-memory-data-grid.html) from a Java client application.

{%comment%}

In this tutorial we will:

1. Download and install **XAP**.
2. Deploy a Data Grid.
3. Write code that connects to the Data Grid and interacts with it.
 
# Download and Install XAP

Getting XAP is simple: download it from the [Current Releases](http://www.gigaspaces.com/LatestProductVersion) page.

Installing XAP is just as easy - unzip it into a directory of your choice:

* On Windows, you might unzip it into `c:\tools\`, which will create `c:\tools\{%version gshome-directory %}`.
* On Unix, you might unzip it into `/usr/local/`, which will create `/usr/local/{%version gshome-directory %}`. You'll also need to grant execution permissions to the scripts in the `bin` folder.
{%endcomment%}

{%vbar title=Download and Install XAP %}
- Download and unzip the latest XAP release from the [downloads page](http://www.gigaspaces.com/xap-download)
- Unzip the distribution into a working directory; GS_HOME
- Set the JAVA_HOME environment variable to point to the JDK root directory
- Start your favorite Java IDE
- Create a new project
- Include all files from the GS_HOME/lib/required in the classpath
{%endvbar%}



# Starting a Service Grid

A Data Grid requires a [Service Grid](/product_overview/service-grid.html) to host it. A service grid is composed of one or more machines (service grid nodes) running a [Service Grid Agent](/product_overview/service-grid.html#gsa) (or `GSA`), and provides a framework to deploy and monitor applications on those machines, in our case the Data Grid.

In this tutorial you'll launch a single node service grid on your machine. To start the service grid, simply run the `gs-agent` script from the product's `bin` folder.


{% inittab%}
{% tabcontent Unix %}
{% highlight bash %}
./gs-agent.sh
{% endhighlight %}
{% endtabcontent %}
{% tabcontent Windows %}
{% highlight bash %}
gs-agent.bat
{% endhighlight %}
{% endtabcontent %}
{% endinittab %}


{% tip title=Optional - The Web Console %}
XAP provides a web-based tool for monitoring and management. From the `bin` folder start the `gs-webui` script, then browse to `localhost:8099`. Click the 'Login' button and take a look at the *Dashboard* and *Hosts* tabs - you'll see the service grid components created on your machine.
{% endtip %}

# Deploying the Data Grid

The Data grid can be deployed from command line, from the web management tool or via an Administration API. In this tutorial we'll use the command line.

Start a command line, navigate to the product's `bin` folder and run the following command:

{% inittab %}
{% tabcontent Unix %}
{% highlight bash %}
./gs.sh deploy-space -cluster total_members=2,1 myGrid
{% endhighlight %}
{% endtabcontent %}
{% tabcontent Windows %}
{% highlight bash %}
gs.bat deploy-space -cluster total_members=2,1 myGrid
{% endhighlight %}
{% endtabcontent %}
{% endinittab %}
  
This command deploys a Data Grid (aka space) called **myGrid** with 2 partitions and 1 backup per partition (hence the `2,1` syntax). 

If you're using the web console mentioned above to see what's going on, you'll see the data grid has been deployed.
 
{%info%}
Note that the Lite edition is limited to a single partition - if you're using it type `total_members=1,1` instead.
{%endinfo%}

# Interacting with the Data Grid


### Connecting to the Grid

Since the Data grid is not located in our client process, we need some sort of address to find it. Data grids are searched using a `Space URL`, for example: `jini://*/*/myGrid`. This roughly translates to: Find a remote space called `myGrid` (for more information see [SpaceURL]({%currentjavaurl%}/the-space-configuration.html)).

Now that we have an address, we can connect to the grid:       

{% highlight java %}
UrlSpaceConfigurer configurer = new UrlSpaceConfigurer("jini://*/*/myGrid");
GigaSpace gigaSpace = new GigaSpaceConfigurer(configurer).create();
{% endhighlight %}

The result is a `GigaSpace` instance, which is a proxy to the `myGrid` data grid. 

{%info%} The `UrlSpaceConfigurer` and `GigaSpaceConfigurer` provide additional options which are not covered in this tutorial.{%endinfo%}

### Implementing a POJO

We now have a `GigaSpace` instance connected to our grid, which we can use to store and retrieve entries. But what shall we write? Actually, any POJO can be stored in the space, so long as it has a default constructor and an ID property. For this tutorial let's define a `Person` class with the following properties:

{% highlight java %}
import com.gigaspaces.annotation.pojo.SpaceId;

public class Person {

    private Integer ssn;
    private String firstName;
    private String lastName;

    // Default constructor (required by XAP)
    public Person() {}

    @SpaceId
    public Integer getSsn() {
        return ssn;
    }
    public void setSsn(Integer ssn) {
        this.ssn = ssn;
    }

    // Getters and Setters of firstName and lastName are omitted in this snippet.    
}
{% endhighlight %}

Note that we've annotated the `ssn` property's getter with a custom XAP annotation `@SpaceId` to mark it as the entry's ID.

{%info%}
The full source code of `Person` is available [at the end](#source) of this tutorial.
{%endinfo%}

### Interacting with the grid

Now that we have a `GigaSpace` instance connected to our grid and a POJO which can be stored, we can store entries in the grid using the `write()` method and read them using various `read()` methods:

{% highlight java %}
System.out.println("Write (store) a couple of entries in the data grid:");
gigaSpace.write(new Person(1, "Vincent", "Chase"));
gigaSpace.write(new Person(2, "Johnny", "Drama"));

System.out.println("Read (retrieve) an entry from the grid by its id:");
Person result1 = gigaSpace.readById(Person.class, 1);

System.out.println("Read an entry from the grid using a SQL-like query:");
Person result2 = gigaSpace.read(new SQLQuery<Person>(Person.class, "firstName=?", "Johnny"));

System.out.println("Read all entries of type Person from the grid:");
Person[] results = gigaSpace.readMultiple(new Person());
{% endhighlight %}

If you're using the web console mentioned above to see what's going on, you'll see two entries stored in the grid, one in each partition.

### {% anchor source %} Full Source Code

{% accordion id=acc1 %}
{% accord parent=acc1 | title=Program.java %}

{% highlight java %}
package com.gigaspaces.demo;

import com.j_spaces.core.client.SQLQuery;
import org.openspaces.core.GigaSpace;
import org.openspaces.core.GigaSpaceConfigurer;
import org.openspaces.core.space.UrlSpaceConfigurer;

public class Program {

    public static void main(String[] args) {
        String url = "jini://*/*/myGrid";
        System.out.println("Connecting to data grid " + url);
        UrlSpaceConfigurer configurer = new UrlSpaceConfigurer(url);
        GigaSpace gigaSpace = new GigaSpaceConfigurer(configurer).create();

        System.out.println("Write (store) a couple of entries in the data grid:");
        gigaSpace.write(new Person(1, "Vincent", "Chase"));
        gigaSpace.write(new Person(2, "Johnny", "Drama"));

        System.out.println("Read (retrieve) an entry from the grid by its id:");
        Person result1 = gigaSpace.readById(Person.class, 1);
        System.out.println("Result: " + result1);

        System.out.println("Read an entry from the grid using a SQL-like query:");
        Person result2 = gigaSpace.read(new SQLQuery<Person>(Person.class, "firstName=?", "Johnny"));
        System.out.println("Result: " + result2);

        System.out.println("Read all entries of type Person from the grid:");
        Person[] results = gigaSpace.readMultiple(new Person());
        System.out.println("Result: " + java.util.Arrays.toString(results));

        configurer.destroy();
    }
}
{% endhighlight %}
{% endaccord %}

{% accord parent=acc1 | title=Person.java %}


{% highlight java %}
package com.gigaspaces.demo;

import com.gigaspaces.annotation.pojo.SpaceId;
import com.gigaspaces.annotation.pojo.SpaceIndex;
import com.gigaspaces.metadata.index.SpaceIndexType;

public class Person {

    private Integer ssn;
    private String firstName;
    private String lastName;

    // Default constructor (required by XAP)
    public Person() {}

    public Person(Integer ssn, String firstName, String lastName) {
        this.ssn = ssn;
        this.firstName = firstName;
        this.lastName = lastName;
    }

    @SpaceId(autoGenerate=false)
    public Integer getSsn() {
        return ssn;
    }
    public void setSsn(Integer ssn) {
        this.ssn = ssn;
    }

    @SpaceIndex(type=SpaceIndexType.BASIC)
    public String getFirstName() {
        return firstName;
    }
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    @Override
    public String toString() {
        return "Person #" + ssn + ": " + firstName + " " + lastName;
    }
}
{% endhighlight %}
{% endaccord %}
{%endaccordion%}

# What's Next?

[The Full XAP Java Tutorial](./java-home.html) will introduce you to the basic concepts and functionalities of XAP. Many ready to run examples are provided.

Read more about the GigaSpaces runtime environment, how to model your data in a clustered environment, and how to leverage the power capabilities of the Space.

- [Elastic Processing Unit]({%currentjavaurl%}/elastic-processing-unit.html)
- [Modeling and Accessing Your Data](/sbp/modeling-your-data.html)
- [Deploying and Interacting with the Space]({%currentjavaurl%}/administrators-guide.html)
- [The GigaSpaces Runtime Environment]({%currentadmurl%}/the-runtime-environment.html)

