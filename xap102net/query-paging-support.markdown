---
layout: post102
title:  Paging Support
categories: XAP102NET
parent: querying-the-space.html
weight: 600
---

{% summary %}{% endsummary %}

The [ISpaceIterator](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_ISpaceIterator_1.htm) with the [SpaceIteratorConfig](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_SpaceIteratorConfig.htm)  provides the ability to exhaustively read through all of the objects from the space that match one or more SQLQuery/templates.




There are scenarios where the conventional read operation that returns a single space object does not fit and there is a need to return a collection of entries from the space. Generally, an iterator should be used in cases where returning all the entries in one result with the `ReadMultiple` operation will consume too much memory on the client or introduce too much latency before the first space object could be processed.

The iterator constructs a match set (a collection of space objects instances) that incrementally returns the necessary objects in chunks or pages. The `ISpaceIterator` constructs a proxy object that can be used to access a match set created by a space. The `ISpaceIterator` will initially contain some population of objects specified by the operation that created it. These objects can be retrieved by calling `foreach` on the iterator.

Simple usage example for the `SpaceIteratorConfig` with the `ISpaceIterator`:

{% highlight csharp %}
SqlQuery<Employee> query = new SqlQuery<Employee>("Name='John'");

SpaceIteratorConfig config = new SpaceIteratorConfig();
config.BufferSize = 5000;
config.IteratorScope = IteratorScope.ExistingEntries;

ISpaceIterator<Employee> iter = spaceProxy.GetSpaceIterator<Employee> (query, config);

while(iter.MoveNext())
{
    Employee employee = iter.Current;
    Console.WriteLine("Got Employee: " + employee);
}
{% endhighlight %}


# The Iterator Configuration

{%comment%}
ISpaceIterator is a utility builder class for the ISpaceIterator. It allows to use method chaining for simple configuration of an iterator and then call iterate() to get the actual iterator.

By default, when no template is added (using `addTemplate`), a `null` template will be used to iterate over all the content of the Space.
{%endcomment%}

The iterator can iterate on objects **currently** in the space, **future** entries or **both**. By default it will only iterate on **future** objects in the Space (objects that match the given template(s)). Use iteratorScope(IteratorScope) to set the iterator's scope.

Lease for the iterator can be controlled using `LeaseTime`. A leased iterator which expires is considered as invalidated. A canceled iterator is an exhausted iterator and will have no more entities added to it.

If there is a possibility that an iterator may become invalidated, it must be leased. If there is no possibility that the iterator will become invalidated, implementations should not lease it. If there is no further interest an iterator may be canceled.

An active lease on an iterator serves as a hint to the space that the client is still interested in matching objects, and as a hint to the client that the iterator is still functioning. There are cases, however, where this **may not** be possible in particular, it is not expected that iteration will maintain across crashes. If the lease expires or is canceled, the iterator is invalidated. Clients should not assume that the resources associated with a leased ISpaceIterator will be freed if the ISpaceIterator reaches the exhausted state, and should instead cancel the lease.

The maximum number of objects to pull from the space can be controlled using `BufferSize` and defaults to `100`.

# The IteratorScope

The [IteratorScope](http://www.gigaspaces.com/docs/dotnetdocs{%currentversion%}/html/T_GigaSpaces_Core_IteratorScope.htm) determines the scope of a ISpaceIterator. Here are the supported options:

- `ExistingEntries` - Indicates that the iterator will process entries currently in the space, and ignores future changes.
- `ExistingAndFutureEntries` - Indicates that the iterator will process both entries currently in the space and future changes.
- `FutureEntries` - Indicates that the iterator will ignore entries currently in the space, and process future changes.

{%comment%}
# The ISpaceIterator

The `ISpaceIterator` will initially contain some population of objects. These objects can be retrieved by calling `foreach` on the iterator.

A leased iterator which expires is considered as invalidated. A canceled iterator is an exhausted iterator and will have no more entities added to it. Calling next on an iterator with either state always returns null or it may throw one of the allowed exceptions. In particular next(timeout) may throw NoSuchObjectException to indicate that no object has been found during the allowed timeout. There is no guarantee that once next(timeout) throws a NoSuchObjectException, or next returns null, all future calls on that instance will do the same.

Between the time an iterator is created and the time it reaches a terminal state, objects may be added by the space. However, an object that is removed by a next call may be added back to the iterator if its uniqueness is equivalent. The space may also update or remove objects that haven't yet been returned by a `foreach` call, and are not part of the buffered set.




A match set becomes exhausted or invalidated specified by the operation that created it under the following conditions:

- An exhausted match set is empty and will have no more entries added. Calling next on an exhausted match set must always return `null`.
- Calling next on an invalidated match set may return a `non-null` value, or it may return a `EntryNotInSpaceException` to indicate that the match set has been invalidated. Once next throws a `EntryNotInSpaceException`, all future next calls on that instance will throw `EntryNotInSpaceException`.
- Calling next on an invalidated match set does not return `null`.
- Entries are not added to an invalidated match set.

Between the time a match set is created and the time it reaches a terminal state, entries may be added by the space. However, a space object that is removed by a `next` call must not be added back to a match set (though if there is a distinct but equivalent object in the space it may be added). The space may also remove Entries independent of next calls. The conditions under which Entries will be removed independent of next calls or added after the initial creation of the match set are specified by the operation that created the match set.

An active lease on a match set serves as a hint to the space that the client is still interested in the match set, and as a hint to the client that the match set is still functioning, i.e., if a match set is leased and the lease is active, `ISpaceIterator` will maintain the match set and will not invalidate it.

If the iterator lease expires or is canceled, `ISpaceIterator` will invalidate the match set. Clients should not assume that the resources associated with a leased match set will be freed automatically if the match set reaches the exhausted state, but should explicitly cancel the lease.


The `ISpaceIterator` constructed using the following parameters:

- Collection of SqlQuery or templates.
- Including or excluding existing matched Entries in the space.
- Limit.
- Lease, Renew Lease, Cancel Lease.
- Next (returns Entry).
- Blocking Next (next with timeout).
{%endcomment%}


## Using ISpaceIterator with SQLQuery

When using the `ISpaceIterator` with SQLQuery only [simple SQL queries](./query-sql.html#Simple Queries - Supported and Non-Supported Operators) are supported:
    (field1 < value1) AND (field2 > value2) AND (field3 == values3)...
The following operators **are not supported** when using `ISpaceIterator`:

- `NOT LIKE`
- `OR`
- `IN`
- `GROUP BY`
- `ORDER BY`

{%comment%}
# API - Constructor Summary

{% highlight java %}
ISpaceIterator(com.j_spaces.core.IJSpace space, java.util.Collection collectionTemplates)
ISpaceIterator with default Iterator Buffer size (100 entries), without History property,
and Lease.FOREVER as the iterator lease.
ISpaceIterator(com.j_spaces.core.IJSpace space, java.util.Collection collectionTemplates,
int bufferSize, boolean withHistory, long lease)
ISpaceIterator Constructor
{% endhighlight %}

{: .table .table-bordered}
| Return Value | Method |
|:-------------|:-------|
| `void` | `cancel()` {% wbr %}Used by the lease holder to indicate that it is no longer interested in the iterator. |
| `long` | `getExpiration()`{% wbr %}Returns the absolute time that the lease will expire, represented as milliseconds from the beginning of the epoch, relative to the local clock. |
| `boolean` | `hasNext()`{% wbr %}Returns `true` if the iterator has more elements. |
| `net.jini.core.entry.Entry` | `next()`{% wbr %}Returns the next matching-template Entry in the iterator. |
| `net.jini.core.entry.Entry` | `next(long timeout)`{% wbr %}Blocking next with timeout -- returns the next matching-template Entry in the iterator, under the timeout limitation. |
| `void` | `notify(net.jini.core.event.RemoteEvent event)`{% wbr %}For internal use. |
| `void` | `renew`(long duration) {% wbr %}Used to renew a lease for an additional period of time, specified in milliseconds. |
| `net.jini.core.entry.Entry` | `snapshot()`{% wbr %} Returns a snapshot of the Entry returned by the last next call, as defined in section JS.2.6 of the [JavaSpaces specification](http://www.sun.com/software/jini/specs/js2_0.pdf#search=%22javaspaces%20specification%22). |

{%endcomment%}

## Initialization

When a `ISpaceIterator` is created, a match set is formulated. The match set initially contains all of the objects within the space that match one or more of the collection templates and are not locked by conflicting transactions (unless using the `Future` IteratorScope mode, i.e., no initial contents). Each element of the matched set will be returned at most once.

{%comment%}
## hasNext(), next() and next(timeout)

The`foreach` loop removes elements from the matched set and returns it to the caller. The iteration is said to be complete if the match set becomes empty or next calls limit (buffer size) has removed Entries from the match set. A `foreach` call returns `null` only if the iteration is complete.



## take() and Space Object Lease Expiration

A space object may be, but is not required to be, removed from the match set without being returned by a `next` call if it is removed from the space or is locked by a conflicting transaction. `ISpaceIterator` **does not remove** the object after it has been buffered.

{%endcomment%}

## Notifications

ISpaceIterator register each of the templates in the templates collection for notification. If a matching object was written to the space after the ISpaceIterator was created, the object will be added to the result set. An object that was locked under a conflicting transaction before or after the ISpaceIterator was created and the lock was released before the iteration was complete will also be added to the result set.

{%comment%}
A matching that arrived from a notification event will interrupt any blocking `next(timeout)` operation. If a take operation was called or an object lease timeout, the object will be removed from the next iteration result set.
{%endcomment%}

## Iterator Lease

In most cases, the iterator will be leased and the lease proxy object can be obtained by calling getting the `LeaseTime`. Cancelling or letting the lease expire will destroy the iterator; thus no notifications from here on will be accounted for, and all subsequent calls to `foreach` will return `null`. If there is a lease associated with the iterator, clients should not assume that completing the iteration will destroy it and should instead call cancel or let the lease expire when the end of the iteration is reached. The lease can be renewed by setting `LeaseTime` for an additional period of time. This duration is not added to the original lease, but is used to determine a new expiration time for the existing lease. If a lease has expired or has been canceled, a renewal is not allowed.

## Transactions

Iterating through the matched set does not lock the object. Objects that are under transaction and match the specified template/SQLQuery will not be included as part of the matched set.

{% comment %}
## snapshot

The snapshot method returns a snapshot of the Entry returned by the last next call (see section JS.2.6 of the [JavaSpaces specification](http://www.sun.com/software/jini/specs/js2_0.pdf#search=%22javaspaces%20specification%22)). If the last next call returned `null` or failed with an exception or error, the snapshot will throw an `IllegalStateException.` It is important to note that the `ISpaceIterator.snapshot()`, unlike the `JavaSpace.snapshot()`, does not throw a `RemoteException`.

{% tip %}
The `ISpaceIterator` uses the following `NotifyModifiers`:

- `NotifyModifiers.NOTIFY_WRITE` -- updates the Iterator with a new Entry.
- `NotifyModifiers.NOTIFY_TAKE and NotifyModifiers.NOTIFY_LEASE_EXPIRATION` -- removes an Entry from the Iterator.

Updates do affect the iterator.
{% endtip %}
{% endcomment %}


