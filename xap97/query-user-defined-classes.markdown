---
layout: post97
title:  User Defined Classes
categories: XAP97
parent: querying-the-space.html
weight: 500
---





Since matching and comparing expressions is executed via java's built-in `equals` and `Comparable` mechanisms, a user defined class can be matched and compared as well.

For example, suppose a user defined a class called **Version**, which encapsulates a major version and a minor version integers, and then implements a space class *Document* with a **version** property.
The following example queries for a **Document** with a **version** greater than **2.5**:

{% highlight java %}
SQLQuery<Document> query = new SQLQuery<Document>(Document.class, "version > ?", new Version(2, 5));
{% endhighlight %}

In order for that query to execute correctly, the user-defined class should implement the following:

- For equality (equals/not equals): the `equals()` and `hashCode()` methods.
- For comparison (greater/less than): the `java.lang.Comparable` interface.

Here's an example of **Version** implementing both equality and comparison requirements:

{% highlight java %}
public class Version implements Serializable, Comparable<Version> {
    private int major;
    private int minor;
    // Getters and setters are omitted for brevity.

    @Override
    public boolean equals(Object obj) {
        if (obj == this)
            return true;
        if (!(obj instanceof Version))
            return false;
        Version other = (Version)obj;
        return this.major == other.major && this.minor == other.minor;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + major;
        result = prime * result + minor;
        return result;
    }

    @Override
    public int compareTo(Version other) {
        int result = Integer.compare(this.major, other.major);
        if (result == 0)
            result = Integer.compare(this.minor, other.minor);
        return result;
    }
}
{% endhighlight %}


<ul class="pager">
  <li class="previous"><a href="./query-nested-properties.html">&larr; Nested Properties</a></li>
  <li class="next"><a href="./query-paging-support.html">Paging Support &rarr;</a></li>
</ul>