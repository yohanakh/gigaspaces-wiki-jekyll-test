
{: .table .table-bordered .table-condensed}
| Property name | Description | Default   |
|-----|---|--|
| com.gigaspaces.start.httpPort | Webster http port definition | default 0 - free port |
| com.gigaspaces.start.httpServerRetries | Webster http port retries - if the initial HTTP port is in use, tries ports between **httpPort ..** and **httpPort+(N-1)** | default is **10**, for example: **initial port=1900** tries **1900**, **1901**, **... 1909** |
| com.gigaspaces.start.hostAddress | Webster host address. | default is **localhost** |
| com.gigaspaces.start.httpRoots | Webster root library locations. | Default includes XAP libraries, Jini libraries, etc. |
| com.gigaspaces.start.addHttpRoots | Additional Webster root library locations (appended to httpRoots). | gslib;gslibrequuired;deployroot |
| com.gs.browser.httpd.enabled | Boolean value. Setting this property to **true** indicates to start a Webster HTTPD server inside the Space Browser. | true|
| com.gs.embedded-services.httpd.port | Indicates to start Webster HTTPD in the specified port. By default, it uses an **9813** port or generated one if it is used. | 9813 |
