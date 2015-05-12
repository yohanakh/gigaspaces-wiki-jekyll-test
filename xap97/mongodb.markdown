---
layout: post97
title:  MongoDB Integration
categories: XAP97
parent: big-data.html
weight: 300
---



{%wbr%}

{%section%}
{%column width=10% %}
![mongodb.png](/attachment_files/subject/mongodb.png)
{%endcolumn%}
{%column width=90% %}
[MongoDB](http://www.mongodb.com/) is an open-source database used by companies of all sizes, across all industries and for a wide variety of applications. It is an agile database that allows schemas to change quickly as applications evolve, while still providing the functionality developers expect from traditional databases, such as secondary indexes, a full query language and strict consistency.

{%endcolumn%}
{%endsection%}

MongoDB is built for scalability, performance and high availability, scaling from single server deployments to large, complex multi-site architectures. By leveraging in-memory computing, MongoDB provides high performance for both reads and writes. MongoDB’s native replication and automated failover enable enterprise-grade reliability and operational flexibility.

{%wbr%}


- [Space Persistence](./mongodb-space-persistency.html){%wbr%}
A MongoDB Space Persistency Solution

- [Archive Handler](./mongodb-archive-operation-handler.html){%wbr%}
Archives space objects to MongoDB.


{%comment%}
{% summary %} A MongoDB Space Persistency Solution {% endsummary %}



[MongoDB](http://www.mongodb.org/) is a simple and popular open-source document-oriented NoSQL database.



# MongoDB Space Data Source and Space Synchronization Endpoint

GigaSpaces comes with built in implementations of [Space Data Source](./space-data-source-api.html) and [Space Synchronization Endpoint](./space-synchronization-endpoint-api.html)
 for MongoDB, called `MongoSpaceDataSource` and `MongoSpaceSynchronizationEndpoint`, respectively.

{% indent %}
![mongodbPersistence.jpg](/attachment_files/mongodbPersistence.jpg)
{% endindent %}



For information about the two see: [MongoDB Space Data Source](./mongodb-space-data-source.html) and [MongoDB Space Synchronization Endpoint](./mongodb-space-synchronization-endpoint.html).


For further details about the persistency APIs used see [Space Persistency](./space-persistency.html).




{%children%}

{%endcomment%}