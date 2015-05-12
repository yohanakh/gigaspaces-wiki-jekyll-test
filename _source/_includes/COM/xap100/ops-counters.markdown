
{%anchor counters%}

# Counters


{% section %}
{% column width=70% %}
The `ISpaceProxy.Change` API allows you to increment or decrement an Numerical field within your Space object or Document. This change may operate on a numeric property only (byte,short,int,long,float,double) or their corresponding Boxed variation. To maintain a counter you should use the Change operation with the `ChangeSet` increment/decrement method that adds/subtract the provided numeric value to the existing counter.


{% endcolumn %}
{% column width=30% %}
![change-api-counter.jpg](/attachment_files/change-api-counter.jpg)
{% endcolumn %}
{% endsection %}

Example:

Incrementing a Counter done using the `ChangeSet().Increment` call:

{% highlight java %}
GigaSpace space = // ... obtain a space reference
String id = "myID";
IdQuery<WordCount> idQuery = new IdQuery<WordCount>(WordCount.class, id);
space.change(idQuery, new ChangeSet().increment("mycounter", 1));
{% endhighlight %}


Getting the Counter value via the read call:

{% highlight java %}
GigaSpace space = // ... obtain a space reference
String id = "myID";
IdQuery<WordCount> idQuery = new IdQuery<WordCount>(WordCount.class, id);
WordCount wordount = space.readById(WordCount.class , idQuery);
int counterValue = wordount.getMycounter();
{% endhighlight %}



{%learn%}./the-space-counters.html{%endlearn%}
