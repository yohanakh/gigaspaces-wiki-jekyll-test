---
layout: post101
title:  Flash drive IMDG Storage
categories: XAP101TUT
parent: none
weight: 1600
---

<br>

{% section %}
{% column  width=10% %}
![flash-imdg.png](/attachment_files/subject/flash-imdg.png)
{% endcolumn %}
{%column width=90% %}
XAP 10 introduces a new storage model called BlobStore Storage Model, which allows an external storage medium (one that does not reside on the JVM heap) to store the IMDG data. This guide describes the general architecture and functionality of this storage model that is leveraging both on-heap, off-heap and SSD implementation, called `MemoryXtend`.
{% endcolumn %}
{% endsection %}

<br>


{%section%}
{%column width=30%  %}
{%youtube kAe-ZxFnIYc | XAP MemoryXtend %}
{%endcolumn%}

{%column width=30%  %}
[{%pdf%}](/download_files/White-Paper-ssd-V2.pdf)
This MemoryXtend white paper provides a high level overview of the technology and motivation behind MemoryXtend.
{%endcolumn%}

{%column width=30%  %}
[{%pdf%}](/download_files/XAP10–MemoryXtend Tutorial.pdf)
The MemoryXtend Tutorial describes how to experiment with MemoryXtend and comparing RAM based Data Grid with SSD based Data Grid.
{%endcolumn%}
{%endsection%}

<br>
{%learn%} {%currentadmurl%}/blobstore-overview.html{%endlearn%}

