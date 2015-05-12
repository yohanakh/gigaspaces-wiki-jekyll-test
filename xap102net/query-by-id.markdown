---
layout: post102
title:  ID Queries
categories: XAP102NET
parent: querying-the-space.html
weight: 100
---

{%summary%}{%endsummary%}

The space can be queried for entries using [Template Matching](./query-template-matching.html) or [SQLQuery](./query-sql.html), but sometimes we know the exact id of the entry we need and prefer a faster solution. This is where id-based queries come handy.

# Reading an Entry By ID

When you would like to access an object using its ID for read and take operations you should first specify the ID field. You can specify it via `[SpaceId (autogenerate=false)]` annotation:

{% highlight csharp %}

[SpaceId (autoGenerate=false)]
public String getEmployeeID() {
    return employeeID;
}
{% endhighlight %}

To read the object back from the space using its ID and the `ReadById` operation:

{% highlight csharp %}
GigaSpace gigaSpace;
Employee myEmployee = proxy.ReadById<Employee>(myEmployeeID , routingValue);
{% endhighlight %}

# Reading Multiple Entries by IDs

The following shows how to read multiple objects using their IDs:

{% highlight csharp %}
GigaSpace gigaSpace;

// Initialize an ids array
long?[] ids = new long?[] { ... };

// Set a routing key value (not mandatory but more efficient)
Integer routingKey = ...;

// Read objects from space
ReadByIdsResult<Employee> result = proxy.ReadByIds<Employee>( ids, routingKey);

// Loop through results
for (Employee employee : result) {
  // ...
}

{% endhighlight %}

{% refer %}
See [Parent Child Relationship](/sbp/parent-child-relationship.html) for a full usage example of the `readByIds` operation.
ReadById is intended to objects with meaningful ids,if used with auto-generate="true" ids,the given object type will be ignored.
{% endrefer %}

