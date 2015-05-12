---
layout: post101
title:  Embedded Space
categories: XAP101NET
weight:
parent:
---

{% summary %}{%endsummary%}



# Custom Properties

{: .table   .table-condensed  .table-bordered}
|Argument   | Dictionary<String,String> |
|Default    | none|
|Description|  |

Example:

{%highlight csharp%}
public void createSpaceWithProperties()
{
    Dictionary<String,String> properties = new Dictionary<String,String> ();
	properties.Add ("fifo", "true");
	properties.Add ("lookupGroups", "test");

    // Create the factory
	EmbeddedSpaceFactory factory = new EmbeddedSpaceFactory ("mySpace");

	// Set the properties
	factory.CustomProperties = properties;

	//create the ISpaceProxy
	ISpaceProxy proxy = factory.Create ();

	// .......
	proxy.Dispose ();
}
{%endhighlight%}

# Security

{: .table   .table-condensed  .table-bordered}
|Argument   | SecurityContext |
|Default    | none|
|Description||

Example:

{%highlight csharp%}
public void createSpaceWithCredentials()
{
    SecurityContext securityContext = new SecurityContext ("userName", "password");

	// Create the factory
	EmbeddedSpaceFactory factory = new EmbeddedSpaceFactory ("mySpace");

    // Set the Security Context
	factory.Credentials = securityContext;

	//create the ISpaceProxy
	ISpaceProxy proxy = factory.Create ();

	// .......
	proxy.Dispose ();
}
{%endhighlight%}

# Cluster Info

{: .table   .table-condensed  .table-bordered}
|Argument   | [ClusterInfo](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_ClusterInfo.htm) |
|Default    | none|
|Description||

Example:

{%highlight csharp%}
public void createSpaceWithClusterInfo()
{
    // Cluster info settings
	ClusterInfo clusterInfo = new ClusterInfo ();
	clusterInfo.NumberOfBackups = 1;
	clusterInfo.Schema = "sync_replication";
	// Create the factory
	EmbeddedSpaceFactory factory = new EmbeddedSpaceFactory ("mySpace");
	// Set the Cluster Info
	factory.ClusterInfo = clusterInfo;
	//create the ISpaceProxy
	ISpaceProxy proxy = factory.Create ();
	// .......
	proxy.Dispose ();
}
{%endhighlight%}

### ClusterInfo





# Filters

{: .table   .table-condensed  .table-bordered}
|Argument   | [ClusterInfo](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_ClusterInfo.htm) |
|Default    | none|
|Description||

Example:

{%highlight csharp%}
public void createSpaceWithFilter()
{
  TODO

}
{%endhighlight%}

# Gateway

{: .table   .table-condensed  .table-bordered}
|Argument   | [ClusterInfo](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_ClusterInfo.htm) |
|Default    | none|
|Description||

Example:

{%highlight csharp%}
public void createSpaceWithGateway()
{
  TODO

}
{%endhighlight%}


# LookupGroups

{: .table   .table-condensed  .table-bordered}
|Argument   | [ClusterInfo](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_ClusterInfo.htm) |
|Default    | none|
|Description||

Example:

{%highlight csharp%}
public void createSpaceWithLookupGroups()
{
  TODO

}
{%endhighlight%}


# LookupLocators

{: .table   .table-condensed  .table-bordered}
|Argument   | [ClusterInfo](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_ClusterInfo.htm) |
|Default    | none|
|Description||

Example:

{%highlight csharp%}
public void createSpaceWithLookupLocators()
{
  TODO

}
{%endhighlight%}


# LookupTimeout

{: .table   .table-condensed  .table-bordered}
|Argument   | [ClusterInfo](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_ClusterInfo.htm) |
|Default    | none|
|Description||

Example:

{%highlight csharp%}
public void createSpaceWithLookupTimeout()
{
  TODO

}
{%endhighlight%}


# Mirrored

{: .table   .table-condensed  .table-bordered}
|Argument   | [ClusterInfo](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_ClusterInfo.htm) |
|Default    | none|
|Description||

Example:

{%highlight csharp%}
public void createSpaceWithMirrored()
{
  TODO
}
{%endhighlight%}


# Name

{: .table   .table-condensed  .table-bordered}
|Argument   | [ClusterInfo](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_ClusterInfo.htm) |
|Default    | none|
|Description||

Example:

{%highlight csharp%}
public void createSpaceWithName()
{
  TODO
}
{%endhighlight%}

# Secured

{: .table   .table-condensed  .table-bordered}
|Argument   | [ClusterInfo](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_ClusterInfo.htm) |
|Default    | none|
|Description||

Example:

{%highlight csharp%}
public void createSpaceSecured()
{
  TODO
}
{%endhighlight%}


# Versioned

{: .table   .table-condensed  .table-bordered}
|Argument   | [ClusterInfo](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_ClusterInfo.htm) |
|Default    | none|
|Description||

Example:

{%highlight csharp%}
public void createSpaceVersioned()
{
  TODO
}
{%endhighlight%}



	//Filters
		//Clustered
		//Gateway
		//LookupGroups
		//LookupLocators
		//LookupTimeout
		//Mirrored
		//Name
		//Secured
		//SpaceTypes
		//Versioned



