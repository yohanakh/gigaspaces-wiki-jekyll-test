---
layout: post102
title:  Multi Site LAN Replication
categories: XAP102
parent: none
weight: 2300
---

<br>

{%section%}
{%column width=10% %}
![fifo-groups.png](/attachment_files/subject/multisite.png)
{%endcolumn%}
{%column width=90% %}
Multiple space replication is the ability to replicate state between different deployed spaces, i.e different cluster of space instances. Where each of the space instances of each of the spaces are reachable via network to the other. In some cases, this may even be across WAN using VPN or other mechanism to establish a VLAN.
{%endcolumn%}
{%endsection%}



{% info title=Licensing %}
The Gateway requires a separate license in addition to the GigaSpaces commercial license. Please contact [GigaSpaces Customer Support](http://www.gigaspaces.com/content/customer-support-services) for more details.
{% endinfo %}


<br>

{%fpanel%}

[Overview](./multi-space-replication-over-the-lan-or-vpn.html){%wbr%}
Establish data synchronization between multiple spaces which have direct network communication between each other.

[Space Bootstrapping](./replication-gateway-lan-bootstrapping-process.html){%wbr%}
Bootstrapping a space from another space via the gateway.

{%endfpanel%}

<br>

#### Additional Resources

[Multi Site Replication](./multi-site-replication-overview.html)