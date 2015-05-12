---
layout: post100
title:  Property Annotations
categories: XAP100NET
parent: pono-annotation-overview.html
weight: 200
---

{% summary %}{% endsummary %}



The [GigaSpaces API](./the-gigaspace-interface-overview.html) supports  field-level decorations with PONOs. These can be specified via annotations on the space class source itself. The annotations are defined on the getter methods.







# SpaceId

{: .table   .table-condensed  .table-bordered}
|Syntax     | SpaceId AutoGenerate|
|Argument   | boolean          |
|Default    | false |
|Description| Defines whether this field value is used when generating the Object ID. The field value should be unique -- i.e., no multiple objects with the same value should be written into the space (each object should have a different field value). When writing an object into the space with an existing `id` field value, an `EntryAlreadyInSpaceException` is thrown. The Object ID is created, based on the `id` field value.{%wbr%}Specifies if the object ID is generated automatically by the space when written into the space. If `false`, the field is indexed automatically, and if `true`, the field isn't indexed. If `autoGenerate` is declared as `false`, the field is indexed automatically. If `autoGenerate` is declared as `true`, the field isn't indexed. If `AutoGenerate` is `true`, the field must be of the type `String`. |

Example:

{%highlight csharp%}
[SpaceClass]
public class Person {

  [SpaceId(AutoGenerate=false)]
  public long? Id {set; get;}

}
{%endhighlight%}

{%learn%}./poco-object-id.html{%endlearn%}


# SpaceRouting

{: .table   .table-condensed  .table-bordered}
|Syntax     | SpaceRouting|
|Description| The `[SpaceRouting]` annotation specifies a get method for the field to be used to calculate the target space for the space operation (Read , Write...). The `[SpaceRouting]` field value hash code is used to calculate the target space when the space is running in **partitioned mode**.{%wbr%}The field value hash code is used to calculate the target space when the space is running in **partitioned mode**. |

Example:

{%highlight csharp%}
[SpaceClass]
public class Employee {

  [SpaceId]
  [SpaceRouting]
  public long DepartmentId {set; get}

}
{%endhighlight%}

{%learn%}{%currentadmurl%}/data-partitioning.html{%endlearn%}


# SpaceProperty

{: .table   .table-condensed  .table-bordered}
|Syntax     | SpaceProperty NullValue  |
|Argument   |  nullValue          |
|Default    |  null |
|Description| Specifies that a property value be treated as `null` when the object is written to the space and no value is assigned to the attribute. (where `-1` functions as a `null` value in case of an int)|


Example:

{%highlight csharp%}
[SpaceClass]
public class Employee {

  [SpaceProperty(NullValue="-1")]
  public int Age {set; get;}
}
{%endhighlight%}
 }

# SpaceIndex

{: .table   .table-condensed  .table-bordered}
|Syntax     |  SpaceIndex Type|
|Argument   |  [SpaceIndexType](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_Metadata_SpaceIndexType.htm)  |
|Description| Querying indexed fields speeds up read and take operations. The `[SpaceIndex]` annotation should be used to specify an indexed field.|

Example:

{%highlight csharp%}
[SpaceClass]
public class User {
	[SpaceIndex(Type = SpaceIndexType.Basic)]
	public String Name {set; get;}

	[SpaceIndex(Type = SpaceIndexType.Extended)]
	public double Balance{set; get;}
}
{%endhighlight%}


{%learn%}./indexing.html{%endlearn%}

# Unique Index

{: .table   .table-condensed  .table-bordered}
|Syntax     |  SpaceIndex Type, Unique|
|Argument   | [SpaceIndexType](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_Metadata_SpaceIndexType.htm)  |
|Description| Unique constraints can be defined for an attribute or attributes of a space class. |
|Note |   The uniqueness is enforced per partition and not over the whole cluster. |

Example:

{%highlight csharp%}
[SpaceClass]
public class Person
{
    [SpaceIndex(Type=SpaceIndexType.Basic, Unique=true)]
    public String LastName{ get; set; }

}
{%endhighlight%}


{%learn%}./indexing.html{%endlearn%}

# SpaceIndex Path

{: .table   .table-condensed  .table-bordered}
|Syntax     |  SpaceIndex Path ,Type|
|Argument   |  [SpaceIndexType](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_Metadata_SpaceIndexType.htm)|
|Description| The `path()` attribute represents the path of the indexed property within a nested object. |

Example:

{%highlight csharp%}
[SpaceClass]
public class Person {

   [SpaceIndex(Path = "SocialSecurity", Type = SpaceIndexType.Extended)]
   public Info PersonalInfo{ get; set; }
}

public class Info : Serializable {
	public String Name { get; set; }
	public Address Address{ get; set; }
	public Date Birthday { get; set; }
	public long SocialSecurity{ get; set; }
}

{%endhighlight%}

{%learn%}./indexing-nested-properties.html{%endlearn%}

# SpaceVersion



{: .table   .table-condensed  .table-bordered}
|Syntax     | SpaceVersion|
|Description| This annotation is used for object versioning used for optimistic locking. |
|Note       | The attribute must be an `int` data type. |

Example:

{%highlight csharp%}
[SpaceClass]
public class Employee {

  [SpaceVersion]
  public int Version { get; set; }

}
{%endhighlight%}

{%learn%}./transaction-optimistic-locking.html{%endlearn%}


# SpacePersist

{: .table   .table-condensed  .table-bordered}
|Syntax     | SpacePersist|
|Description| This specifies a getter method for holding the persistency mode of the object overriding the class level persist declaration. This field should be of the boolean data type.{%wbr%}If the persist class level annotation is true, all objects of this class type will be persisted into the underlying data store (Mirror, ExternalDataSource, Storage Adapter).|
|Note       | When using this option, you must have the space class level `persist` decoration specified.|

Example:

{%highlight csharp%}
[SpaceClass(Persist=true)
public class Employee {

  [SpacePersist]
  public Bool Persist{ get; set; }
}
{%endhighlight%}



# SpaceExclude

{: .table   .table-condensed  .table-bordered}
|Syntax     |  SpaceExclude|
|Description| When this annotation is specified the attribute is not written into the space.|

Example:

{%highlight csharp%}
[SpaceClass]
public class Employee {

  [SpaceExclude]
  public String MothersName{ get; set; }
}
{%endhighlight%}


{%comment%}
# SpaceLeaseExpiration

{: .table   .table-condensed  .table-bordered}
|Syntax     |  SpaceLeaseExpiration|
|Description|This annotation specifies the attribute for holding the timestamp of when the instance's lease expires. This property should not be populated by the user code. The space will populate this property automatically based on the lease time given by the user when writing the object. When using an external data source, you can choose to persist this value to the database. Subsequently, when data is reloaded from the external data source (at startup time for example), the space will filter out instances whose lease expiration timestamp has already passed. This field should be a `long` data type.|

Example:

{%highlight csharp%}
[SpaceClass (Persist=true)]
public class MyData {

    [SpaceLeaseExpiration]
    public long Lease{ get; set; }

}
{%endhighlight%}

{%learn%}./leases-automatic-expiration.html{%endlearn%}

{%endcomment%}

# SpaceStorageType

{: .table   .table-condensed  .table-bordered}
|Syntax     | SpaceStorageType StorageType |
|Argument   | [StorageType](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_Metadata_StorageType.htm)          |
|Default    | StorageType.Object |
|Description| This annotation is used to specify how the attribute is stored in the space. |

Example:

{%highlight csharp%}
[SpaceClass]
public class Message {

  [SpaceStorageType(storageType=StorageType.BINARY)]
  public String PayLoad{ get; set; }

}
{%endhighlight%}

{%learn%}./poco-storage-type.html{%endlearn%}


# SpaceFifoGroupingProperty

{: .table   .table-condensed  .table-bordered}
|Syntax     | SpaceFifoGroupingProperty Path|
|Argument   | path          |
|Description| This annotation is used to define a space FIFO grouping property. |
|Note | If defined, the `TakeModifiers.FIFO_GROUPING_POLL` or `ReadModifiers.FIFO_GROUPING_POLL` modifiers can be used to return all space entries that match the selection template in FIFO order. Different values of the FG property define groups of space entries that match each value. FIFO ordering exists within each group and not between different groups. |

Example:

{%highlight csharp%}
[SpaceClass]
public class FlightReservation
{
    [SpaceFifoGroupingProperty(Path = "FlightNumber")]
    public FlightInfo Info { get; set; }

}
{%endhighlight%}

{%learn%}./fifo-grouping.html{%endlearn%}


# SpaceFifoGroupingIndex

{: .table   .table-condensed  .table-bordered}
|Syntax     | SpaceFifoGroupingIndex Path|
|Description| This annotation is used to define a space FIFO grouping Index. |
|Note |This annotation can be declared on several properties in a class in order to assist in efficient traversal.{%wbr%}If defined, there must be a property in the class, marked with the `[SpaceFifoGroupingProperty]` annotation.{%wbr%}A compound index that contains this FIFO grouping index and the FIFO grouping property will be created.   |

Example:

{%highlight csharp%}

[SpaceFifoGroupingIndex]
public State ProcessingState { get; set; }
[SpaceFifoGroupingIndex(Path = "Id")]
public Person Customer { get; set; }

{%endhighlight%}

{%learn%}./fifo-grouping.html{%endlearn%}




# SpaceDynamicProperties

{: .table   .table-condensed  .table-bordered}
|Syntax     | SpaceDynamicProperties|
|Description| Allows adding properties freely to a class without worrying about the schema.|
|Note|**Only one property per class can be annotated with `[SpaceDynamicProperties]`.**|

Example:

{%highlight csharp%}
[SpaceClass]
public class Person {

    public String Name { get; set; }

    [SpaceDynamicProperties]
    public DocumentProperties ExtraInfo { get; set; }
}
{%endhighlight%}

{%learn%}./poco-dynamic-properties.html{%endlearn%}


# Alias Name

{: .table   .table-condensed  .table-bordered}
|Syntax     | AliasName|
|Description| In some cases, usually in interoperability scenarios, you may need to map your C# properties to different names in the Space. You can do that using the AliasName property on [SpaceProperty].  |
|Note| When using space SqlQuery on an object with properties which are aliased, the query text needs to use the aliased property names. For more information about SqlQuery, see [GigaSpaces.NET - Sql Query](./query-sql.html).|

Example:

{%highlight csharp%}
[SpaceClass]
public class Person {

 [SpaceProperty(AliasName="firstName")]
 public String FirstName {set; get;}

}
{%endhighlight%}

{%learn%}./interoperability.html{%endlearn%}


