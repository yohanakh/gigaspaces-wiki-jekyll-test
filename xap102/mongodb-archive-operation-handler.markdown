---
layout: post102
title:  Archive Handler
categories: XAP102
parent: mongodb.html
weight: 200
---


{%section%}
{%column width=80% %}
The [Archive Container](./archive-container.html) can be configured to work against MongoDB (without writing any extra code). The [ArchiveOperationHandler interface](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/org/openspaces/archive/ArchiveOperationHandler.html) abstracts the Big-Data storage from the [Archive Container](./archive-container.html). The MongoDB Archive Operation Handler implements this interface by serializing space objects into MongoDB.
{%endcolumn%}
{%column width=20% %}

{%popup /attachment_files/archive-container-mongodb.jpg%}
{%endcolumn%}
{%endsection%}


#### Library dependencies

The MongoDB Archive Operation Handler uses the [MongoDB driver](http://docs.mongodb.org/ecosystem/drivers/java/) for communicating with the MongoDB cluster.
Include the following in your `pom.xml`


{% highlight xml %}

	<!-- currently the MongoDB library is not the central maven repository --> 
	<repositories>
		<repository>
			<id>org.openspaces</id>
			<name>OpenSpaces</name>
			<url>http://maven-repository.openspaces.org</url>
		</repository>
	</repositories>


	<dependencies>
		...
		<!-- mongodb java driver -->
		<dependency>
			<groupId>org.mongodb</groupId>
			<artifactId>mongo-java-driver</artifactId>
			<version>2.11.2</version>
		</dependency>

		<dependency> 
			<groupId>org.antlr</groupId> 
			<artifactId>antlr4-runtime</artifactId> 
			<version>4.0</version> 
		</dependency> 

		<dependency>
    		<groupId>com.gigaspaces</groupId>
	    	<artifactId>mongo-datasource</artifactId>
    		<version>10.0.0-SNAPSHOT</version>
		</dependency>
		...
	</dependencies>
	
{% endhighlight %}



#### Setup

{% inittab os_simple_space|top %}

{%comment%}
{% tabcontent Namespace %}

{% highlight xml %}

	<os-archive:mongo-archive-handler id="mongoArchiveHandler" 
		giga-space="gigaSpace" 
		config-ref="config" 
		db="${mongodb.db}"/>
		
{% endhighlight %}

{% endtabcontent %}

{%endcomment%}

{% tabcontent Plain XML %}

{% highlight xml %}

	<bean id="mongoArchiveHandler" class="com.gigaspaces.persistency.archive.MongoArchiveOperationHandler">
		<property name="gigaSpace" ref="gigaSpace" />
		<property name="config" ref="config" />
		<property name="db" value="${mongodb.db}" />
	</bean>
	
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Code %}

{% highlight java %}

	ArchiveOperationHandler mongoArchiveHandler =
		new MongoArchiveOperationHandlerConfigurer()
		 .gigaSpace(gigaSpace)
		 .config(config)
		 .db("mydb")
		 .create();

	// To free the resources used by the archive container make sure you close it properly.
	// A good life cycle event to place the destroy() call would be within the @PreDestroy or 	DisposableBean#destroy() method.

	archiveContainer.destroy();

{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

#### MongoArchiveOperationHandler Properties

{: .table .table-bordered}
|Property|Description|
|:-------|:----------|
|gigaSpace| GigaSpace reference used for type descriptors. see [Archive Container](./archive-container.html#Configuration)|
|config | MongoClientConfiguration reference used to handle the mongodb driver configuration. see [MongoClient](http://api.mongodb.org/java/2.11.2/com/mongodb/MongoClient.html)|
|db | mongodb database name|


{%comment%}
## XSD Schema

- <os-archive:mongo-archive-handler> schema:

{% indent %}
![mongodb-archive-handler-schema-9-7-0.png](/attachment_files/mongodb-archive-handler-schema-9-7-0.png)
{% endindent %}
 {%endcomment%}