
{%anchor count%}

# The Count Operation


You can use `ISpaceProxy.Count` to count objects in a space.


Examples:

{% highlight csharp %}
    ISpaceProxy spaceProxy = GigaSpacesFactory.FindSpace (url);

    // Count with Template
    Employee employee = new Employee ("Last Name");
    int counter = spaceProxy.Count(employee);

    // Count with SQLQuery
    String querystr	= "Age > 30";
    SqlQuery<Employee> query = new SqlQuery<Employee>( querystr);
    int count1 = spaceProxy.Count(query);

    // Count with IdsQuery
    Object[] ids = new object[] { 32, 33, 34 };
    IdsQuery<Employee> query1 = new IdsQuery<Employee>(ids);
    int count2 = spaceProxy.Count(query1);
{% endhighlight %}



{% togglecloak id=os-count %}**Method summary...**{% endtogglecloak %}
{% gcloak os-count %}

Count objects in space.{%netapi%}http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/Overload_GigaSpaces_Core_IReadOnlySpaceProxy_Count.htm{%endnetapi%}

{%highlight java%}
int Count(T entry);
int Count(T entry, ClearModifiers modifiers);
int Count(ISpaceQuery<T> query);
......

{%endhighlight%}

{: .table .table-bordered}
| Modifier and Type | Description | default |
|:-----|:------------|:-------- |
|T          | PONO, SpaceDocument||
|query         | SqlQuery, IdQuery||
|[ReadModifiers](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/P_GigaSpaces_Core_IReadOnlySpaceProxy_ReadModifiers.htm)|Provides modifiers to customize the behavior of the count operations | NONE  |
{% endgcloak  %}


