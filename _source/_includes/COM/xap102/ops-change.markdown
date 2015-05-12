
{%anchor change%}

# The Change Operation


{%section%}
{%column width=70% %}
The [GigaSpace.change](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/org/openspaces/core/GigaSpace.html) and the [ChangeSet](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/index.html?com/gigaspaces/client/ChangeSet.html) allows updating existing objects in space, by specifying only the required change instead of passing the entire updated object.
Thus reducing required network traffic between the client and the space, and the network traffic generated from replicating the changes between the space instances (e.g between the primary space instance and its backup).
{%endcolumn%}
{%column width=30% %}
![change-api.jpg](/attachment_files/change-api.jpg)
{%endcolumn%}
{%endsection%}


Example:

The following example demonstrates how to update the property 'firstName' of an object of type 'Person' with id 'myID'.

{% highlight java %}
GigaSpace space = // ... obtain a space reference
String id = "myID";
IdQuery<WordCount> idQuery = new IdQuery<Person>(Person.class, id, routing);
space.change(idQuery, new ChangeSet().set("firstName", "John"));
{% endhighlight %}

{%learn%}./change-api.html{%endlearn%}

