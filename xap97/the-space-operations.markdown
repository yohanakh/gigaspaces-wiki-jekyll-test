---
layout: post97
title:  Operations
categories: XAP97
weight: 200
parent: the-gigaspace-interface-overview.html
---


{% summary %}{%endsummary%}


XAP provides a simple space API using the [GigaSpace](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/org/openspaces/core/GigaSpace.html) interface for interacting with the space.


The interface includes the following main operations:

{%section%}
{%column width=50% %}
{%panel bgColor=white | title=Write objects into the space:%}
[write](#write) one object into the space{%wbr%}
[writeMultiple](#writeMultiple) objects into the space{%wbr%}
[asynchronous write](#asynchronousWrite) to the space
{%endpanel%}
{%endcolumn%}
{%column width=45% %}
{%panel bgColor=white | title=Change objects in space:%}
[change](./change-api.html) one object in space{%wbr%}
[changeMultiple](./change-api.html) objects in space {%wbr%}
[asynchronous change](./change-api.html) of objects
{%endpanel%}
{%endcolumn%}
{%endsection%}


{%section%}
{%column width=50% %}
{%panel bgColor=white |  title=Reading objects from the space:%}
[readById](#read) from the space{%wbr%}
[readByIds](#readMultiple) from the space{%wbr%}
[read](#read) object by template from the space{%wbr%}
[readMultiple](#readMultiple) objects from the space {%wbr%}
[read asynchronous](#asynchronousRead) from the space {%wbr%}
[read if exists](#readIfExists) {%wbr%}
[read if exists by id](#readIfExists)
{%endpanel%}
{%endcolumn%}
{%column width=45% %}
{%panel bgColor=white |  title=Removing objects from the space:%}
[take](#take) object by template from space{%wbr%}
[takeById](#take) object by id from space{%wbr%}
[takeByIds](#takeMultiple) objects by ids from space{%wbr%}
[takeMultiple](#takeMultiple) objects from space {%wbr%}
[take asynchronous](#asynchronousTake){%wbr%}
[take if exists](#takeIfExists){%wbr%}
[take if exists by id](#takeIfExists)
{%endpanel%}
{%endcolumn%}
{%endsection%}

{%section%}
{%column width=50% %}
{%panel bgColor=white |  title=Other operations:%}
[clear](#clear) an object type from space {%wbr%}
[count](#count) objects in space
{%endpanel%}
{%endcolumn%}
{%column width=45% %}
{%endcolumn%}
{%endsection%}

{%comment%}

{: .table .table-bordered}
|[Id Based operations](./id-queries.html)|[Batch operations](#Batch Operations)|[Asynchronous operations](#Asynchronous Operations)|Data Count operations|
|:--|:--|:--|:--|
|[readById](./id-queries.html#Reading an Object using its ID){% wbr %}takeById{% wbr %}[readByIds](./id-queries.html#Reading Multiple Objects using their IDs){% wbr %}takeByIds{% wbr %}readIfExistsById{% wbr %}takeIfExistsById|readMultiple{% wbr %}takeMultiple{% wbr %}[writeMultiple](#writeMultiple){% wbr %}readByIds{% wbr %}takeByIds|asyncRead{% wbr %}asyncTake{% wbr %}asyncChange{% wbr %}execute|count|

{: .table .table-bordered}
|[Data Query operations](./query-sql.html)|Data Insert and Update operations|[Business logic execution operations](./task-execution-over-the-space.html)|Data removal operations|
|:--|:--|:--|:--|
|read{% wbr %}readMultiple{% wbr %}[iterator](./query-paging-support.html)|write{% wbr %}writeMultiple{% wbr %}   [change](./change-api.html) |execute{% wbr %}executorBuilder|clean{% wbr %}clear{% wbr %}take{% wbr %}takeMultiple|

{%endcomment%}

# Simpler API

The `GigaSpace` interface provides a simpler space API by utilizing Java 5 generics, and allowing sensible defaults. Here are some examples of the space operations as defined within `GigaSpace`:

{% highlight java %}
public interface GigaSpace {
    <T> LeaseContext<T> write(T entry) throws DataAccessException;
    // ....
    <T> T read(ISpaceQuery<T> query, Object id)throws DataAccessException;
    // ......
    <T> T take(T template) throws DataAccessException;
    <T> T take(T template, long timeout) throws DataAccessException;
    // ......
}
{% endhighlight %}

In the example above, the take operation can be performed without specifying a timeout. The default take timeout is `0` (no wait), and can be overridden when configuring the `GigaSpace` factory. In a similar manner, the read timeout and write lease can be specified.




{% include /COM/xap97/ops-write.markdown %}
{% include /COM/xap97/ops-read.markdown %}
{% include /COM/xap97/ops-take.markdown %}
{% include /COM/xap97/ops-clear.markdown %}
{% include /COM/xap97/ops-count.markdown %}





