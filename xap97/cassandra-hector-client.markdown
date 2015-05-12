---
layout: post97
title:  Hector Client
categories: XAP97
parent: cassandra-space-persistency.html
weight: 300
---



A wrapper around the [Hector Library](http://hector-client.github.com/hector/build/html/index.html) used for communicating with Cassandra.

This component is used by both the [Cassandra Space Synchronization Endpoint](./cassandra-space-synchronization-endpoint.html) and the [Cassandra Space Data Source](./cassandra-space-data-source.html). The main usage is related to metadata operations (such as creating column families, adding secondary indexes, reading column families metadata, etc...).

# Configuration

## Library Dependencies

See [Hector library dependencies](./cassandra-space-synchronization-endpoint.html#Library dependencies) for required dependencies.

## Setup

{% inittab Configuration Examples %}
{% tabcontent Spring %}

{% highlight xml %}
<bean id="hectorClient"
    class="org.openspaces.persistency.cassandra.HectorCassandraClientFactoryBean">

    <!-- comma separated seed list -->
    <property name="hosts" value="${cassandra.host}" />

    <!-- cassandra rpc communication port -->
    <property name="port" value="${cassandra.port}" />

    <!-- keyspace name to work with -->
    <property name="keyspaceName" value="${cassandra.keyspace}" />

</bean>
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Code %}

{% highlight java %}
HectorCassandraClient hectorClient = new HectorCassandraClientConfigurer()
    .hosts(cassandraHosts)
    .port(cassandraPort)
    .keyspaceName(cassandraKeyspaceName)
    .create();
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

## `HectorCassandraClient` Properties

{: .table .table-bordered}
|Property|Description|Default|
|:-------|:----------|:------|
|hosts|A comma separated list of seeds in the Cassandra cluster| |
|port|The rpc port for Cassandra client communication|9160|
|keyspaceName|The name of the keyspace to work with| |
|clusterName|If there is need to connect to more than one Cassandra cluster within the same JVM, each cluster should be references by a different name.|cluster|
|readConsistencyLevel|The [CassandraConsistencyLevel](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/index.html?org/openspaces/persistency/cassandra/CassandraConsistencyLevel.html) in which read operations should be performed|QUORUM|
|writeConsistencyLevel|The [CassandraConsistencyLevel](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/index.html?org/openspaces/persistency/cassandra/CassandraConsistencyLevel.html) in which write operations should be performed|QUORUM|
|columnFamilyGcGraceSeconds|See [Distributed deletes](http://wiki.apache.org/cassandra/DistributedDeletes) |10 Days (Derived from Cassandra's default value)|
