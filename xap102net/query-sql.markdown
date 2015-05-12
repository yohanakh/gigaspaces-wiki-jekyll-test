---
layout: post102
title:  SqlQuery
categories: XAP102NET
parent: querying-the-space.html
weight: 500
---

{%summary%}{%endsummary%}

The **`SqlQuery`** class is used to query the space using SQL-like syntax. This query can be passed as a template to the Read, Take, ReadMultiple, TakeMultiple, Count and Clear operations, as well as a template when registering for notification.


# Usage

An `SqlQuery` is composed from the **type** of entry to query, an **expression** in a SQL syntax and optionally one or more **parameters** which provide values for the expression.

#### Example 1

Read all entries of type **Person** whose **Age** is greater than or equal to **21**.

{% highlight csharp %}
Person[] persons = proxy.ReadMultiple<Person>(new SqlQuery<Person>("Age >= 21"));
{% endhighlight %}

Note that the expression is equivalent to the WHERE part of a query. The FROM part is derived from the generic argument of the `SqlQuery` class, and the SELECT part is not needed since the result is a fully-formed object.

#### Example 2

Read up to **100** entries of type **Person** whose **Age** is greater than or equal to **21**, AND whose **FirstName** is **John**.

{% highlight csharp %}
SqlQuery<Person> query = new SqlQuery<Person>("Age >= ? AND FirstName = ?");
query.SetParameter(1, 21);
query.SetParameter(2, "John");
Person[] persons = proxy.ReadMultiple<Person>(query, 100);
{% endhighlight %}

This time instead of specifying the values directly in the expression we've used question marks to denote expression variables and parameters to specify the values for those variables.

# Supported SQL Features

{%vbar title=SqlQuery supports the following:%}

- `AND` / `OR` operators to combine two or more conditions.
- All basic logical operations to create conditions: `=, <>, <,>, >=, <=, like, NOT like, is null, is NOT null, IN`.
- [Aggregate](./aggregators.html) functions: COUNT, MAX, MIN, SUM, AVG
- `BETWEEN` (starting 8.0.1)
- `ORDER BY (ASC | DESC)` for multiple PONO properties. Supported only by readMultiple. `ORDER BY` supports also nested object fields.
- `GROUP BY` - performs DISTINCT on the PONO properties. Supported only by readMultiple. `GROUP BY` supports also nested object fields.
- `sysdate` - current system date and time.
- `rownum` - limits the number of rows to select.
- Sub queries.
{%endvbar%}


# Indexing

It is highly recommended to use indexes on relevant properties to increase performance. For more information see [Indexing](./indexing.html).

# Blocking Operations

Blocking operations (i.e. `Read` or `Take` with `timeout` greater than `0`) are supported with the following restrictions:

- Blocking operations on a partitioned space require a routing value (broadcast is not supported). For more information see [Routing](#Routing).
- Blocking operations on complex queries are not supported. For more information see [Simple Queries](#SimpleQueries) definition.

{% highlight csharp %}
long timeout = 100000;
MyClass result = space.Take<MyClass>(new SqlQuery<MyClass>("Num > 500"), timeout);
{% endhighlight %}

# Routing

When running on a partitioned space, it is important to understand how routing is determined for SQL queries. Routing is how the partitioned space determines on which partition a given data element is stored.

If the routing property is part of the criteria expression with an equality operand and without ORs, its value is used for routing.

For example, suppose the routing property of **`MyClass`** is **`Num`**:

{% highlight csharp %}
// Execute query on partition #1
SqlQuery<MyClass> query1 = new SqlQuery<MyClass>("Num = 1");

// Execute query on all partitions -
// no way to tell which partitions hold matching results:
SqlQuery<MyClass> query2 = new SqlQuery<MyClass>("Num > 1");

// Execute query on all partitions -
// no way to tell which partitions hold matching results:
SqlQuery<MyClass> query3 = new SqlQuery<MyClass>("Num = 1 OR Name='smith'");
{% endhighlight %}

Note that in `query1` the `Num` property is used both for routing and matching.

In some scenarios we may want to execute the query on a specific partition without matching the routing property (e.g. blocking operation). Starting 8.0.1, this can be done via the `Routing` property:

{% highlight csharp %}
SqlQuery<MyClass> query = new SqlQuery<MyClass>("Num > 3");
query.Routing = 1;
MyClass[] result = space.ReadMultiple<MyClass>(query);
{% endhighlight %}


# Limitations

### Enums

Since Enums are stored in the space as their underlying primitive type, they must be explicitly cast to that primitive type to be used with SqlQuery.

{% anchor SimpleQueries %}

### Simple vs. Complex Queries

Most space operations and features support any SQL query, but some support only **simple** queries and not **complex** ones.

A query is considered complex if it contains one or more of the following:

- `NOT LIKE`
- `GROUP BY`
- `ORDER BY`
- Subqueries
- `OR` (before 8.0.1)

The following features support only simple SQL queries

- Snapshot
- Blocking operations
- Notifications
- SpaceIterator

### Unsupported SQL Features



{%vbar title=SqlQuery **does not** support the following:%}
- Multiple tables select.
- `DISTINCT`
- The SQL statements: VIEW, TRIGGERS, EXISTS, BETWEEN, NOT, CREATE USER, GRANT, REVOKE, SET PASSWORD, CONNECT USER, ON.
- Constraints: NOT NULL, IDENTITY, UNIQUE, PRIMARY KEY, Foreign Key/REFERENCES, NO ACTION, CASCADE, SET NULL, SET DEFAULT, CHECK.
- Set operations: Union, Minus, Union All.
- Advanced Aggregate Functions: STDEV, STDEVP, VAR, VARP, FIRST, LAST.
- Mathematical expressions.
- `LEFT OUTER JOIN`
- `RIGHT OUTER JOIN`
- `INNER JOIN`
{%endvbar%}

### Reserved Words



{%vbar title=The following are reserved keywords in the GigaSpaces SQL syntax:%}
ALTER ADD AND ASC BETWEEN BY CREATE CALL DROP DEFAULT_NULL DESC  DISTINCT END FROM GROUP IN IS LIKE
MAX MIN NOT NULL OR ORDER SELECT SUBSTR SUM SYSDATE UPPER WHERE COUNT DELETE EXCEPTION ROWNUM INDEX
INSERT INTO SET TABLE TO_CHAR TO_NUMBER FOR_UPDATE UPDATE UNION VALUES COMMIT ROLLBACK PRIMARY_KEY
UID USING
{%endvbar%}

### Reserved Separators and Operators:



{%vbar title=Reserved syntax:%}
:= || ; . ROWTYPE ~ < <= >  >= => != <> \(+\) ( ) \* / + - ? \{ \}
{%endvbar%}

