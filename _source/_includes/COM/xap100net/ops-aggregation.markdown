
{%anchor aggregators%}

# Aggregators


{%section%}
{%column width=70% %}
There is no need to retrieve the entire data set from the space to the client side , iterate the result set and perform the aggregation. This would be an expensive activity as it might return large amount of data into the client application. The Aggregators allow you to perform the entire aggregation activity at the space side avoiding any data retrieval back to the client side.

{%endcolumn%}
{%column width=30% %}
![aggreg.jpg](/attachment_files/built-in-aggregators.jpg)
{%endcolumn%}
{%endsection%}


Example:

{% inittab %}
{% tabcontent Application %}
{% highlight c# %}
using GigaSpaces.Core.Linq;
...
var queryable = from p in spaceProxy.Query<Person>() select p;
// retrieve the maximum value stored in the field "age"
int maxAgeInSpace = queryable.Max(p => p.Age);
// retrieve the minimum value stored in the field "age"
int minAgeInSpace = queryable.Min(p => p.Age);
// Sum the "age" field on all space objects.
int combinedAgeInSpace = queryable.Sum(p => p.Age);
// Sum's the "age" field on all space objects then divides by the number of space objects.
double averageAge = queryable.Average(p => p.Age);
// Retrieve the space object with the highest value for the field "age".
Person oldestPersonInSpace = queryable.MaxEntry(p => p.Age);
// Retrieve the space object with the lowest value for the field "age".
Person youngestPersonInSpace = queryable.MinEntry(p => p.Age);
{% endhighlight %}
{% endtabcontent%}
{% tabcontent Space Class %}
{% highlight c# %}
[SpaceClass]
public class Person
{
    [SpaceID(AutoGenerate = true)]
    public string Id { get; set; }

    public string Name { get; set; }

    [SpaceIndex]
    public string Country { get; set; }

    public int Age { get; set; }
}
{% endhighlight %}
{% endtabcontent%}
{%endinittab%}


{%learn%}./aggregators.html{%endlearn%}


