---
layout: post100
title:  Data
categories: XAP100SEC
parent: securing-xap-components.html
weight: 100
---


{% summary %}{% endsummary %}

# Secured Space

A secured embedded Space protects access (to data) which is granted only to users with sufficient privileges. When a remote Space proxy connects to a secured Space, it must provide security credentials (usually username and password - see [Custom Security](./custom-security.html) for extensions).

{% inittab remote_space|top %}
{% tabcontent Namespace %}

{% highlight xml %}
<os-core:space-proxy id="space" name="space">
    <os-core:security username="sa" password="adaw@##$" />
</os-core:space-proxy>
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Plain XML %}

{% highlight xml %}
<bean id="space" class="org.openspaces.core.space.SpaceProxyFactoryBean">
    <property name="name" value="space" />
    <property name="securityConfig">
        <bean class="org.openspaces.core.space.SecurityConfig">
            <property name="username" value="sa" />
            <property name="password" value="adaw@##$" />
        </bean>
    </property>
</bean>
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Code %}

{% highlight java %}
UrlSpaceConfigurer urlSpaceConfigurer = new UrlSpaceConfigurer("jini://*/*/space").userDetails("sa", "adaw@##$");
GigaSpace gigaSpace = new GigaSpaceConfigurer(urlSpaceConfigurer).gigaSpace();
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

An embedded Space may be configured with internal services (Space filters, Notify/Polling Containers, etc.) which must have privileges to operate on the embedded Space. These privileges are propagated by the security credentials provided when creating a Space.

{% inittab embedded_space|top %}
{% tabcontent Namespace %}

{% highlight xml %}
<os-core:embedded-space id="space" name="space">
    <os-core:security username="sa" password="adaw@##$" />
</os-core:embedded-space>
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Plain XML %}

{% highlight xml %}
<bean id="space" class="org.openspaces.core.space.EmbeddedSpaceFactoryBean">
    <property name="name" value="space" />
    <property name="securityConfig">
        <bean class="org.openspaces.core.space.SecurityConfig">
            <property name="username" value="sa" />
            <property name="password" value="adaw@##$" />
        </bean>
    </property>
</bean>
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Code %}
The security credentials can be either be supplied as an `UserDetails` object or in its simpler form of two Strings (username and password).
These will be used to _implicitly_ create a **`secured`** Space, with security privileges being propagated to internal services.

{% highlight java %}
UrlSpaceConfigurer urlSpaceConfigurer = new UrlSpaceConfigurer("/./space").userDetails("user", "password");
GigaSpace gigaSpace = new GigaSpaceConfigurer(urlSpaceConfigurer).gigaSpace();
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

An embedded Space with no internal services, can be simply configured as secured.

{% inittab simple_embedded_space|top %}
{% tabcontent Namespace %}

{% highlight xml %}
<os-core:embedded-space id="space" name="space">
    <os-core:security secured="true" />
</os-core:embedded-space>
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Plain XML %}

{% highlight xml %}
<bean id="space" class="org.openspaces.core.space.EmbeddedSpaceFactoryBean">
    <property name="name" value="space" />
    <property name="secured" value="true" />
</bean>
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Code %}
The **`secured`** Space URL property indicates that the Space being created should be secured.

{% highlight java %}
UrlSpaceConfigurer urlSpaceConfigurer = new UrlSpaceConfigurer("/./space?secured");
GigaSpace gigaSpace = new GigaSpaceConfigurer(urlSpaceConfigurer).gigaSpace();
{% endhighlight %}

The **`secured`** URL property is also exposed as a convenient `.secured(true)` method call.

{% highlight java %}
UrlSpaceConfigurer urlSpaceConfigurer = new UrlSpaceConfigurer("/./space").secured(true);
GigaSpace gigaSpace = new GigaSpaceConfigurer(urlSpaceConfigurer).gigaSpace();
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

For security reasons, you may not want to expose the security credentials in your processing unit XML (pu.xml). These properties can be supplied as deploy time properties (bean level properties).

# Processing Unit


A processing unit {%currentjavanet ./the-processing-unit-overview.html%} by itself is not secured. It inherits its security from the managing GSM and GSC. These protect the processing unit from being restarted, relocated, destroyed, and undeployed.

A processing unit (for example a feeder application) may access a secured Space using a remote Space proxy.

{% highlight xml %}
<os-core:space-proxy id="mySpace" name="mySpace">
    <os-core:security username="sa" password="adaw@##$" />
</os-core:space-proxy>
{% endhighlight %}

The `username` and `password` can also be supplied using a `pu.properties` file supplied during deployment. If these are supplied, they will be used to _implicitly_ connect to a **`secured`** Space, returning an authenticated proxy for this user.

{% highlight java %}
#pu.properties
security.username=user
security.password=password
{% endhighlight %}

The `security.username` and `security.password` are constant property keys. If you would like to set your own property placeholders, e.g. $\{mySpace.username\} and $\{mySpace.password\}, you will need to use plain XML configuration. These properties would then need to be injected at deploy time, by some property resolver.

{% highlight xml %}
<bean id="mySpace" class="org.openspaces.core.space.SpaceProxyFactoryBean">
    <property name="name" value="mySpace" />
    <property name="securityConfig">
        <bean class="org.openspaces.core.space.SecurityConfig">
            <property name="username" value="${myusername}" />
            <property name="password" value="${mypassword}" />
        </bean>
    </property>
</bean>

Using the CLI deploy command embed the username and password matching the placeholders given in the pu.xml:
> gs deploy -properties embed://myusername=testing;mypassword=1234 myPU.jar
{% endhighlight %}

## Protecting User/Password {% exclamation %}

Of course, having the username and password exposed (in pu.xml/pu.properties) isn't that "secure". A preferred usage would be to supply the credentials **during deployment**. The _UI_, _CLI_ and _Admin API_ provide a comprehensive support for deploying a secured processing unit (see [Security Administration](./security-administration.html)).

Here is how the CLI deploy command would look like:

{% highlight xml %}
<bean id="mySpace" class="org.openspaces.core.space.SpaceProxyFactoryBean">
    <property name="name" value="mySpace" />
</bean>

Using the CLI deploy command supply username and password using the -user and -password.
> gs deploy -secured -user testing -password 1234 myPU.jar
{% endhighlight %}

# Local Cache



The Local cache {%currentjavanet local-cache.html%} is a read-only service on top of a remote Space. Thus, the local cache "creator" needs to have **Read** privileges.
Security is enforced by the remote Space, and the proxy should be acquired by supplying the username and password.

{% inittab localcacheview|tablocation=top %}
{% tabcontent  Local Cache Configurer %}

{% highlight java %}
UrlSpaceConfigurer urlSpaceConfigurer = new UrlSpaceConfigurer("jini://*/*/space").userDetails("user", "password");
GigaSpace remoteSpace = new GigaSpaceConfigurer(urlSpaceConfigurer).gigaSpace();

LocalCacheSpaceConfigurer configurer = new LocalCacheSpaceConfigurer(remoteSpace.getSpace()).updateMode(UpdateMode.PULL);
GigaSpace localCache = new GigaSpaceConfigurer(configurer.localCache()).gigaSpace();
{% endhighlight %}

{% endtabcontent %}
{% tabcontent  Local Cache Namespace %}

{% highlight java %}
<os-core:space-proxy id="remoteSpace" name="space" >
    <os-core:security username="user" password="password"/>
</os-core:space-proxy>

<os-core:local-cache id="localCacheSpace" space="remoteSpace" update-mode="PULL"/>

<!--
 OpenSpaces simplified Space API built on top of IJSpace/JavaSpace.
-->
<os-core:giga-space id="localCache" space="localCacheSpace"/>
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

# Local View



Similar to a Local Cache, the Local View {%currentjavanet local-view.html%} is a read-only service on top of a remote Space. Here, the cache is limited to Views. Thus, the local view "creator" needs to have **Read** privileges for the specific views. For example, needs to have **Read** privileges for both `Trade` and `Stock` classes, otherwise access will be denied.

{% inittab localcacheview|tablocation=top %}
{% tabcontent  Local View Configurer %}

{% highlight java %}
UrlSpaceConfigurer urlSpaceConfigurer = new UrlSpaceConfigurer("jini://*/*/space").userDetails("user", "password");
GigaSpace remoteSpace = new GigaSpaceConfigurer(urlSpaceConfigurer).gigaSpace();

LocalViewSpaceConfigurer configurer = new LocalViewSpaceConfigurer(remoteSpace.getSpace())
 .addView(new View(Trade.class, "quantity = 20"))
 .addView(new View(Stock.class, "stockId => 10"));

GigaSpace localView = new GigaSpaceConfigurer(configurer.localView()).gigaSpace();
{% endhighlight %}

{% endtabcontent %}
{% tabcontent  Local View Namespace %}

{% highlight xml %}
<os-core:space-proxy id="remoteSpace" name="space" >
   <os-core:security username="user" password="password"/>
</os-core:space-proxy>

<os-core:local-view id="localViewSpace" space="space">
   <os-core:view-query where="quantity = 20" class="...Trade"/>
   <os-core:view-query where="stockId => 10" class="...Stock"/>
</os-core:local-view>

<!--
 OpenSpaces simplified Space API built on top of IJSpace/JavaSpace.
-->
<os-core:giga-space id="localView" space="localViewSpace"/>
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

# Space Filters



Space Filters {%currentjavanet the-space-filters.html%} are interceptors inside the XAP Space which allow implementation of user-defined logic based on Space events. Some filters need to perform operations on the embedded Space. If secured, the filter needs to have sufficient privileges for its operations.

The username and password supplied when creating a Space, will be used to _implicitly_ create a **`secured`** Space. The security privileges of the specified user will be propagated to the Filter. If the user has **Read** privileges, then the filter will be able to perform a `space.read(..)` on its embedded Space.

#### Before Authentication operation

A filter can be registered for `before-authentication` events. Before a client tries to authenticate, any filter with the `before-authentication` operation-code will be invoked. The `SpaceContext` supplied as part of the call holds a `SecurityContext` that has the `UserDetails` object.

{% inittab filters|tablocation=top %}
{% tabcontent  Namespace %}
The following Spring configuration registers this filter for `before-authentication` (6) operation:

{% highlight xml %}
<bean id="simpleISpaceFilter" class="eg.SimpleISpaceFilter" />

<os-core:embedded-space id="space" name="space">
    <os-core:security secured="true"/>
    <os-core:space-filter>
        <os-core:filter ref="simpleISpaceFilter" />
        <os-core:operation code="6" />
        ...
    </os-core:space-filter>
</os-core:embedded-space>
{% endhighlight %}

{% endtabcontent %}
{% tabcontent  Annotations %}
An example of a simple POJO filter using annotations:

{% highlight xml %}
<bean id="simpleFilter" class="eg.SimpleFilter" />

<os-core:embedded-space id="space" name="space">
	<os-core:security secured="true"/>
	<os-core:annotation-adapter-filter priority="1">
		<os-core:filter ref="simpleFilter" />
	</os-core:annotation-adapter-filter>
</os-core:embedded-space>
{% endhighlight %}

**Note** that the annotated method must have the `SpaceContext` as a parameter.

{% highlight java %}
//Delegate Filter
public class SimpleFilter {

    @BeforeAuthentication
    public void beforeAuthenticationMethod(SpaceContext context) {
        SecurityContext securityContext = context.getSecurityContext();
        UserDetails user = securityContext.getUserDetails();
        AuditDetails audit = securityContext.getAuditDetails();
        System.out.println("user: " + user.getUsername() + " connecting from host: " + audit.getHost());
    }

    ...
}
{% endhighlight %}

{% endtabcontent %}
{% tabcontent  Method listings %}
The following Spring configuration XML shows how the filter can be configured, using explicit method listings. (In this case, annotations are not required.)
Note the `before-authentication` method adapter.

{% highlight xml %}
<bean id="simpleFilter" class="eg.SimpleFilter" />

<os-core:embedded-space id="space" name="space">
    <os-core:security secured="true"/>
    <os-core:method-adapter-filter before-authentication="beforeAuthenticationMethod">
        <os-core:filter ref="simpleFilter"/>
    </os-core:method-adapter-filter>
</os-core:embedded-space>
{% endhighlight %}

{% endtabcontent %}
{% tabcontent  Embedded-space operations %}

_Implicitly_ create a **`secured`** Space, with security privileges being propagated to the filter.
These privileges need to be sufficient for operations being perform by the filter on the embedded Space.

{% highlight xml %}
<!-- pu.xml -->
<bean id="simpleFilter" class="eg.SimpleFilter" />

<os-core:embedded-space id="space" name="space">
   <os-core:security username="user" password="password"/>
   <os-core:method-adapter-filter filter-init="init"
                                  before-write="beforeWrite">
        <os-core:filter ref="simpleFilter"/>
   </os-core:method-adapter-filter>
</os-core:embedded-space>
{% endhighlight %}

The filter acquires a GigaSpaces reference on filter initialization. Now the filter can perform operations on the embedded secured Space.

{% highlight java %}
public class SimpleFilter {

    GigaSpace gigaSpace;

    @OnFilterInit
    void init(IJSpace space) {
        gigaSpace= new GigaSpaceConfigurer(space).gigaSpace();
    }

    @BeforeWrite
    public void beforeWrite(Data data) {
        int seq = gigaSpace.count(new Data()); //Needs 'Read' privileges for 'count' operation
        data.setSeq( seq++);
        data.setTimestamp( new Date());
    }
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

# Custom Access Control

Custom Access control using Space Filters allows for access decisions based on user/role/data relationships. The `SpaceContext` filter invocation parameter holds the `SecurityContext` of the current operation. This context provides you with `UserDetails`, the `Authentication` and `AuditDetails`. Based on these, you can enforce custom access decisions (e.g. allow or disallow the operation).

{% info %}
Note that the `SpaceContext` may be `null` in cases related to replication/recovery and filter operations such as "`notify-trigger`". In these cases, there is no user context.
{%endinfo%}

The filter can be declared just like any other filter, but note that the `priority` plays a role in the order of filter execution. Default priority is zero.

{% highlight xml %}
<bean id="customAccessControlFilter" class="example.CustomAccessControlFilter" />

<os-core:embedded-space id="space" name="space">
	<os-core:security secured="true"/>
	<os-core:annotation-adapter-filter priority="0">
		<os-core:filter ref="customAccessControlFilter" />
	</os-core:annotation-adapter-filter>
</os-core:embedded-space>
{% endhighlight %}

Usage examples:

{% inittab customaccess|tablocation=top %}
{% tabcontent  Access based on user name %}

{% highlight java %}
public class CustomAccessControlFilter {
    ...
    @BeforeRead
    public void beforeRead(Account account, int operationCode, SpaceContext context) {
        SecurityContext securityContext = context.getSecurityContext();
        UserDetails user = securityContext.getUserDetails();

        /*
         * only owner of an account can have access to his/her record data
         */
        if (!user.getUsername().equals(account.getOwner())) {
            throw new AccessDeniedException("you are not the account owner!");
        }
    }
...
}
{% endhighlight %}

{% endtabcontent %}
{% tabcontent  Access based on role & field data %}

{% highlight java %}
public class CustomAccessControlFilter {
    ...
    @BeforeWrite
    public void beforeWrite(Account account, int operationCode, SpaceContext context) {
        SecurityContext securityContext = context.getSecurityContext();
        GrantedAuthorities authorities = securityContext.getAuthentication().getGrantedAuthorities();

        /*
         * "accountants" can only create an account with an initial balance of $500
         */
        if (authorities.isUserInRole("accountants") && account.getBalance() > 500) {
            throw new AccessDeniedException("don't be greedy!");
        }
    }
...
}
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

# Task Execution over the Space



Tasks {%currentjavanet task-execution-over-the-space.html%} can be executed in a collocated asynchronous manner within the Space (processing unit with an embedded Space). To execute a task, you must have **Execute** privileges. Execution can be restricted to certain tasks by applying the 'Class-Filter'. There is no need to define specific privileges for operations being performed by the task on the Space.

Here is a simple implementation of a task that performs a 'count' operation on the space.

{% highlight java %}
private static final class MyTask implements Task<Integer> {
   @TaskGigaSpace
   transient GigaSpace gigaSpace;

   public Integer execute() throws Exception {
      return gigaSpace.count(null,null);
   };
}
{% endhighlight %}

While executed tasks are effective when collocated, you may require operations on the Cluster.

{% highlight java %}
GigaSpace clustered = gigaSpace.getClustered();
{% endhighlight %}

{% info %}
Space operations performed from +within+ the task are guarded by a _temporary_ trust available throughout the life-cycle of the task. If you are trying to enforce custom access control, the `SecurityContext` will need to be extracted in a `before-execute` filter call.
{% endinfo %}

# Executors Based Remoting

Executor Remoting {%currentjavanet executor-based-remoting.html %}allows you to use remote invocations of POJO services, with the Space as the transport layer using OpenSpaces Executors. To invoke a service method, you must have **Execute** privileges for class `org.openspaces.remoting.ExecutorRemotingTask`.



# Event Driven Remoting


[Event Driven Remoting]({%currentjavaurl%}/event-driven-remoting.html) allows you to use remote invocations of POJO services, with the space as the transport layer using a polling container on the space side to process the invocations. Under the wires, event driven remoting uses the Space write and take capabilities. Thus, you must have **Write* and *Take** privileges (at both ends) for class `org.openspaces.remoting.EventDrivenSpaceRemotingEntry`.



# JDBC Driver

GigaSpaces allows applications to connect using a [JDBC driver]({%currentjavaurl%}/jdbc-driver.html). A GigaSpaces JDBC driver accepts SQL statements, translates them to Space operations, and returns standard result sets. To acquire a connection to a remote secured space, provide the credentials (username and password) as parameters to the connection.

{% highlight java %}
Class.forName("com.j_spaces.jdbc.driver.GDriver").newInstance();
String url = "jdbc:gigaspaces:url:jini://*/*/space";
Connection conn = DriverManager.getConnection(url, "user", "password");
Statement st = conn.createStatement();
...
{% endhighlight %}



{% refer %}
An alternative way of querying the Space using SQL syntax is the [SQLQuery]({%currentjavaurl%}/query-sql.html) class, with a privileged GigaSpace proxy.
{%endrefer%}