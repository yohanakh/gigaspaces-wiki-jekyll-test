---
layout: post102
title:  Class Metadata
categories: XAP102NET
parent: pono-xml-metadata-overview.html
weight: 100
---

{% summary %}{% endsummary %}


# Name

{: .table   .table-condensed  .table-bordered}
|Syntax     | name |
|Description| Contains the full qualified name of the specified class. Because this attribute is of the XML type `ID`, there can only be one `class-descriptor` per class. |

Example:
{%highlight xml%}
<gigaspaces-mapping>
	<class name="Model.Person">
	</class>
</gigaspaces-mapping>
{%endhighlight%}

# Alias name

{: .table   .table-condensed  .table-bordered}
|Syntax     | alias-name |
|Argument   | boolean|
|Description|  Gives the ability to map a C# class name (including namespace) to a space class name  |

Example:

{%highlight xml%}
<gigaspaces-mapping>
	<class name="Model.Person" alias-name="CommonPerson">
	</class>
</gigaspaces-mapping>
{%endhighlight%}


# Persistence

{: .table   .table-condensed  .table-bordered}
|Syntax     | persist |
|Argument   | boolean|
|Default    | false|
|Description|  This field indicates the persistency mode of the object. When a space is defined as persistent, a `true` value for this attribute will persist objects of this type.  |

Example:

{%highlight xml%}
<gigaspaces-mapping>
	<class name="Model.Person" persist="true">
	</class>
</gigaspaces-mapping>
{%endhighlight%}


{%learn%}./space-persistency.html{%endlearn%}

# Replication

{: .table   .table-condensed  .table-bordered}
|Syntax     | replicate |
|Argument   | boolean|
|Default    | false|
|Description|  This field indicates the replication mode of the object. When a space is defined as replicated, a `true` value for this attribute will replicate objects of this type.|

Example:

{%highlight xml%}
<gigaspaces-mapping>
	<class name="Model.Person" replicate="true">
	</class>
</gigaspaces-mapping>
{%endhighlight%}


{%learn%}{%currentadmurl%}/replication.html{%endlearn%}


# FIFO Support

{: .table   .table-condensed  .table-bordered}
|Syntax     | fifo  |
|Argument   | [FifoSupport](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_Metadata_FifoSupport.htm)|
|Default    | off|
|Description| Enabling  FIFO operations.     |

Example:

{%highlight xml%}
<gigaspaces-mapping>
    <class name="Model.Person" fifo="operation">
    </class>
</gigaspaces-mapping>
{%endhighlight%}


{%learn%}./fifo-support.html{%endlearn%}

# Storage Type

{: .table   .table-condensed  .table-bordered}
|Syntax     | storage-type |
|Argument   | [StorageType](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_Metadata_StorageType.htm)|
|Default    | object |
|Description| To determine a default storage type for each non primitive property for which a (field level) storage type was not defined.|

Example:

{%highlight xml%}
<gigaspaces-mapping>
    <class name="Model.Person" storage-type="binary" />
</gigaspaces-mapping>

{%endhighlight%}


{%learn%}./poco-storage-type.html{%endlearn%}


{%comment%}
# Include Properties

{: .table   .table-condensed  .table-bordered}
|Syntax     | include-properties |
|Argument   | [IncludeProperties](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_Metadata_IncludeMembers.htm)      |
|Default    | all|
|Description| `implicit` takes into account all PONO fields -- even if a `get` method is not declared   as a `SpaceProperty`, it is taken into account as a space field.`explicit` takes into account only the `get` methods which are declared in the mapping file. |

Example:

{%highlight xml%}
<gigaspaces-mapping>
    <class name="Model.Person" include-properties="public" />
</gigaspaces-mapping>
{%endhighlight%}
{%endcomment%}


# Inherit Index

{: .table   .table-condensed  .table-bordered}
|Syntax     | inherit-indexes |
|Argument   | boolean          |
|Default    | true|
|Description| Whether to use the class indexes list only, or to also include the superclass' indexes. {% wbr %}If the class does not define indexes, superclass indexes are used. {% wbr %}Options:{% wbr %}- `false` -- class indexes only.{% wbr %}- `true` -- class indexes and superclass indexes.|

Example:

{%highlight xml%}
<gigaspaces-mapping>
    <class name="Model.Person" inherit-indexes="false" />
</gigaspaces-mapping>
{%endhighlight%}

{%learn%}./indexing.html{%endlearn%}


# Compound Index

{: .table   .table-condensed  .table-bordered}
|Syntax     | compound-index paths |
|Argument(s)| string          |
|Values     | attribute name(s)   |
|Description| Indexes can be defined for multiple properties of a class  |

Example:

{%highlight xml%}
<gigaspaces-mapping>
    <class name="Data" >
        <compound-index paths="Data1, Data2"/>
        ...
    </class>
</gigaspaces-mapping>
{%endhighlight%}


{%learn%}./indexing-compound.html{%endlearn%}






