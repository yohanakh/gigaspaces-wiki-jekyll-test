
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
{% highlight java %}
import static org.openspaces.extensions.QueryExtension.*;
...
SQLQuery<Person> personSQLQuery = new SQLQuery<Person>();
// retrieve the maximum value stored in the field "age"
Number maxAgeInSpace = maxValue(space, personSQLQuery, "age");
/// retrieve the minimum value stored in the field "age"
Number minAgeInSpace = minValue(space, personSQLQuery, "age");
// Sum the "age" field on all space objects.
Number combinedAgeInSpace = sum(space, personSQLQuery, "age");
// Sum's the "age" field on all space objects then divides by the number of space objects.
Double averageAge = average(space, personSQLQuery, "age");
// Retrieve the space object with the highest value for the field "age".
Person oldestPersonInSpace = maxEntry(space, personSQLQuery, "age");
/// Retrieve the space object with the lowest value for the field "age".
Person youngestPersonInSpace = minEntry(space, personSQLQuery, "age");
{% endhighlight %}
{% endtabcontent%}
{% tabcontent Space Class %}
{% highlight java %}
@SpaceClass
public class Person {
    private Long id;
    private Long age;
    private String country;

    @SpaceId(autoGenerate=false)
    public Long getId() {
        return id;
    }

    public Person setId(Long id) {
        this.id = id;
        return this;
    }

    public Long getAge() {
        return age;
    }

    public Person setAge(Long age) {
        this.age = age;
        return this;
    }

    @SpaceIndex
    public String getCountry() {
        return country;
    }

    public Person setCountry(String country) {
        this.country = country;
        return this;
    }
}
{% endhighlight %}
{% endtabcontent%}
{%endinittab%}


{%learn%}./aggregators.html{%endlearn%}


