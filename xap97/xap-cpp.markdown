---
layout: post97
title:  CPP
categories: XAP97
parent: interoperability-overview.html
weight: 200
---

{%wbr%}

{%section%}
{%column width=10% %}
![apis.png](/attachment_files/subject/cpp.png)
{%endcolumn%}
{%column width=90% %}
The XAP c++ API has been designed to allow the same level of flexibility, usability and interoperability of the Java [POJO](./pojo-support.html) counterpart API for building scalable, low-latency SBA applications.
{%endcolumn%}
{%endsection%}

<hr/>


- [Overview](./cpp-overview.html){%wbr%}
An overview of the c++ XAP API.

- [The Space Interface](./cpp-space-interface.html){%wbr%}
An overview of the main capabilities provided by GigaSpaces C++ API

- [Mapping file](./cpp-api-mapping-file.html){%wbr%}
Elements that are available to be used in your gs.xml file and supported types.

- [Type Converter](./cpp-type-converter.html){%wbr%}
How to implement unsupported data types by creating user-defined packaging code.

- [Processing Unit](./cpp-processing-unit.html){%wbr%}
The c++ processing unit.

- [Code Generator](./cpp-api-code-generator.html){%wbr%}
CPP API Code Generator utility. Generates your header files using the gs.xml input files

- [gsxml Utility](./cpp-gsxml-utility.html){%wbr%}
The gsxml2cpp utility generates serializer code, created by the gs.xml file, allowing you to perform space operations.

- [Examples](./cpp-api-examples.html){%wbr%}
Examples

<hr/>

{%comment%}
To get started with GigaSpaces C++ API:

1. If you're not yet familiar with GigaSpaces space-based C++ API, it is recommended to get started with the [CPP API Hello World Example](./cpp-api-hello-world-example.html). In this example, you will learn how to use GigaSpaces main concepts and how to work with the space.
1. After you've learnt a bit about the space-based C++ API and Gigaspaces main concepts, you can now move to the [GigaSpaces CPP Processing Unit Example](./gigaspaces-cpp-processing-unit-example.html) , where you'll learn more advanced GigaSpaces concepts and build your SBA application using the C++ Processing Unit.
1. Other scenarios:
    - [Writing Existing CPP Class to Space](./writing-existing-cpp-class-to-space.html) -- learn how to save existing C++ classes in the space.
    - [CPP Type Converter](./cpp-type-converter.html) -- learn how to to work with data types that aren't supported by the GigaSpaces C++ API.

{% info title=See also: %}

- [Gigaspaces C++ API Documentation](http://www.gigaspaces.com/docs/cppdocs{% latestxaprelease %}/annotated.html)
- [CPP API Code Generator](./cpp-api-code-generator.html)
- [Supported C++ types](./cpp-api-mapping-file.html#type -- Supported Types)
{%endinfo%}


# Overview

GigaSpaces C++ applications may use the [CPP Processing Unit](./cpp-processing-unit.html), which utilize the concept of Space-Based Architecture (SBA) by allowing simple development, packaging and deployment of application services together with middleware services.

![cpp-SBA-system-archi.jpg](/attachment_files/cpp-SBA-system-archi.jpg)

The C++ Processing Unit runs as an independent service, allowing you to distribute and parallelize your processing on several machines, thus achieving higher performance, lower latency, and scalability.

{% refer %}To learn more about GigaSpaces C++ package, refer to the [GigaSpaces CPP API - Overview](./gigaspaces-cpp-api---overview.html) section.{% endrefer %}
{%endcomment%}
