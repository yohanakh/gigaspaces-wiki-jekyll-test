---
layout: post101
title:  Class Annotations
categories: XAP101
parent: pojo-annotation-overview.html
weight: 100
---

{% summary %}{% endsummary %}



The [GigaSpaces API](./the-gigaspace-interface-overview.html) supports class level decorations with POJOs. These can be specified via annotations on the space class source itself  for all class instances.


{%wbr%}

# Persistence

{: .table   .table-condensed  .table-bordered}
|Syntax     | persist |
|Argument   | boolean          |
|Default    | false|
|Description| When a space is defined as persistent, a 'true' value for this annotation persists objects of this type. |

Example:

{%highlight java%}
@SpaceClass(persist=true)
public class Person {
//
}
{%endhighlight%}

{%learn%}./space-persistency.html{%endlearn%}


# Include Properties

{: .table   .table-condensed  .table-bordered}
|Syntax     | includeProperties|
|Argument   | [IncludeProperties](http://www.gigaspaces.com/docs/JavaDoc{%currentversion%}/com/gigaspaces/annotation/pojo/SpaceClass.IncludeProperties.html)      |
|Default    | IncludeProperties.IMPLICIT|
|Description| `IncludeProperties.IMPLICIT` takes into account all POJO fields -- even if a `get` method is not declared with a `@SpaceProperty` annotation, it is taken into account as a space field.`IncludeProperties.EXPLICIT` takes into account only the `get` methods which are declared with a `@SpaceProperty` annotation. |

Example:
{%highlight java%}
@SpaceClass(includeProperties=IncludeProperties.EXPLICIT)
public class Person {
  //
}
{%endhighlight%}


# FIFO Support

{: .table   .table-condensed  .table-bordered}
|Syntax     | fifoSupport |
|Argument   | [FifoSupport]({% javadoc com/gigaspaces/annotation/pojo/FifoSupport %})|
|Default    | FifoSupport.NOT_SET|
|Description| To enable FIFO operations, set this attribute to `FifoSupport.OPERATION`|


Example:
{%highlight java%}
@SpaceClass(fifoSupport=FifoSupport.OPERATION)
public class Person {
  //
}
{%endhighlight%}

{%learn%}./fifo-support.html{%endlearn%}


# Inherit Index

{: .table   .table-condensed  .table-bordered}
|Syntax     | inheritIndexes |
|Argument   | boolean          |
|Default    | true|
|Description| Whether to use the class indexes list only, or to also include the superclass' indexes. {% wbr %}If the class does not define indexes, superclass indexes are used. {% wbr %}Options:{% wbr %}- `false` -- class indexes only.{% wbr %}- `true` -- class indexes and superclass indexes.|

Example:

{%highlight java%}
@SpaceClass(inheritIndexes=false)
public class Person {
  //
}
{%endhighlight%}

{%learn%}./indexing.html{%endlearn%}

# Storage Type

{: .table   .table-condensed  .table-bordered}
|Syntax     | storageType |
|Argument   | [StorageType]({% javadoc com/gigaspaces/metadata/StorageType %})          |
|Default    | StorageType.OBJECT |
|Description| To determine a default storage type for each non primitive property for which a (field level) storage type was not defined.|


Example:

{%highlight java%}
@SpaceClass(storageType=StorageType.BINARY)
public class Person {
  //
}
{%endhighlight%}

{%learn%}./storage-types---controlling-serialization.html{%endlearn%}

# Replication

{: .table   .table-condensed  .table-bordered}
|Syntax     | replicate |
|Argument   | boolean          |
|Default    | true|
|Description| When running in a partial replication mode, a **`false`** value for this property will not replicates all objects from this class type to the replica space or backup space.} |

Example:

{%highlight java%}
@SpaceClass(replicate=false)
public class Person {
  //
}
{%endhighlight%}



{%learn%}{%currentadmurl%}/replication.html{%endlearn%}


# Compound Index

{: .table   .table-condensed  .table-bordered}
|Syntax     | CompoundSpaceIndexes CompoundSpaceIndex paths  |
|Argument(s)| string          |
|Values     | attribute name(s)   |
|Description| Indexes can be defined for multiple attributes of a class  |


Example:
{%highlight java%}
@CompoundSpaceIndexes({ @CompoundSpaceIndex(paths = { "firstName", "lastName" }) })
@SpaceClass
public class User {
     private Long id;
     private String firstName;
     private String lastName;
     private Double balance;
     private Double creditLimit;
     private EAccountStatus status;
     private Address address;
     private String[] comment;
}

{%endhighlight%}

{%learn%}./indexing-compound.html{%endlearn%}

# Blob Store

{: .table   .table-condensed  .table-bordered}
|Syntax     | blobstoreEnabled  |
|Argument | boolean          |
|Default | true|
|Description| By default any Space Data Type is blobStore enabled. When decorating the space class with its meta data you may turn off the blobStore behavior using the @SpaceClass blobStore annotation or gs.xml blobStore tag.  |


Example:
{%highlight java%}
@SpaceClass(blobstoreEnabled = false)
public class Person {
    .......
}

{%endhighlight%}

{%learn%}{%currentadmurl%}/memoryxtend.html{%endlearn%}


