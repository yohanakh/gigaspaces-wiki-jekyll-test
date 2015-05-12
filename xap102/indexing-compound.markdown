---
layout: post102
title:  Compound Index
categories: XAP102
parent: indexing-overview.html
weight: 300
---

{%summary%}{%endsummary%}

Compound indexes can be defined using annotations. The `CompoundSpaceIndex` and `CompoundSpaceIndexes` annotations should be used. The annotations are a type-level annotations.

# Creating the   Index

Example: Below a compound index with two segments using annotations. Both are properties at the root level of the space class:

{% highlight java %}
@CompoundSpaceIndexes(
{ @CompoundSpaceIndex(paths = {"data1", "data2"}) }
)
@SpaceClass
public class Data {
	String id;
	String data1;
	String data2;
	// getter and setter methods - no properties need to be indexed
{% endhighlight %}

The benchmark has a space with different sets of space objects data:

{: .table .table-bordered .table-condensed}
|Condition|Scenario 1 matching objects|Scenario 2 matching objects|Scenario 3 matching objects|
|:--------|:--------------------------|:--------------------------|:--------------------------|
|data1 = 'A' |401,000| 410,000 | 400,000 |
|data2 = 'B' |100,000| 110,000 | 200,000 |
|data1 = 'A' AND data2 = 'B' |1000 | 10,000 | 100,000|

{% highlight java %}
SQLQuery<Data> query = new SQLQuery<Data>(Data.class,"data1='A' and data2='B'");
{% endhighlight %}

With the above scenario the Compound Index will improve the query execution dramatically. See below comparison for a query execution time when comparing a Compound Index to a single or two indexed properties space class with the different data set scenarios.

![compu_index_bench.jpg](/attachment_files/compu_index_bench.jpg)

# Using gs.xml

A Compound Index can be defined within the gs.xml configuration file. Example: The following a `gs.xml` describing a POJO named Data having a compound index composed from two segments:

{% highlight xml %}
<gigaspaces-mapping>
    <class name="Data" >
        <compound-index paths="data1, data2"/>
        ...
    </class>
</gigaspaces-mapping>
{% endhighlight %}

# Space Document

A Compound Space Index of a [space Document](./document-api.html) can be described by `pu.xml` configuration file. Example:

{% highlight xml %}
<os-core:embedded-space id="space" name="space" >
	<os-core:space-type type-name="Data">
		<os-core:compound-index paths="data1,data2"/>
	</os-core:space-type>
</os-core:embedded-space>
{% endhighlight %}

# Dynamic Creation

A Compound Space Index can be added dynamically using the `GigaSpaceTypeManager` interface. Example:

{% highlight java %}
AsyncFuture<AddTypeIndexesResult> indexesResultAsyncFuture = gigaSpace.getTypeManager()
	.asyncAddIndex("Data", new CompoundIndex (new String[]{"data1", "data2"}));
{% endhighlight %}

As the `CompoundIndex` is a subclass of the `SpaceIndex`, the `asyncAddIndex` method signature has not been changed.

# Considerations

1. An index segment cannot be a collection or a path within collection.
1. All compound index segments must have an `Object` `StorageType`.



<ul class="pager">
  <li class="previous"><a href="./indexing-collections.html">&larr;Collection Index</a></li>
  <li class="next"><a href="./indexing-unique.html">Unique Index &rarr;</a></li>
</ul>
