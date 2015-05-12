
{%anchor read%}

# The Read Operation
{%section%}
{%column width=60% %}

The  read operations query the space for an object that matches the criteria provided.
If a match is found, a copy of the matching object is returned.
If no match is found, null is returned. Passing a null reference as the template will match any object.
{%endcolumn%}
{%column width=35% %}
![write_return_prev-value.jpg](/attachment_files/POJO_read.jpg)
{%endcolumn%}
{%endsection%}

Any matching object can be returned. Successive read requests with the same template may or may not return equivalent objects, even if no intervening modifications have been made to the space.
Each invocation of `read` may return a new object even if the same object is matched in the space.
If you would like to read objects in the same order they have been written into the space you should perform the read objects in a [FIFO mode](./fifo-support.html).

{% note %}
The `Read` operation default timeout is `0`.
{% endnote %}

The read operation can be performed with the following options:

- Template matching
- By Id
- By IdQuery
- By SQLQuery

To learn more about the different options refer to [Querying the Space](./querying-the-space.html)

##### Examples:

The following example writes an `Employee` object into the space and reads it back from the space :

{% highlight csharp %}
Employee employee = new Employee("Last Name", 32);
employee.FirstName="first name";
spaceProxy.Write(employee);

// Read by template
Employee template = new Employee(32);
Employee e = spaceProxy.Read(template);

// Read by id
Employee e1 = spaceProxy.ReadById<Employee>(32);

// Read by IdQuery
IdQuery<Employee> query1 = new IdQuery<Employee>( 32);
Employee e2 = spaceProxy.Read<Employee>(query1);

// Read by SQLQuery
SqlQuery<Employee> query2 = new SqlQuery<Employee>("FirstName='first name'");
Employee e3 = spaceProxy.Read<Employee>(query2);

{% endhighlight %}


{%anchor readMultiple%}

#### Read multiple

{%section%}
{%column width=60% %}
The GigaSpace interface provides simple way to perform bulk read operations. You may read a large amount of objects in one call.
{%endcolumn%}
{%column width=35% %}
![write_return_prev-value.jpg](/attachment_files/POJO_read_multi.jpg)
{%endcolumn%}
{%endsection%}

##### Examples:

{% highlight csharp %}
Employee[] emps = new Employee[2];
emps[0] = new Employee("Last Name A", 31);
emps[1] = new Employee("Last Name B", 32);

spaceProxy.WriteMultiple(emps);

// Read multiple by template
Employee[] employees = spaceProxy.ReadMultiple<Employee>(new Employee());

// Read multiple by SQLQuery
SqlQuery<Employee> query = new SqlQuery<Employee>("LastName ='Last Name B'");
Employee[] e = spaceProxy.ReadMultiple<Employee>(query);

// Read by Ids
Object[] ids = new Object[] { 31, 32 };
IReadByIdsResult<Employee> result = spaceProxy.ReadByIds<Employee>(ids);
Employee[] e1 = result.ResultsArray;

// Read by IdsQuery
Object[] ids1 = new Object[] { 31, 32 };
IdsQuery<Employee> query2 = new IdsQuery<Employee>(ids1);
IReadByIdsResult<Employee> result2 = spaceProxy.ReadByIds<Employee>(query2);
Employee[] employees2 = result.ResultsArray;
{% endhighlight %}

{%note title=Here are few important considerations when using the batch operation: %}
- boosts the performance, since it perform multiple operations using one call. These methods returns the matching results in one result object back to the client. This allows the client and server to utilize the network bandwidth in an efficient manner. In some cases, these batch operations can be up to 10 times faster than multiple single based operations.
- should be handled with care, since they can return a large data set (potentially all the space data). This might cause an out of memory error in the space and client process. You should use the [GSIterator](#Space Iterator) to return the result in batches (paging) in such cases.
- **dos not support timeout** operations. The simple way to achieve this is by calling the `Read` operation first with the proper timeout, and if non-null values are returned, perform the batch operation.
- Exception handling - operation many throw the following Exceptions. [ReadMultipleException](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/Overload_GigaSpaces_Core_Exceptions_ReadMultipleException__ctor.htm)
{%endnote%}

{%anchor readIfExists%}

#### Read if exists
A readIfExists operation will return a matching object, or a null if there is currently no matching object in the space.
If the only possible matches for the template have conflicting locks from one or more other transactions, the timeout value specifies how long the client is willing to wait for interfering transactions to settle before returning a value.
If at the end of that time no value can be returned that would not interfere with transactional state, null is returned. Note that, due to the remote nature of the space, read and readIfExists may throw a RemoteException if the network or server fails prior to the timeout expiration.

##### Example:

{% highlight csharp %}
Employee employee = new Employee("Last Name", 32);
employee.FirstName="first name";
spaceProxy.Write(employee);

SqlQuery<Employee> query = new SqlQuery<Employee>("FirstName='first name'");
Employee e = spaceProxy.ReadIfExists<Employee>(query);
{% endhighlight %}




{%anchor asynchronousRead%}

#### Asynchronous Read

The GigaSpace interface supports asynchronous (non-blocking) read operations through the ISpaceProxy interface. It is implemented via a call back listener.

##### Example:

{% highlight csharp %}

private void ReadListener (IAsyncResult<Employee> asyncResult)
{
    Employee result = spaceProxy.EndRead (asyncResult);
}

public void asyncRead ()
{
    spaceProxy.BeginRead<Employee> (new SqlQuery<Employee> ("Id=1"), ReadListener, null);
}
{% endhighlight %}




#### Modifiers

The read operations can be configured with different modifiers.

##### Examples:
{%highlight csharp%}
Employee template = new Employee();

// Read objects in a FIFO mode
Employee e = spaceProxy.Read<Employee>(template, null, 0, ReadModifiers.Fifo);

// Dirty read
Employee e1 = spaceProxy.Read<Employee>(template, null, 0, ReadModifiers.DirtyRead);
{%endhighlight%}


For further details on each of the available modifiers see: [ReadModifiers](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/P_GigaSpaces_Core_IReadOnlySpaceProxy_ReadModifiers.htm)


{% togglecloak id=os-read %}**Method summary...**{% endtogglecloak %}
{% gcloak os-read %}

Read by template:{%netapi%}http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/Overload_GigaSpaces_Core_IReadOnlySpaceProxy_Read.htm{%endnetapi%}
{%highlight csharp%}
T Read(T template);
T Read(T template, long timeout, ReadModifiers modifiers);
.....
{%endhighlight%}

Read by Id:{%netapi%}http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/Overload_GigaSpaces_Core_IReadOnlySpaceProxy_ReadById.htm{%endnetapi%}
{%highlight csharp%}
T ReadById<T>(Object id);
T ReadById<T>(Object id,Object routing,ITransaction tx,long timeout);
.....
{%endhighlight%}

Read by ISpaceQuery:{%netapi%}http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/Overload_GigaSpaces_Core_IReadOnlySpaceProxy_Read.htm{%endnetapi%}
{%highlight csharp%}
T Read(ISpaceQuery<T> query, Object id);
T Read(ISpaceQuery<T> query, Object routing, long timeout, ReadModifiers modifiers);
....
{%endhighlight%}

Read multiple:{%netapi%}http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/Overload_GigaSpaces_Core_IReadOnlySpaceProxy_ReadMultiple.htm{%endnetapi%}
{%highlight csharp%}
T[] ReadMultiple<T>(T template);
T[] ReadMultiple<T>(T template,ITransaction tx,int maxItems);
T[] ReadMultiple<T>(IQuery<T> query,ITransaction tx,int maxItems,ReadModifiers modifiers);
...
{%endhighlight%}


Asynchronous Read:{%netapi%}http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/Overload_GigaSpaces_Core_IReadOnlySpaceProxy_BeginRead.htm{%endnetapi%}
{%highlight csharp%}
IAsyncResult<T> BeginRead<T>(T template,AsyncCallback<T> userCallback, Object stateObject);
IAsyncResult<T> BeginRead<T>(T template,long timeout,AsyncCallback<T> userCallback,Object stateObject)
.....
{%endhighlight%}


Read if exists:{%netapi%}http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/Overload_GigaSpaces_Core_IReadOnlySpaceProxy_ReadIfExists.htm{%endnetapi%}
{%highlight csharp%}
T ReadIfExists<T>(T template);
T ReadIfExists<T>(T template,ITransaction tx);
T ReadIfExists<T>(T template,ITransaction tx,long timeout,ReadModifiers modifiers);
T ReadIfExists<T>(IQuery<T> query,ITransaction tx,long timeout);
....
{%endhighlight%}



{: .table .table-bordered}
| Modifier and Type | Description | Default | Unit|
|:-----|:------------|:--------|:----|
| T          | PONO, SpaceDocument|| |
|timeout     | Time to wait for the response| 0  |  milliseconds |
|query| [IQuery](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_IQuery_1.htm)|      | |
|[ReadModifiers](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/P_GigaSpaces_Core_IReadOnlySpaceProxy_ReadModifiers.htm)|Provides modifiers to customize the behavior of read operations | NONE  |  |

{%endgcloak%}