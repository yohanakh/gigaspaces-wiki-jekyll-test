---
layout: post101
title:  Notify Container
categories: XAP101NET
parent: event-processing.html
weight: 200
---

<br>

{%section%}
{%column width=10% %}
![fifo-groups.png](/attachment_files/subject/pubsub.png)
{%endcolumn%}
{%column width=90% %}
The notify event container implements the [IEventListenerContainer](./event-listener-container.html) interface, and uses the Space inheritance support for notifications.
A notify event operation is mainly used when simulating Topic semantics.
{%endcolumn%}
{%endsection%}

<br>

{%fpanel%}

[Overview](./notify-container.html){%wbr%}
The notify event container wraps the Space data event session API with event container abstraction.

[Transaction support](./notify-container-transactions.html){%wbr%}
The notify container can be configured with transaction support, so the event action can be performed under a transaction.

{%endfpanel%}

