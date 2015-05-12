---
layout: post101
title:  Transaction support
categories: XAP101NET
parent: notify-container-overview.html
weight: 200
---

{%wbr%}

The notify container can be configured with transaction support, so the event action can be performed under a transaction. Exceptions thrown by the event listener cause the operations performed within the listener to be rolled back automatically.

{% note %}
When using transactions, only the event listener operations are rolled back. The notifications are not sent again in case of a transaction rollback. If this behavior is required, please consider using the [Polling Event Container](./polling-container.html). Adding transaction support to the polling container is very simple. It is done by setting the `TransactionType` property. There are two transaction types: Distributed and Manual.
{%endnote%}

- Distributed transaction - an embedded distributed transaction manager will be created and it will be used for creating transaction (Only one transaction manager will be created per AppDomain).
- Manual transaction - transactions will be created by the transaction manager that is stored in the `TransactionManager` property. By default no transaction manager is stored and therefore, no transaction will be used. For example:

{% inittab os_simple_space|top %}

{% tabcontent Using EventListenerContainerFactory %}

{% highlight csharp %}
[NotifyEventDriven]
[TransactionalEvent(TransactionType = TransactionType.Distributed)]
public class SimpleListener
{
 ...
}
{% endhighlight %}

{% endtabcontent %}

{% tabcontent NotifyEventListenerContainer Code Construction %}

{% highlight csharp %}
ISpaceProxy spaceProxy = // either create the SpaceProxy or obtain a reference to it

NotifyEventListenerContainer<Data> notifyEventListenerContainer = new NotifyEventListenerContainer<Data>(spaceProxy);
notifyEventListenerContainer.TransactionType = TransactionType.Distributed;
{% endhighlight %}

{% endtabcontent %}

{% endinittab %}

It is possible to receive a reference to the on going transaction as part of the event handling method, if for instance, the event handling is doing some extra space operations which should be executed under the same transaction context and rolled back upon failure. This is done be adding a transaction parameter to the event handler method. For example:

{% inittab os_simple_space|top %}

{% tabcontent Using EventListenerContainerFactory %}

{% highlight csharp %}
[NotifyEventDriven]
[TransactionalEvent(TransactionType = TransactionType.Distributed)]
public class SimpleListener
{
 ...

    [DataEventHandler]
    public Data ProcessData(Data event, ISpaceProxy spaceProxy, ITransaction transaction)
    {
        //process Data here and return processed data
    }
}
{% endhighlight %}

{% endtabcontent %}

{% tabcontent NotifyEventListenerContainer Code Construction %}

{% highlight csharp %}
ISpaceProxy spaceProxy = // either create the SpaceProxy or obtain a reference to it

NotifyEventListenerContainer<Data> notifyEventListenerContainer = new NotifyEventListenerContainer<Data>(spaceProxy);
notifyEventListenerContainer.TransactionType = TransactionType.Distributed;
notifyEventListenerContainer.DataEventArrived += new DelegateDataEventArrivedAdapter<Data,Data>(ProcessData).WriteBackDataEventHandler;
{% endhighlight %}

{% endtabcontent %}

{% endinittab %}

{% refer %}The order of parameters of the event handling method is strict, please refer to [Dynamic Data Event Handler Adapter](./event-listener-container.html#eventhandleradapter) for more information about it.{% endrefer %}

