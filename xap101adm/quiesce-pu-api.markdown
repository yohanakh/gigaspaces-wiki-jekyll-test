---
layout: post101
title:  API and Usage
categories: XAP101ADM
parent: quiescemode.html
weight: 200
---

{% summary %}{% endsummary %}

# Processing Unit API

ProcessingUnit interface API to trigger and manage Quiesce Mode:

{% highlight java %}
// Requests quiesce request from the GSM.
// All space instances and listeners will switch to quiesced mode.
// If the GSM rejects the request an exception with the rejection failure will be thrown.
QuiesceResult quiesce(QuiesceRequest request);
// Requests unquiesce request from the GSM.
// All space instances and listeners will switch to unquiesced mode.
// If the GSM rejects the request an exception with the rejection failure will be thrown.
void unquiesce(QuiesceRequest request);
// Return true if the processing unit reached to desired state as well as all instances in the requested timeout, false otherwise.
boolean waitFor(QuiesceState desiredState, long timeout, TimeUnit timeUnit);
boolean waitFor(QuiesceState desiredState);
// Return the quiesce details of the processing unit
QuiesceDetails getQuiesceDetails();
{% endhighlight %}


# Quiesce State Changed Listener
A user defined component (a.k.a spring bean) in a processing unit is able to implement `QuiesceStateChangedListener` and to be aware of quiesce state changed events:
{% highlight java %}
public class CustomComponent implements ... ,QuiesceStateChangedListener {
    ...
    public void quiesceStateChanged(QuiesceStateChangedEvent event) {
        if (event.getQuiesceState() == QuiesceState.QUIESCED)
            // stop interacting with the space to prevent getting exceptions
        else
            // resume interacting with the space
    }
}
{% endhighlight %}

# Use Cases Implementation Samples
{%info title=Safe undeploy a stateful processing unit%}{%endinfo%}
{% highlight java %}

QuiesceRequest request = new QuiesceRequest("Jacob: performing safe shutdown in 11:33 AM");
QuiesceResult result = pu.quiesce(request);
boolean quiesced = pu.waitFor(QuiesceState.QUIESCED, OPERATION_TIMEOUT, TimeUnit.MINUTES);
if (quiesced) {
    System.out.println("All instances are QUIESCED, shutting down...");
    // wait for redo log to drop to zero
    ...
    pu.undeployAndWait(OPERATION_TIMEOUT, TimeUnit.MILLISECONDS)
}
else {
    System.out.println("All instances were not QUIESCED within the given timeout");
    // Print QuiesceDetails to figure out which instances were not QUIESCED 
    System.out.println("Details: " + pu.getQuiesceDetails());
    // retry or do some logic 
    ...
}

{% endhighlight %}

{%info title=Rolling system upgrade on a live system%}{%endinfo%}
{% highlight java %}

QuiesceRequest request = new QuiesceRequest("Jacob: performing hot deploy in 11:33 AM");
QuiesceResult result = pu.quiesce(request);
pu.waitFor(QuiesceState.QUIESCED, OPERATION_TIMEOUT, TimeUnit.MINUTES);
// wait for redo log to drop to zero
...
// upgrade the system, restart backups and then primaries
...
QuiesceRequest resumeRequest = new QuiesceRequest("Jacob: resumming the system in 12:14 AM");
pu.unquiesce(resumeRequest);
pu.waitFor(QuiesceState.UNQUIESCED, OPERATION_TIMEOUT, TimeUnit.MINUTES);
System.out.println("the system was successfully upgraded");

{% endhighlight %}


