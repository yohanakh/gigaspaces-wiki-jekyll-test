
{: .table .table-bordered .table-condensed}
| Property name | Description | Default   |
|-----|---|--|
|com.gs.jms.enabled|If true it will register the jms administrated objects in the rmi registry| false|
|com.gs.jms.compressionMinSize | JMS - The minimum size (in bytes) which from where we start to compress the message body. e.g. if a 1 MB Text **JMSMessage** body is sent, and the **compressionMinSize** value is 500000 (0.5MB) then we will compress that message body (only), otherwise we will send (write) it as is. | 500000 |
|com.gs.jms.iterator.buffersize|The iterator buffer size used for the QueueBrowser.|1000 objects|
|com.gs.jms.use_mahalo| If true, when JMS clients use transacted sessions the JMS transactions will use the Mahalo Jini transaction manager, which expects the manager to be started.|false|
