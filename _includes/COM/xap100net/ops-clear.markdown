
{%anchor clear%}

# The Clear Operation

{%section%}
{%column width=60% %}
You can use `ISpaceProxy.Clear` to remove objects from the space. When using the clear operation no object/objects are returned.
{%endcolumn%}
{%column width=35% %}
![POJO_clear.jpg](/attachment_files/POJO_clear.jpg)
{%endcolumn%}
{%endsection%}

Examples:

{% highlight csharp %}
    ISpaceProxy spaceProxy = GigaSpacesFactory.FindSpace(url);

    // Clear by Template
    Employee employee = new Employee ("Last Name", 32L);
    spaceProxy.Clear(employee);

    // Clear by SQLQuery
    String querystr	= "Age > 30";
    SqlQuery<Employee> query = new SqlQuery<Employee> (querystr);
    spaceProxy.Clear(query);

    // Clear by IdQuery
    IdQuery<Employee> query1 = new IdQuery<Employee> (32L);
    spaceProxy.Clear(query1);

    // Clear with Modifier
    SqlQuery<Employee> query2 = new SqlQuery<Employee> ("FirstName='first name'");
    spaceProxy.Clear(query2, null,TakeModifiers.EvictOnly);
{% endhighlight %}



{% togglecloak id=os-clear %}**Method summary...**{% endtogglecloak %}
{% gcloak os-clear %}

Clears objects from space.{%netapi%}http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_ISpaceProxy.htm{%endnetapi%}


{%highlight csharp%}
void Clear(T entry)
void Clear(T entry, ITransaction tx, TakeModifiers modifiers)
void Clear(ISpaceQuery<T> query)
......

{%endhighlight%}

{: .table .table-bordered}
| Modifier and Type | Description | default |
|:-----|:------------|:-------- |
|T          | PONO, SpaceDocument||
|query         | SqlQuery, IdQuery||
|[TakeModifiers](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_TakeModifiers.htm)|Provides modifiers to customize the behavior of the clear operations | NONE  |
{% endgcloak  %}


