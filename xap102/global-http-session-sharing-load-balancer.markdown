---
layout: post102
title:  Apache Load-Balancer
categories: XAP102
parent: global-http-session-sharing-overview.html
weight: 300
---


{% section %}
{% column width=10% %}
![counter-logo.jpg](/attachment_files/subject/loadbalancing.png)
{% endcolumn %}
{% column width=90% %}
{% summary %} {% endsummary %}
{% endcolumn %}
{% endsection %}





XAP comes with a built-in utility allowing you to dynamically update an Apache httpd web server load-balancing configuration, based on deployed web applications.

# Configuration

Here is an example configuration of the [apache httpd](http://httpd.apache.org)  to load-balance  web requests between the different web servers.

{%accordion id=acc1 %}
{%accord parent=acc1 | title=Step 1:  Install Apache httpd%}
Install [apache httpd](http://httpd.apache.org).
{%endaccord%}

{%accord parent=acc1 | title=Step 2:  Create HttpSession.conf %}
Create a file named `HttpSession.conf` located at <Apache HTTPD 2.2 root>\conf\gigaspaces
{%endaccord%}

{%accord parent=acc1 | title=Step 3: Configure HttpSession.conf %}

Place the following within the `HttpSession.conf` file. The `BalancerMember` should be mapped to different URLs of your web servers instances. With the example below we have Tomcat using port 8080 and Websphere using port 9080.

{%highlight xml%}
<VirtualHost *:8888>
  ProxyPass / balancer://HttpSession_cluster/
  ProxyPassReverse / balancer://HttpSession_cluster/

  <Proxy balancer://HttpSession_cluster>
     BalancerMember http://127.0.0.1:8080 route=HttpSession_1
     BalancerMember http://127.0.0.1:9080 route=HttpSession_2
  </Proxy>
</VirtualHost>
{%endhighlight%}

{% note %} The `127.0.0.1` IP should be replaced with IP addresses of the machine(s)/port(s) of WebSphere/Tomcat instances.{% endnote %}
{%endaccord%}

{%accord parent=acc1 | title=Step 4:  Configure httpd.conf %}
 Configure the `<Apache2.2 HTTPD root>\conf\httpd.conf` to have the following:

{%highlight xml%}
Include "/tools/Apache2.2/conf/gigaspaces/*.conf"

LoadModule proxy_module modules/mod_proxy.so
LoadModule proxy_balancer_module modules/mod_proxy_balancer.so
LoadModule proxy_http_module modules/mod_proxy_http.so
LoadModule status_module modules/mod_status.so

Listen 127.0.0.1:8888

ProxyPass /balancer !
<Location /balancer-manager>
	SetHandler balancer-manager

	Order deny,allow
	Deny from all
	Allow from 127.0.0.1
</Location>
{%endhighlight%}

{% note %}The `/tools/Apache2.2` folder name should be replaced with your correct Apache httpd location. \\ The `127.0.0.1` IP should be replaced with appropriate IP addresses of the machine that is running apache.{% endnote %}
{%endaccord%}

{%accord parent=acc1 | title=Step 5: Restart Apache%}


Once you have the space running, Websphere running, Tomcat running, and Apache httpd configured, restart the Apache http. On windows you can use its service.

![httpSessionSharing7.jpg](/attachment_files/httpSessionSharing7.jpg)
{%endaccord%}

{%accord parent=acc1 | title=Step 6: Apache httpd balancer console%}
Once you performed the above steps, access the following URL:
{%highlight console%}
http://127.0.0.1:8888/HttpSession
{%endhighlight%}
You should have the web application running. Any access to the web application will be routed between Websphere and Tomcat. You can check this by accessing the Apache httpd balancer console:
{%highlight console%}
http://127.0.0.1:8888/balancer-manager
{%endhighlight%}

![httpSessionSharing6.jpg](/attachment_files/httpSessionSharing6.jpg)

You can shutdown Websphere or Tomcat and later restart these. Your web application will not lose its session data.
{%endaccord%}
{%endaccordion%}

<br/>

# Multi-Site Deployment

When deploying the [multi-site example](/sbp/wan-replication-gateway.html) you should change the `shiro.ini` for each site to match the local site Space URL. For example, to connect to the DE space you should have the web application use a `shiro.ini` with the following:

{%highlight java%}
connector.url = jini://*/*/wanSpaceDE?groups=DE
{%endhighlight%}

To connect to the US space you should have the web application use a `shiro.ini` with the following:

{%highlight java%}
connector.url = jini://*/*/wanSpaceUS?groups=US
{%endhighlight%}

# Library dependencies

Developers should include the following dependencies in pom.xml file.

{%highlight xml%}

	<repositories>
		<repository>
			<id>org.openspaces</id>
			<name>OpenSpaces</name>
			<url>http://maven-repository.openspaces.org</url>
			<releases>
				<enabled>true</enabled>
				<updatePolicy>daily</updatePolicy>
				<checksumPolicy>warn</checksumPolicy>
			</releases>
			<snapshots>
				<enabled>true</enabled>
				<updatePolicy>always</updatePolicy>
				<checksumPolicy>warn</checksumPolicy>
			</snapshots>
		</repository>
	</repositories>
	
	<dependency>
			<groupId>com.gigaspaces.httpsession</groupId>
			<artifactId>gs-runtime</artifactId>
			<version>{%version maven-version %}</version>
	</dependency>

	<dependency>
			<groupId>com.gigaspaces.httpsession</groupId>
			<artifactId>gs-session-manager</artifactId>
			<version>{%version maven-version %}</version>
	</dependency>
{%endhighlight%}

