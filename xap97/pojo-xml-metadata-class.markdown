---
layout: post97
title:  Class Metadata
categories: XAP97
parent: pojo-xml-metadata-overview.html
weight: 100
---

{% summary %}{% endsummary %}


# Name

{: .table .table-bordered}
|Syntax     | name="" |
|Description| Contains the full qualified name of the specified class. Because this attribute is of the XML type `ID`, there can only be one `class-descriptor` per class. |

Example:
{%highlight xml%}
<gigaspaces-mapping>
	<class name="model.Person">
	</class>
</gigaspaces-mapping>
{%endhighlight%}



# Persistence

{: .table .table-bordered}
|Syntax     | persist="" |
|Argument   | boolean|
|Default    | false|
|Description|  This field indicates the persistency mode of the object. When a space is defined as persistent, a `true` value for this attribute will persist objects of this type.  |

Example:

{%highlight xml%}
<gigaspaces-mapping>
	<class name="model.Person" persist="true">
	</class>
</gigaspaces-mapping>
{%endhighlight%}


{%learn%}./space-persistency.html{%endlearn%}

# Replication

{: .table .table-bordered}
|Syntax     | replicate="true" |
|Argument   | boolean|
|Default    | false|
|Description|  This field indicates the replication mode of the object. When a space is defined as replicated, a `true` value for this attribute will replicate objects of this type.|

Example:

{%highlight xml%}
<gigaspaces-mapping>
	<class name="model.Person" replicate="true">
	</class>
</gigaspaces-mapping>
{%endhighlight%}


{%learn%}./replication.html{%endlearn%}


# FIFO Support

{: .table .table-bordered}
|Syntax     | fifo-support=""  |
|Argument   | [FifoSupport]({% javadoc com/gigaspaces/annotation/pojo/FifoSupport %})|
|Default    | not_set|
|Description| Enabling  FIFO operations.     |

Example:

{%highlight xml%}
<gigaspaces-mapping>
    <class name="model.Person" fifo-support="operation">
    </class>
</gigaspaces-mapping>
{%endhighlight%}


{%learn%}./fifo-support.html{%endlearn%}

# Storage Type

{: .table .table-bordered}
|Syntax     | storage-type="" |
|Argument   | [StorageType]({% javadoc com/gigaspaces/metadata/StorageType %})          |
|Default    | object |
|Description| To determine a default storage type for each non primitive property for which a (field level) storage type was not defined.|

Example:

{%highlight xml%}
<gigaspaces-mapping>
    <class name="model.Person" storage-type="binary" />
</gigaspaces-mapping>

{%endhighlight%}


{%learn%}./storage-types---controlling-serialization.html{%endlearn%}


# Include Properties

{: .table .table-bordered}
|Syntax     | include-properties="" |
|Argument   | [IncludeProperties](http://www.gigaspaces.com/docs/JavaDoc{%currentversion%}/com/gigaspaces/annotation/pojo/SpaceClass.IncludeProperties.html)      |
|Default    | implicit|
|Description| `implicit` takes into account all POJO fields -- even if a `get` method is not declared   as a `SpaceProperty`, it is taken into account as a space field.`explicit` takes into account only the `get` methods which are declared in the mapping file. |

Example:

{%highlight xml%}
<gigaspaces-mapping>
    <class name="model.Person" include-properties="explicit" />
</gigaspaces-mapping>
{%endhighlight%}



# Inherit Index

{: .table .table-bordered}
|Syntax     | inherit-indexes="" |
|Argument   | boolean          |
|Default    | true|
|Description| Whether to use the class indexes list only, or to also include the superclass' indexes. {% wbr %}If the class does not define indexes, superclass indexes are used. {% wbr %}Options:{% wbr %}- `false` -- class indexes only.{% wbr %}- `true` -- class indexes and superclass indexes.|

Example:

{%highlight xml%}
<gigaspaces-mapping>
    <class name="model.Person" inherit-indexes="false" />
</gigaspaces-mapping>
{%endhighlight%}

{%learn%}./indexing.html{%endlearn%}


# Compound Index

{: .table .table-bordered}
|Syntax     | compound-index paths="" |
|Argument(s)| string          |
|Values     | attribute name(s)   |
|Description| Indexes can be defined for multiple attributes of a class  |

Example:

{%highlight xml%}
<gigaspaces-mapping>
    <class name="Data" >
        <compound-index paths="data1, data2"/>
        ...
    </class>
</gigaspaces-mapping>
{%endhighlight%}


{%learn%}./indexing-compound.html{%endlearn%}






