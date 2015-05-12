
{: .table .table-bordered .table-condensed}
| Property name | Description | Default   |
|-----|---|--|
| com.gs.logging.disabled | If **true**, the default **gs_logging.properties** file will not be loaded and none of the GS log handlers will be set to the **LogManager**. | **false** |
| com.gs.logging.debug | To troubleshoot and detect which logging properties file was loaded and from which location, set the following system property to **true**. This property already exists in the scripts (for convenience) and by default is set to false.|**false**|
| line.separator | The GS logging formatter Line separator string.&nbsp; This is the value of the **line.separator** property at the moment that the **SimpleFormatter** was created. | |
|java.util.logging.config.file | It indicates file path to the Java logging file location. Use it to enable finest logging troubleshooting of various GigaSpaces Services. You may control this setting via the GS_LOGGING_CONFIG_FILE_PROP environment variable.| GSHOME\config\gs_logging.properties|
| Logging Categories | Refer to [Logging Categories](./logging.html#logging-categories) | |