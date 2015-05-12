---
layout: post100
title:  Security Guide
categories: XAP100SEC

---

<br>


{% section %}
{% column  width=10% %}
![security.png](/attachment_files/subject/security.png)
{% endcolumn %}

{% column width=90% %}
This section provides an understanding of GigaSpaces XAP Security, where it fits in the GigaSpaces architecture, which components can be secured, and how to configure and customize the security depending on your application security requirements. XAP Security provides comprehensive support for securing your data, services, or both. XAP provides a set of authorities granting privileged access to data, and for performing operations on services.
{% endcolumn %}
{% endsection %}

<br>


{%fpanel%}

[Overview](./security.html){%wbr%}
XAP Security provides comprehensive support for securing your data, services, or both. XAP provides a set of authorities granting privileged access to data, and for performing operations on services.

[Concepts](./security-concepts.html){%wbr%}
Authentication, Encryption, Authenticity Validation, and Managing users and roles

[Authorities](./security-authorities.html){%wbr%}
System, Grid, Space and Monitor authorities

[Configuration](./security-configurations.html){%wbr%}
Configurations and defaults

[Directory Management](./programmatically-managing-the-security-directory.html){%wbr%}
User and Role directory API

[File Based](./default-file-based-security-implementation.html){%wbr%}
The default file-based users/roles directory; Overview, Getting Started, Configuration, and Custom Extensions

[Securing Components](./securing-xap-components.html){%wbr%}
GigaSpaces XAP has security built over the major “server” component - GSA, GSM, GSC and also Processing Unit with Space data. This section explains how security relates to each component and the configurations needed to securing your application.

[Administration](./security-administration.html){%wbr%}
This section explains the administration tools for managing XAP. The GUI provides a handy management tool for managing the users and roles, and comprehensive manageability of the secured components in the system.

[Hello World example](./securing-the-helloworld-example.html){%wbr%}
securing-the-helloworld-example.html

[Custom Security](./custom-security.html){%wbr%}
Customize security to meet your application requirements

[Spring Security](./spring-security-bridge.html){%wbr%}
Declarative Spring-based custom security bridge

{%endfpanel%}