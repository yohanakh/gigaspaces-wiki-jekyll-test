---
layout: post100
title:  User-Defined Objects
categories: XAP100NET
parent: interoperability.html
weight: 200
---



A deep class is defined as a class in which, at least one of its fields is a user defined class.


Creating a deep class to be interoperability ready, requires defining all its deep fields as fields that will be stored to the space, using its matching Java objects types. Use the property, `StorageType = StorageType.Object` on the `SpaceProperty()` attribute, defined to all the fields that are user defined objects.

Class name mapping: when defining interoperability ready classes, class names of the corresponding .NET and Java classes have to match exactly. In order to keep the .NET and Java namespace style conventions, and still create matching classes, we use the `AliasName` property of the `SpaceClass()` attribute to map the .NET class name and namespace to the matching Java class name and namespace.

Properties mapping: when defining interoperability of properties the names of the properties of the Java and .NET classes have to match exactly. In order to keep .NET and Java coding conventions and still create matching classes we use `AliasName` property of the `SpaceProperty()` attribute to map properties between .NET and Java.


### Designing Interoperable Classes

For the purpose of explaining the subject we'll look at a Person class (a deep class)

{%comment%}
{: .table .table-bordered}
| C# | Java |
|`using GigaSpaces.Core.Metadata;`<br/><br/>`namespace MyCompany.MyProject.Entities`<br/>`{`<br/>`    [SpaceClass(AliasName = "com.mycompany.myproject.entities.Person")]`<br/>`    public class Person`<br/>`    {`<br/>`        private string _name;`<br/>`        private Address _address;`<br/><br/>`        [SpaceProperty(AliasName = "name")]`<br/>`        public string Name`<br/>`        {`<br/>`            get { return _name; }`<br/>`            set { _name = value; }`<br/>`        }`<br/><br/>`        [SpaceProperty(AliasName = "address", StorageType = StorageType.Object)]`<br/>`        public Address Address`<br/>`        {`<br/>`            get { return _address; }`<br/>`            set { _address = value; }`<br/>`        }`<br/>`    }`<br/><br/>`    [SpaceClass(AliasName = "com.mycompany.myproject.entities.Address")]`<br/>`    public class Address`<br/>`    {`<br/>`        [SpaceProperty(AliasName = "houseNumber")]`<br/>`        public int HouseNumber;`<br/><br/>`        [SpaceProperty(AliasName = "street")]`<br/>`        public string Street;`<br/><br/>`        [SpaceProperty(AliasName = "country")]`<br/>`        public string Country;`<br/>`    }`<br/>`}`|`package com.mycompany.myproject.entities;`<br/><br/>`public class Person`<br/>`{`<br/>`    private String _name;`<br/>`    public String getName() { return _name; }`<br/>`    public void setName(String value) { _name = value; }`<br/><br/>`    private Address _address;`<br/>`    public Address getAddress() { return _address; }`<br/>`    public void setAddress(Address value) { _address = value; }`<br/>`}`<br/><br/>`package com.mycompany.myproject.entities;`<br/><br/>`public class Address`<br/>`{`<br/>`    public String HouseNumber;`<br/>`    public String Street;`<br/>`    public String Country;`<br/>`}`|
{%endcomment%}

{%panel%}
{%section%}
{%column width=50% %}
{%raw%}C#{%endraw%}

{%highlight csharp%}
using GigaSpaces.Core.Metadata;

namespace MyCompany.MyProject.Entities
{
   [SpaceClass(AliasName = "com.mycompany.myproject.entities.Person")]
   public class Person
   {
    private string _name;
    private Address _address;

    [SpaceProperty(AliasName = "name")]
    public string Name
    {
        get { return _name; }
        set { _name = value; }
    }

    [SpaceProperty(AliasName = "address", StorageType = StorageType.Object)]
    public Address Address
    {
        get { return _address; }
        set { _address = value; }
    }
  }

  [SpaceClass(AliasName = "com.mycompany.myproject.entities.Address")]
  public class Address
  {
    [SpaceProperty(AliasName = "houseNumber")]
    public int HouseNumber;

    [SpaceProperty(AliasName = "street")]
    public string Street;

    [SpaceProperty(AliasName = "country")]
    public string Country;
  }
}
{%endhighlight%}
{%endcolumn%}

{%column width=50% %}
{%raw%}Java{%endraw%}

{%highlight java%}
package com.mycompany.myproject.entities;

public class Person
{
    private String _name;
    public String getName() { return _name; }
    public void setName(String value) { _name = value; }

    private Address _address;
    public Address getAddress() { return _address; }
    public void setAddress(Address value) { _address = value; }
}

package com.mycompany.myproject.entities;

public class Address
{
    public String HouseNumber;
    public String Street;
    public String Country;
}
{%endhighlight%}
{%endcolumn%}
{%endsection%}
{%endpanel%}

