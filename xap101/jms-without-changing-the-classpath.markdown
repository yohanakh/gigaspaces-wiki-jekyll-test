---
layout: post101
title:  Using GigaSpaces JMS Without Changing the Classpath
categories: XAP101
parent: jms-advanced.html
weight: 600
---



A JMS application may use the XAP RMI registry to a acquire its JMS resources. In this case the application administrator may prefer not to include the GigaSpaces JAR files in the application's classpath. The GigaSpaces RMI registry specifies a Code Base where the application receives GigaSpaces's class information automatically.

In order for an application to use XAP JMS without having to include XAP JAR files in the classpath the application administrator has to make sure that:

1. The security policy contains:

{% highlight java %}
grant {
    permission java.security.AllPermission "", "";
};
{% endhighlight %}

For example, the security policy may be set to the policy file of GigaSpaces:

{% highlight java %}
-Djava.security.policy=<JSHOMEDIR>\policy\policy.all
{% endhighlight %}

1. The security manager is set to be the RMISecurityManager:

{% highlight java %}
-Djava.security.manager=java.rmi.RMISecurityManager
{% endhighlight %}
