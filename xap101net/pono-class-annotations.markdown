---
layout: post101
title:  Class Annotations
categories: XAP101NET
parent: pono-annotation-overview.html
weight: 100
---

{% summary %}{% endsummary %}



The [GigaSpaces API](./the-gigaspace-interface-overview.html) supports class level decorations with PONOs. These can be specified via annotations on the space class source itself  for all class instances.


{%wbr%}

# Alias name

{: .table   .table-condensed  .table-bordered}
|Syntax     | AliasName |
|Argument   | String          |
|Description| By default, the name of the class in the Space is the fully-qualified class name (i.e. including namespace). In some cases, usually in interoperability scenarios, you may need to map your C# Class name and properties to different names in the Space.  |

Example:

{%highlight csharp%}
[SpaceClass(AliasName="com.mycompany.myproject.Person")]
public class Person {
//
}
{%endhighlight%}

{%learn%}./interoperability.html{%endlearn%}

# Persistence

{: .table   .table-condensed  .table-bordered}
|Syntax     | Persist|
|Argument   | boolean          |
|Default    | false|
|Description| When a Space is defined as persistent, a 'true' value for this annotation persists objects of this type. |

Example:

{%highlight csharp%}
[SpaceClass(Persist=true)]
public class Person {
//
}
{%endhighlight%}

{%learn%}./space-persistency.html{%endlearn%}


# Include Properties

{: .table   .table-condensed  .table-bordered}
|Syntax     | IncludeFields, IncludeProperties |
|Argument   | [IncludeMembers](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_Metadata_IncludeMembers.htm)      |
|Default    | IncludeFields=IncludeMembers.All, IncludeProperties=IncludeMembers.All)|
|Description|  By default, all public members (fields and properties) in a class are stored in the space, whereas non-public members are ignored. Since classes are usually designed with private/protected fields and public properties wrapping them, in most cases the default behavior is also the desired one.|

Example:
{%highlight csharp%}
[SpaceClass(IncludeFields=IncludeMembers.Public, IncludeProperties=IncludeMembers.Public)]
public class Person {
  //
}
{%endhighlight%}

{%note title=Different Accessor for Properties%}
Starting with .NET v2.0, properties can have different accessors for getters and setters (e.g. public getter and private setter). In such cases, if either the getter or the setter is public, the space treats the property as public (i.e. IncludeProperties=IncludeMembers.Public means that this property is stored).
{%endnote%}

{%note title=Read-Only Properties %}
Read-only properties (getter without setter) are stored in the space, but when the object is de-serialized, the value is not restored, since there is no setter. This enables the space to be queried using such properties. There are two common scenarios for read-only properties:

- Calculated value – the property returns a calculated value based on other properties. This isn’t a problem since no data is lost due to the ‘missing’ setter.
- Access protection – the class designer wishes to protect the property from outside changes. This is probably a problem since the field value is lost. To prevent this problem, consider adding a private setter, or excluding the property and including the field (as explained next).

{%endnote%}

# FIFO Support

{: .table   .table-condensed  .table-bordered}
|Syntax     | FifoSupport |
|Argument   | [FifoSupport](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_Metadata_FifoSupport.htm)|
|Default    | FifoSupport.Off|
|Description| To enable FIFO operations, set this attribute to `FifoSupport.Operation`|


Example:
{%highlight csharp%}
[SpaceClass(FifoSupport=FifoSupport.Operation)]
public class Person {
  //
}
{%endhighlight%}

{%learn%}./fifo-support.html{%endlearn%}


# Inherit Index

{: .table   .table-condensed  .table-bordered}
|Syntax     | InheritIndexes |
|Argument   | boolean          |
|Default    | true|
|Description| Whether to use the class indexes list only, or to also include the superclass' indexes. {% wbr %}If the class does not define indexes, superclass indexes are used. {% wbr %}Options:{% wbr %}- `false` -- class indexes only.{% wbr %}- `true` -- class indexes and superclass indexes.|

Example:

{%highlight csharp%}
[SpaceClass(InheritIndexes=false)]
public class Person {
  //
}
{%endhighlight%}

{%learn%}./indexing.html{%endlearn%}


# Replication

{: .table   .table-condensed  .table-bordered}
|Syntax     | Replicate |
|Argument   | boolean          |
|Default    | true|
|Description| When running in a partial replication mode, a **`false`** value for this property will not replicates all objects from this class type to the replica space or backup space.} |

Example:

{%highlight csharp%}
[SpaceClass(Replicate=false)]
public class Person {
  //
}
{%endhighlight%}



{%learn%}{%currentadmurl%}/replication.html{%endlearn%}


# Compound Index

{: .table   .table-condensed  .table-bordered}
|Syntax     | CompoundSpaceIndex Paths  |
|Argument(s)| string          |
|Values     | attribute name(s)   |
|Description| Indexes can be defined for multiple properties of a class  |


Example:
{%highlight csharp%}
[CompoundSpaceIndex(Paths = new[] {"FirstName", "LastName"})]
[SpaceClass]
public class User {
     ....
     public String FirstName;
     public String LastName;

}

{%endhighlight%}

{%learn%}./indexing-compound.html{%endlearn%}

