---
layout: post101
title:  Processing Services
categories: XAP101NETTUT
weight: 400
parent: none
---


{%section%}
 {%column width=10% %}
 ![cassandra.png](/attachment_files/qsg/processing.png)
 {%endcolumn%}
 {%column width=90% %}
 {% summary   %} {% endsummary %}
 {%endcolumn%}
 {%endsection%}


In this part of the tutorial we will introduce you to the different processing services you can run on top of the space.
 XAP includes a set of built-in service components such as Task Execution and Messaging services, each implementing commonly used Enterprise integration patterns.
 It's purpose is to make the implementation of distributed applications on-top of the space simpler and less intrusive and allow you to easily build highly scalable and performing applications.

# Task Execution
Task Execution provides a fine-grained API for performing ad-hoc parallel execution of user defined tasks. This framework should be used in the following scenarios:

* When the tasks are defined by clients and can be changed or added while the data-grid servers are running.
* As a dynamic "stored procedure" enabling to execute complex multi stage queries or data manipulation where the data resides, thus enabling to send back only the end result of the calculation and avoid excess network traffic.
* Scatter/Gather pattern - when you need to perform aggregated operations over a cluster of distributed partitions.

{%comment%}
Task execution comes in two flavors:

- Java Tasks - In this mode you can pass Java code from the client to the cluster to be executed on the data grid nodes. The code is dynamically introduced to the server nodes classpath.
- Dynamic language tasks - Tasks can be defined using one of the dynamic languages supported by the JVM (JSR-223) and be compiled and executed on the fly. In this part of the tutorial we will not cover Dynamic language tasks.

{%learn%}{%currentneturl%}/dynamic-language-tasks.html{%endlearn%}


Java Tasks can be more efficient in terms of performance and tend to be more type-safe then dynamic tasks. Dynamic tasks on the other hand can be changed more frequently without causing class version conflicts and are more concise given the nature of dynamic languages..

{%info title=Tasks %}
- execute in a "broadcast" mode on all the primary cluster members concurrently and reduced to a single result on the client side.
- can execute directly on a specific cluster member using typical routing declarations.
- are completely dynamic both in terms of content and class definitions (the task class definition does not have to be defined within the space classpath).{%endinfo%}
{%endcomment%}


Here is an example of a task. We define a task that will collect all users that made a payment to a specific merchant:

{% inittab d1|top %}
{% tabcontent Task %}
{%highlight csharp%}
using System;
using System.Collections.Generic;

using GigaSpaces.Core;
using GigaSpaces.Core.Metadata;
using GigaSpaces.Core.Executors;

using xaptutorial.model;

[Serializable]
public class MerchantUserTask : ISpaceTask<HashSet<long?>> {
	public long? MerchantId;

	public MerchantUserTask(long? merchantId) {
		this.MerchantId = merchantId;
	}

	public HashSet<long?> Execute(ISpaceProxy spaceProxy, ITransaction tx)  {
		SqlQuery<Payment> query = new SqlQuery<Payment>( "MerchantId = ? ");
		query.SetParameter(1, MerchantId);

		Payment[] payments = spaceProxy.ReadMultiple<Payment>(query, int.MaxValue);
		HashSet<long?> userIds = new HashSet<long?>();

		// Eliminate duplicate UserId
		if (payments != null) {
			for (int i = 0; i < payments.Length; i++) {
				userIds.Add(payments[i].getUserId());
			}
		}
		return userIds;
	}
}
{%endhighlight%}
{% endtabcontent %}
{% tabcontent Execution %}
{%highlight csharp%}
public void executeTask()  {
	MerchantUserTask task = new MerchantUserTask(2);

    //Execute the task on a specific node using a specified routing value (2)
	HashSet<long?> result = proxy.Execute(task,2);
}
{%endhighlight%}
{% endtabcontent %}
{% endinittab %}

{%note%}
 A space task needs to be serializable because it is being serialized and reconstructed at the node.
{%endnote%}

{%comment%}
Task execution is asynchronous in nature, returning an AsyncFuture as the result of the execution allowing to get the result at a later stage in the code. AsyncFuture itself extends java.util.concurrent.Future that adds the ability to register a listener which will be called when the results are available.

Here is an example of a Future Listener:

{% inittab d2|top %}
{% tabcontent Async Listener %}
{%highlight csharp%}
public class AsyncListener implements AsyncFutureListener<HashSet<Integer>> {

     public void onResult(AsyncResult<HashSet<Integer>> result) {
          System.out.println("Listener received result");
     }
}
{%endhighlight%}
{% endtabcontent %}
{% tabcontent Execution %}
{%highlight csharp%}
public void executeAsyncTask() throws InterruptedException {
	MerchantUserTask task = new MerchantUserTask(2L);
	AsyncListener l = new AsyncListener();

	space.execute(task, l);
}
{%endhighlight%}
{% endtabcontent %}
{% endinittab %}

#### Task Routing
By nature, task execution is broad casted to all partitions in the space. You can route a task directly to one of the partitions of the space. Here is an example demonstrating how to route a task to a partition:

{%highlight csharp%}
public void executeTaskWithRouting() throws InterruptedException, ExecutionException {
     // Route the task to partion 2
     AsyncFuture<HashSet<Integer>> result = space.execute(task, 2);
}
{%endhighlight%}

There are other options available for task routing
.
{%learn%}{%currentneturl%}/task-execution-over-the-space.html{%endlearn%}

{%endcomment%}



# Distributed Task
A DistributedTask is a task that ends up executing more than once (concurrently) and returns a result that is a reduced operation of all the different executions.

In the example below we are creating a distributed task that finds all merchants with a specific category. Once all results are returned to the client, reduce is called and a list of all merchants is created.

{% inittab d3|top %}
{% tabcontent DistributedTask %}
{%highlight csharp%}
using System;
using System.Collections.Generic;

using GigaSpaces.Core;
using GigaSpaces.Core.Metadata;
using GigaSpaces.Core.Executors;

using xaptutorial.model;

[Serializable]
public class MerchantByCategoryTask : IDistributedSpaceTask<List<Merchant>, Merchant[]> {

	public ECategoryType CategoryType;

	public MerchantByCategoryTask(ECategoryType categoryType) {
		this.CategoryType = categoryType;
	}

	public Merchant[] Execute(ISpaceProxy spaceProxy, ITransaction tx)   {
		SqlQuery<Merchant> query = new SqlQuery<Merchant>( "Category = ?");
		query.SetParameter(1, CategoryType);
		return spaceProxy.ReadMultiple<Merchant>(query, int.MaxValue);
	}

	public List<Merchant> Reduce(SpaceTaskResultsCollection<Merchant[]> results){

		List<Merchant> list = new List<Merchant>();

		foreach (SpaceTaskResult<Merchant[]>  result in results) {
			if (result.Exception != null) {
				throw result.Exception;
			}

			foreach (Merchant res in result.Result) {
				list.Add (res);
			}
	    }
		return list;
	}
}
{%endhighlight%}
{% endtabcontent %}
{% tabcontent Execution %}
{%highlight csharp%}
public void executeDistributedTask(){
	MerchantByCategoryTask task = new MerchantByCategoryTask(
			ECategoryType.AUTOMOTIVE);

	//Execute the task on all the primary nodes with in the cluster
	List<Merchant> result = proxy.Execute(task);
}
{%endhighlight%}
{% endtabcontent %}
{% endinittab %}

{%comment%}
By default, the task is broad casted to all primary nodes. You can also execute a distributed task on selected nodes based on different routing values:
{%highlight csharp%}
    Merchant merchant = new Merchant();
    merchant.Id=2;
    List<Merchant> result = proxy.Execute(task, merchant);
{%endhighlight%}

XAP provides out of the box Aggregator Tasks.

{%learn%}{%currentneturl%}/aggregators.html{%endlearn%}
{%endcomment%}

{%comment%}
#### ExecutorBuilder
The executor builder allows to combine several task executions (both distributed ones and non distributed ones) into a seemingly single execution (with a reduce phase).

{%learn%}{%currentneturl%}/task-execution-over-the-space.html{%endlearn%}
{%endcomment%}

# Asynchronous Task

A space task can also be executed asynchronously with the corresponding `BeginExecute` `EndExecute` method. This follows the standard .NET asynchronous API, once the execution is complete the execute invoker is notified by the async result which is received from the `BeginExecute` method or to a supplied callback. This will be similar to executing a task in a separate thread, allowing to continue local process while waiting for the result to be calculated at the space nodes.

Here is an example that executes asynchronous using async result:

{%highlight csharp%}
public void executeDistributedTaskAsync()
{
	MerchantByCategoryTask task = new MerchantByCategoryTask(ECategoryType.AUTOMOTIVE);

	IAsyncResult<List<Merchant>> asyncResult = proxy.BeginExecute(task, null /*callback*/, null /*state object*/);
	//	...
	//This will block until the result execution has arrived
	asyncResult.AsyncWaitHandle.WaitOne();
	//Gets the actual result of the async execution
	List<Merchant> result = proxy.EndExecute(asyncResult);
}
{%endhighlight%}

{%learn%}{%currentneturl%}/task-execution-over-the-space.html{%endlearn%}

{%comment%}
# Space Based Remoting
The domain service host is used to host services within the hosting processing unit domain which are exposed for remote invocation. A service is an implementation of one or more interfaces which acts upon the service contract. Each service can be hosted by publishing it through the domain service host later to be invoked by a remote client.

Why would you use the space as the transport layer include:

- High availability - since the space by its nature (based on the cluster topology) is highly available, remote invocations get this feature automatically when using the space as the transport layer.
- Load-balancing - when using a space with a partitioned cluster topology, each remote invocation is automatically directed to the appropriate partition (based on its routing handler), providing automatic load-balancing.
- Performance - remote invocations are represented in fast internal XAP objects, providing fast serialization and transport over the net.
- Asynchronous execution - by its nature, remoting support is asynchronous, allowing for much higher throughput of remote invocations. XAP allows you to use asynchronous execution using Futures, and also provides synchronous support (built on top of it).


- Executor Based Remoting
The Executor Based Remoting executes synchronous or asynchronous calls between the client and the server. In this mode the client invocation executes a task that invokes the corresponding server method immediately when the call arrives at the server. The server must therefore be collocated with the space.

- Event Driven Remoting
Event Driven Remoting supports most of the above capabilities, but does not support map/reduce style invocations. In terms of implementation, it's based on the Polling Container feature, which means that it writes an invocation entry to the space which is later consumed by a polling container. Once taking the invocation entry from the space, the polling container's event handler delegates the call to the space-side service.

In this tutorial will look at an Executor based Remoting service.

#### Defining the contract
In order to support remoting, the first step is to define the contract between the client and the server. Here is an example of a payment service:
{%highlight csharp%}
using xaptutorial.model;

public interface IPaymentProcessor {

	Payment processPayment(Payment data);
}
{%endhighlight%}

#### Implement the Service
Next, an implementation of this contract needs to be provided. This implementation will "live" on the server side. Here is a sample implementation:
{%highlight csharp%}
using System;

using GigaSpaces.Core;
using GigaSpaces.XAP.Remoting;

using xaptutorial.model;

[SpaceRemotingService]
public class PaymentProcessor : IPaymentProcessor {

	public Payment processPayment(Payment payment) {
		Console.WriteLine("Processing payment ");
		return payment;
	}
}
{%endhighlight%}

#### Exporting the service
The service is exported to the server with the Spring configuration. Here is an example:
{%highlight xml%}
<!-- Scan the packages for annotations / -->
<context:component-scan base-package="xap.qsg" />

<!-- Enables using @RemotingService and other remoting related annotations -->
<os-remoting:annotation-support />

<!-- A bean representing a space (an IJSpace implementation) -->
<os-core:space id="space" url="/./xapTutorialSpace" />

<!-- Define the GigaSpace instance that the application will use to access the space -->
<os-core:giga-space id="xapTutorialSpace" space="space"/>

<os-remoting:service-exporter id="serviceExporter" />
{%endhighlight%}

#### Client side invocation
On the client side the remoting proxy is injected with the @ExecutorProxy annotation:
{%highlight csharp%}
public class RemoteService {
     @Autowired
     @Qualifier(IRemotingService.SPACE)
     private GigaSpace space;

     @ExecutorProxy
     private IPaymentProcessor paymentProcessor;

     public void executePaymentService() {
        Payment payment = paymentProcessor.processPayment(new Payment());
     }
}
{%endhighlight%}

{%learn%}{%currentneturl%}/space-based-remoting.html{%endlearn%}

{%endcomment%}



 