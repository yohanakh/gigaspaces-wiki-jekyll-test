---
layout: post97
title:  Basic Index
categories: XAP97NET
parent: indexing-overview.html
weight: 50
---

{% summary %} {% endsummary %}



When a space is looking for a match for a read or take operation, it iterates over non-null values in the template, looking for matches in the space. This process can be time consuming, especially when there are many potential matches. To improve performance, it is possible to index one or more properties. The space maintains additional data for indexed properties, which shortens the time required to determine a match, thus improving performance.

# Choosing which Properties to Index

One might wonder why properties are not always indexed, or why all the properties in all the classes are not always indexed. The reason is that indexing has its downsides as well:

- An indexed property can speed up read/take operations, but might also slow down write/update operations.
- An indexed property consumes more resources, specifically memory footprint per entry.

# When to Use Indexing

Naturally the question arises of when to use indexing. Usually it is recommended to index properties that are used in common queries. However, in some scenarios one might favor less footprint, or faster performance for a specific query, and adding/removing an index should be considered.

{% warning %}  Remember that "Premature optimization is the root of all evil". It is always recommended to benchmark your code to get better results. {%endwarning%}

# Index Types

The index type is determined by the **`SpaceIndexType`** enumeration. The index types are:

**`NONE`** - No indexing is used.

**`BASIC`** - Basic index is used - this speeds up equality matches (equal to/not equal to).

**`EXTENDED`** - Extended index - this speeds up comparison matches (bigger than/less than).


# Indexing at Design-time

Specifying which properties of a class are indexed is done using attributes or `gs.xml`.

{% inittab %}

{% tabcontent Annotations %}

{% highlight csharp %}
[SpaceClass]
public class Person
{
    ...
    [SpaceIndex(Type=SpaceIndexType.Basic)]
    public String FirstName{ get; set;}

    [SpaceIndex(Type=SpaceIndexType.Basic)]
    public String LastName{ get; set; }

    [SpaceIndex(Type=SpaceIndexType.Extended)]
    public int? Age{ get; set; }
}
{% endhighlight %}

{% endtabcontent %}

{% tabcontent XML %}

{% highlight xml %}
<gigaspaces-mapping>
    <class name="Gigaspaces.Examples.Person"
        persist="false" replicate="false" fifo="false" >
        <property name="lastName">
            <index type="BASIC"/>
        </property>
        <property name="firstName">
            <index type="BASIC"/>
        </property>
        <property name="age">
             <index type="EXTENDED"/>
        </property>
    </class>
</gigaspaces-mapping>
{% endhighlight %}

{% endtabcontent %}

{% endinittab %}

## Inheritance

By default, a property's index is inherited in sub classes (i.e. if a property is indexed in a super class, it is also indexed in a sub class). If you need to change the index type of a property in a subclass you can override the property and annotate it with `[SpaceIndex]` using the requested index type (to disable indexing use `None`).

# Indexing at Run-time

Indexes can be added dynamically at run-time using the GigaSpaces Management Center GUI.

{% note %}
Removing an index or changing an index type is currently not supported.
{%endnote%}

{%comment%}

# Nested Properties Indexing

An index can be defined on a nested property to improve performance of nested queries - this is highly recommended.

Nested properties indexing uses an additional `[SpaceIndex]` attribute - **`Path`**.

## The `SpaceIndex.Path` Attribute

The **`Path`** attribute represents the path of the property within the nested object.

Below is an example of defining an index on a nested property:

{% inittab example|top %}

{% tabcontent Single Index Annotation %}

{% highlight csharp %}

[SpaceClass]
public class Person
{
    //Properties
    ...

    // this defines and Extended index on the PersonalInfo.SocialSecurity property
    [SpaceProperty(StorageType = StorageType.Document)]
    [SpaceIndex(Path = "SocialSecurity", Type = SpaceIndexType.Extended)]
    public Info PersonalInfo{ get; set; }

}

public class Info
{
    public String Name {get; set;}
    public Address Address {get; set;}
    public DateTime Birthday {get; set;}
    public long SocialSecurity {get; set;}
    public int Id;
}

public class Address
{
    private int ZipCode {get; set;}
    private String Street {get; set;}
}
{% endhighlight %}

{% endtabcontent %}

{% tabcontent Multiple Indexes Annotation %}

{% highlight csharp %}

[SpaceClass]
public class Person
{
    //Properties
    ...

    // this defines several indexes on the same personalInfo property
    [SpaceIndex(Path = "SocialSecurity", Type = SpaceIndexType.Extended)]
    [SpaceIndex(Path = "Address.ZipCode", type = SpaceIndexType.Basic)})
    [SpaceProperty(StorageType = StorageType.Document)]
    public Info PersonalInfo{ get; set; }

    // this defines indexes on map keys
    [SpaceIndex(Path = "Key1", Type = SpaceIndexType.Basic)]
    [SpaceIndex(Path = "Key2", Type = SpaceIndexType.Basic)]
    public Dictionary<String, String> Table{ get; set; }

}

{% endhighlight %}

{% endtabcontent %}

{% endinittab %}

The following is an example of query code that automatically triggers this index:

{% highlight csharp %}
SqlQuery<Person> query = new SqlQuery<Person>(
    "PersonalInfo.SocialSecurity<10000050L and PersonalInfo.SocialSecurity>=10000010L");
{% endhighlight %}


{% infosign %} For more information, see [Nested Object Queries](./query-sql.html#Nested Object Query)


{% info title=Nested Objects %}
By default, nested objects are kept in a binary form inside the space. In order to support nested matching, the relevant property should be stored as document, or as object if it is in an interoperability scenario and it has a corresponding Java class.
{% endinfo %}

{% info title=Dictionary based nested properties %}
Note that the same indexing techniques above are also applicable to Dictionary-based nested properties, which means that in the example above the `Info` and `Address` classes could be replaced with a `Dictionary<String,Object>`, with the dictionary keys representing the property names.
{% endinfo %}

# Collection Indexing

An index can be defined on a Collection property (such as List). Setting such an index means that each of the Collection's items is indexed.

Setting an index on a Collection is done using the SpaceIndex.Path attribute where a Collection property should be followed by "[*]".

The following example shows how to define an index on a List of Integers:

{% highlight csharp %}
[SpaceClass]
public class CollectionIndexingExample
{
  private Integer id;
  private List<int> numbers;

  // Getter and setter methods...

  // This means that each Integer in the List is indexed.
  [SpaceIndex(Path="[*]")]
  public List<int> Numbers { get; set; }

}
{% endhighlight %}

The following query shows how to take advantage of the defined index:

{% highlight csharp %}
SqlQuery<CollectionIndexingExample> sqlQuery =
    new SqlQuery<CollectionIndexingExample>("Numbers[*] = 30");
CollectionIndexingExample[] result = spaceProxy.ReadMultiple(sqlQuery);
{% endhighlight %}

### Nested property within a Collection

Its also possible to index a nested property within a collection.

The following example shows how to define an index on a Book.id property, which resides in a Collection property in Author:

{% highlight csharp %}
[SpaceClass]
public class Author
{

  // Properties...

  // This means that each Book.Id in the Collection is indexed.
  [SpaceIndex(Path = "[*].Id")]
  [SpaceProperty(StorageType = StorageType.Document)]
  public List<Book> Books{ get; set; }
}

public class Book
{

  // Properties...

  public int? Id{ get; set; }

}
{% endhighlight %}

The following query shows how to take advantage of the defined index:

{% highlight csharp %}
SqlQuery<Author> sqlQuery = new SqlQuery<Author>("Books[*].Id = 57");
Author result = spaceProxy.Read(sqlQuery);
{% endhighlight %}

Setting an index on a Collection within a nested property is also accepted:

{% highlight csharp %}
[SpaceClass]
public class Employee
{

  // Properties...

  [SpaceIndex(Path = "PhoneNumbers[*]")]
  [SpaceProperty(StorageType = StorageType.Document)]
  public Information Information{ get; set; }

}

public class Information
{

  // Properties...

  public List<String> PhoneNumbers{ get; set; }

}
{% endhighlight %}

{% info %}
Both [SpaceIndex(Type=SpaceIndexType.Basic)] and [SpaceIndex(Type=SpaceIndexType.Extended)] are supported.
{% endinfo %}

# Compound Indexing

A Compound Index is a space index composed from several properties or nested properties (aka paths). Each property of a compound index is called a segment and each segment is described by its path. The benefit of using a compound index is shorter scanning of potential matching entries - which is equivalent to the intersection of all the entries having the values described by the segments. In other words - when having a set of objects within the space where:?
Condition A : Field X = 10 - have a million matching objects. ?
Condition B : Field Y = 100 - have a million matching objects?
Condition C = Condition A AND Condition B = (Field X = 10 AND Field Y = 100) - have 10,000 matching objects

Using a Compound Index that will be based on field X and field Y will improve a query evaluating Condition C significantly.
An attribute can be a segment of several compound indexes, and can be indexed itself. Compound indexes can be only BASIC indices - they support equality based queries only. The name of the compound index is composed from the paths of its segments separated by a "+" sign.

Using a Compound Index that will be based on field X and field Y will improve a query evaluating **Condition C** significantly.

An attribute can be a segment of several compound indexes, and can be indexed itself. Compound indexes can be only `BASIC` indices - they support equality based queries only. The name of the compound index is composed from the paths of its segments separated by a "+" sign.

The benchmark has a space with different sets of space objects data:

{: .table .table-bordered}
|Condition|Scenario 1 matching objects|Scenario 2 matching objects|Scenario 3 matching objects|
|data1 = 'A' |401,000| 410,000 | 400,000 |
|data2 = 'B' |100,000| 110,000 | 200,000 |
|data1 = 'A' AND data2 = 'B' |1000 | 10,000 | 100,000|

{% highlight csharp %}
SQLQuery<Data> query = new SQLQuery<Data>(Data.class,"data1='A' and data2='B'");
{% endhighlight %}

With the above scenario the Compound Index will improve the query execution dramatically. See below comparison for a query execution time when comparing a Compound Index to a single or two indexed properties space class with the different data set scenarios.

![compu_index_bench.jpg](/attachment_files/dotnet/compu_index_bench.jpg)

## Creating a Compound Index using Annotation

Compound indexes can be defined using annotations. The `CompoundSpaceIndex` annotation should be used. The annotation is a type-level annotation.

Example: Below a compound index with two segments using annotations. Both are properties at the root level of the space class:

{% highlight csharp %}
[CompoundSpaceIndex(Paths = new[] {"IntProp", "StringProp"})]
[CompoundSpaceIndex(Paths = new[] {"LongProp", "StringProp" })]
public class WithCompoundIndex
{
[SpaceID(AutoGenerate = true)]
     public String Id { get; set; }
     public int IntProp { get; set; }
     public String StringProp { get; set; }
     public long LongProp { get; set; }
}
{% endhighlight %}

## Creating a Compound Index using gs.xml

A Compound Index can be defined within the gs.xml configuration file. Example: The following a gs.xml describing a Class named WithCompoundIndex having a compound index composed from two segments:

{% highlight xml %}
<!DOCTYPE gigaspaces-mapping PUBLIC "-//GIGASPACES//DTD GS//EN" "http://www.gigaspaces.com/dtd/9_5/gigaspaces-metadata.dtd">
<gigaspaces-mapping>
    <class name="WithCompoundIndex" >
        <compound-index paths="IntProp, StringProp"/>
        ...
    </class>
</gigaspaces-mapping>
{% endhighlight %}

## Creating a Compound Indexing for a Space Document

You can add a Compound Space Index to a space Document.

Example:

{% highlight xml %}
SpaceTypeDescriptorBuilder descriptorBuilder = new SpaceTypeDescriptorBuilder("WithCompoundIndex");
            descriptorBuilder.AddFixedProperty("IntProp", typeof(int));
            descriptorBuilder.AddFixedProperty("StringProp", typeof(String));
            descriptorBuilder.AddFixedProperty("LongProp", typeof(long));
            descriptorBuilder.AddCompoundIndex(new []{ "IntProp", "StringProp" });
            descriptorBuilder.AddCompoundIndex(new []{ "LongProp", "StringProp" });
{% endhighlight %}

# Query Execution Flow

When a read, take, read multiple, or take multiple call is performed, a template is used to locate matching space objects. The template might have multiple field values - some might include values and some might not (i.e. `null` field values acting as wildcard). The fields that do not include values are ignored during the matching process. In addition, some class fields might be indexed and some might not be indexed.

When multiple class fields are indexed, the space looks for the field value index that includes the smallest amount of matching space objects with the corresponding template field value as the index key.

The smallest set of space objects is the list of objects to perform the matching against (matching candidates). Once the candidates space object list has been constructed, it is scanned to locate space objects that fully match the given template - i.e. all non-null template fields match the corresponding space object fields.

{% infosign %} Class fields that are not indexed are not used to construct the candidates list.
{%endcomment%}

