
{%anchor take%}

# The Take Operation
{%section%}
{%column width=60% %}

The `take` operations behave exactly like the corresponding `read` operations, except that the matching object is **removed from the space on one atomic operation. Two `take` operations will never return** copies of the same object, although if two equivalent objects were in the space the two `take` operations could return equivalent objects.

{%endcolumn%}
{%column width=35% %}
![write_return_prev-value.jpg](/attachment_files/POJO_take.png)
{%endcolumn%}
{%endsection%}


If a `take` returns a non-null value, the object has been removed from the space, possibly within a transaction. This modifies the claims to once-only retrieval: A take is considered to be successful only if all enclosing transactions commit successfully.
If an `UnusableEntryException` is thrown, the take `removed` the unusable object from the space.
If any other exception is thrown, the take did not occur, and no object was removed from the space.

With a `RemoteException`, an object can be removed from a space and yet never returned to the client that performed the take, thus losing the object in between.
In circumstances in which this is unacceptable, the take can be wrapped inside a transaction that is committed by the client when it has the requested object in hand.


{%note%}
If you would like to take objects from the space in the same order they have been written into the space you should perform the take objects in a [FIFO mode](./fifo-support.html).

Taking an object from the space might generate [notifications](./notify-container.html) to registered objects/queries.
{%endnote%}

The take operation can be performed with the following options:

- Template matching
- By Id
- By IdQuery
- By SQLQuery

To learn more about the different options refer to [Querying the Space](./querying-the-space.html)

##### Examples:

The following example writes an `Employee` object into the space and removes it from the space :

{% highlight csharp %}
Employee employee = new Employee("Last Name", 32);
employee.FirstName="first name";
spaceProxy.Write(employee);

// Take by template
Employee template = new Employee(32);
Employee e = spaceProxy.Take<Employee>(template);

// Take by id
Employee e1 = spaceProxy.TakeById<Employee>(32);

// Take by IdQuery
IdQuery<Employee> query = new IdQuery<Employee>(32);
Employee e2 = spaceProxy.Take<Employee>(query);

// Take by SQLQuery
SqlQuery<Employee> query1 = new SqlQuery<Employee>("FirstName='first name'");
Employee e3 = spaceProxy.Take<Employee>(query);

{% endhighlight %}


{%anchor takeMultiple%}

#### Take multiple

{%section%}
{%column width=55% %}
The GigaSpace interface provides simple way to perform bulk take operations. You may take large amount of objects in one call.
{%endcolumn%}
{%column width=40% %}
![write_return_prev-value.jpg](/attachment_files/POJO_take_multi.png)
{%endcolumn%}
{%endsection%}

{% info %}
To remove a batch of objects without returning these back into the client use `ISPaceProxy.Clear(SqlQuery)`;
{%endinfo%}

##### Examples:

{% highlight csharp %}
Employee[] emps = new Employee[2];
emps[0] = new Employee("Last Name A",  31);
emps[1] = new Employee("Last Name B",  32);

spaceProxy.WriteMultiple(emps);

// Take multiple by template
Employee[] employees = spaceProxy.TakeMultiple<Employee>(new Employee());

// Take multiple by SQLQuery
SqlQuery<Employee> query = new SqlQuery<Employee>("LastName ='Last Name B'");
Employee[] e = spaceProxy.TakeMultiple<Employee>(query);

// Take by Ids
Object[] ids = new Object[] { 31, 32 };
ITakeByIdsResult<Employee> result = spaceProxy.TakeByIds<Employee>(ids);
Employee[] e1 = result.ResultsArray;

// Take by IdsQuery
Object[] ids1 = new Object[] { 31, 32 };
IdsQuery<Employee> query1 = new IdsQuery<Employee>(ids1);
ITakeByIdsResult<Employee> result1 = spaceProxy.TakeByIds(query1);
Employee[] employees1 = result1.ResultsArray;
{% endhighlight %}

{%note title=Here are few important considerations when using the batch operation: %}
-  boosts the performance, since it performs multiple operations using one call. This method returns the matching results in one result object back to the client. This allows the client and server to utilize the network bandwidth in an efficient manner. In some cases, this batch operation can be up to 10 times faster than multiple single based operations.
-  should be handled with care, since it can return a large data set (potentially all the space data). This might cause an out of memory error in the space and client process. You should use the [GSIterator](#Space Iterator) to return the result in batches (paging) in such cases.
-  should be performed with transactions - this allows the client to roll back the space to its initial state prior the operation was started, in case of a failure.
-  operation **dos not support timeout** operations. The simple way to achieve this is by calling the `Read` operation first with the proper timeout, and if non-null values are returned, perform the batch operation.

{%comment%}
-  in the event of a take error, DataAccessException will wrap a TakeMultipleException, accessible via DataAccessException.getRootCause().  [TakeMultipleException](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_Exceptions_TakeMultipleException.htm)
{%endcomment%}

{%endnote%}

{%anchor takeIfExists%}

#### Take if exists
A takeIfExists operation will return a matching object, or a null if there is currently no matching object in the space.
If the only possible matches for the template have conflicting locks from one or more other transactions, the timeout value specifies how long the client is willing to wait for interfering transactions to settle before returning a value.
If at the end of that time no value can be returned that would not interfere with transactional state, null is returned.

##### Example:

{% highlight csharp %}
Employee employee = new Employee("Last Name",  32);
employee.FirstName="first name";
spaceProxy.Write(employee);

SqlQuery<Employee> query = new SqlQuery<Employee>("FirstName='first name'");
Employee e = spaceProxy.TakeIfExists<Employee>(query);
{% endhighlight %}



{%anchor asynchronousTake%}

#### Asynchronous Take

The GigaSpace interface supports asynchronous (non-blocking) take operations through the ISpaceProxy interface. It is implemented via a call back listener.

##### Example:

{% highlight csharp %}

private void TakeListener (IAsyncResult<Employee> asyncResult)
{
    Employee result = spaceProxy.EndTake (asyncResult);
}

public void asyncTake ()
{
    spaceProxy.BeginTake<Employee> (new SqlQuery<Employee> ("Id=1"), TakeListener, null);
}
{% endhighlight %}



#### Modifiers

The take operations can be configured with different modifiers.

##### Examples:
{%highlight csharp%}
Employee template = new Employee();

// Takes objects in a FIFO mode
Employee e = spaceProxy.Take<Employee>(template, null, 0, TakeModifiers.Fifo);

// Takes objects according to FIFO group without transactions
Employee e1 = spaceProxy.Take<Employee>(template, null, 0, TakeModifiers.FifoGroupingPoll);
{%endhighlight%}


For further details on each of the available modifiers see: [TakeModifiers](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/P_GigaSpaces_Core_ISpaceProxy_TakeModifiers.htm)


{% togglecloak id=os-take %}**Method summary...**{% endtogglecloak %}
{% gcloak os-take %}

Take by template:{%netapi%}http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/Overload_GigaSpaces_Core_ISpaceProxy_Take.htm{%endnetapi%}
{%highlight csharp%}
T take<T>(T template);
T take<T>(T template, long timeout, TakeModifiers modifiers);
.....
{%endhighlight%}

Take by Id:{%netapi%}http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/Overload_GigaSpaces_Core_ISpaceProxy_TakeById.htm{%endnetapi%}
{%highlight csharp%}
T TakeById<T>(Object id);
T TakeById<T>(Object id, Object routing, long timeout, TakeModifiers modifiers);
.....
{%endhighlight%}

Take by Id's:{%netapi%}http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/Overload_GigaSpaces_Core_ISpaceProxy_TakeByIds.htm{%endnetapi%}
{%highlight csharp%}
ITakeByIdsResult<T> TakeByIds<T>(IdsQuery<T> idsQuery,ITransaction tx);
ITakeByIdsResult<T> TakeByIds<T>(Object[] ids,Object routingKey,ITransaction tx,TakeModifiers modifiers);
.....
{%endhighlight%}


Take multiple:{%netapi%}http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/Overload_GigaSpaces_Core_ISpaceProxy_TakeMultiple.htm{%endnetapi%}
{%highlight csharp%}
T[] TakeMultiple<T>(T template);
T[] TakeMultiple<T>(IQuery<T> query,ITransaction tx,int maxItems,TakeModifiers modifiers);
T[] TakeMultiple<T>(T template,int maxItems);
...
{%endhighlight%}


Asynchronous take:{%netapi%}http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/Overload_GigaSpaces_Core_ISpaceProxy_BeginTake.htm{%endnetapi%}
{%highlight csharp%}
IAsyncResult<T> BeginTake<T>(IQuery<T> query,AsyncCallback<T> userCallback,Object stateObject);
IAsyncResult<T> BeginTake<T>(T template,long timeout,AsyncCallback<T> userCallback,Object stateObject);
)
.....
{%endhighlight%}


Take if exists:{%netapi%}http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/Overload_GigaSpaces_Core_ISpaceProxy_TakeIfExists.htm{%endnetapi%}
{%highlight csharp%}
T TakeIfExists<T>(T template);
T TakeIfExists<T>(IQuery<T> query,ITransaction tx,long timeout,TakeModifiers modifiers);
.....

{%endhighlight%}

Take by id if exists:{%netapi%}http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/Overload_GigaSpaces_Core_ISpaceProxy_TakeIfExistsById.htm{%endnetapi%}
{%highlight csharp%}
Object TakeIfExistsById(Type type,Object id);
T TakeIfExistsById<T>(IdQuery<T> idQuery,ITransaction tx,long timeout,TakeModifiers modifiers);
....
{%endhighlight%}

{: .table .table-bordered}
| Modifier and Type | Description | Default | Unit|
|:-----|:------------|:--------|:----|
| T          | PONO, SpaceDocument|| |
|timeout     | Time to wait for the response| 0  |  milliseconds |
|query| [IQuery](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_IQuery_1.htm)|      | |
|[TakeModifiers](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/P_GigaSpaces_Core_ISpaceProxy_TakeModifiers.htm)|Provides modifiers to customize the behavior of take operations | NONE  |  |
|[ITakeByIdsResult](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_IQuery_1.htm)|ResultSet||
{%endgcloak%}