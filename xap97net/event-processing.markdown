---
layout: post97
title:  Event Processing
categories: XAP97NET
parent: programmers-guide.html
weight: 2800
---

{%wbr%}

{%section%}
{%column width=10% %}
![Events-Message.jpg](/attachment_files/subject/Events-Message.png)
{%endcolumn%}
{%column width=90% %}
This section will guide you through event processing APIs and configuration on top of the space.
{%endcolumn%}
{%endsection%}




{%comment%}
{% summary %}This section will guide you through event processing APIs and configuration on top of the space{% endsummary %}

![archi_proce.jpg](/attachment_files/archi_proce.jpg)

<iframe width="640" height="360" src="//www.youtube.com/embed/GwLfDYgl6f8?feature=player_embedded" frameborder="0" allowfullscreen></iframe>
{%endcomment%}


<hr/>


- [Event Listener Container](./event-listener-container.html){%wbr%}
IEventListenerContainer is an interface that represents an abstraction for subscribing to, and receiving events over a space proxy.

- [Notify Container](./notify-container.html){%wbr%}
The notify event container wraps the space data event session API with event container abstraction.

- [Polling Container](./polling-container.html){%wbr%}
Allows you to perform polling receive operations against the space.

{%comment%}
- [Event Exception Listener](./event-exception-handler.html){%wbr%}
Describe the common Exception Event Listener and its different adapters.
{%endcomment%}

<hr/>



{%comment%}
{%children%}

![Net_polling_notify_cont.jpg](/attachment_files/dotnet/Net_polling_notify_cont.jpg)
{%endcomment%}