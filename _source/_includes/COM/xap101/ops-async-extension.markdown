

# Async Extension 


{%section%}
When running with Java8, it is possible to have an even simpler Space API with the `AsyncExtension`.
AsyncExtension substituts the Space `AsyncFuture` with the Java8 `CompletableFuture` and thus can make the code more fluent.

There is no need to retrieve the entire data set from the Space to the client side , iterate the result set and perform the aggregation. This would be an expensive activity as it might return a large amount of data into the client application. The `Aggregators` allow you to perform the entire aggregation activity at the Space side avoiding any data retrieval back to the client side.
{%endsection%}


Example:

{% highlight java %}
import static org.openspaces.extensions.AsyncExtension.asyncRead;

asyncRead(gigaSpace, template).thenAccept(value -> {
    System.out.println("got " + value);
})

{% endhighlight %}



