
{% highlight xml %}

<?xml version="1.0" encoding="utf-8"?>
<Settings>
	<!-- Location of XAP.NET -->
	<XapNet.Path>$(XapNet.SettingsFile)\..\..</XapNet.Path>

	<!-- Location of XAP.NET Installation -->
	<XapNet.Install.Path>$(XapNet.Path)\..</XapNet.Install.Path>

	<!-- Location of Configuration folder -->
	<XapNet.Config.Path>$(XapNet.Path)\Config</XapNet.Config.Path>

	<!-- Location of XAP Runtime files -->
	<XapNet.Runtime.Path>$(XapNet.Install.Path)\Runtime</XapNet.Runtime.Path>

	<!-- Location of JDK -->
	<XapNet.Runtime.JavaHome>$(XapNet.Runtime.Path)\Java</XapNet.Runtime.JavaHome>

	<!-- Log settings -->
	<XapNet.Logs.ConfigurationFile>$(XapNet.Config.Path)\Logs\gs_logging.properties</XapNet.Logs.ConfigurationFile>
	<XapNet.Logs.Path>$(XapNet.Path)\Logs</XapNet.Logs.Path>
	<XapNet.Logs.FileName>{date,yyyy-MM-dd~HH.mm}-gigaspaces-{service}-{host}-{pid}.log</XapNet.Logs.FileName>

    <!-- Lookup and Discovery options -->
    <XapNet.HostName>%COMPUTERNAME%</XapNet.HostName>
	<XapNet.Multicast.Enabled>true</XapNet.Multicast.Enabled>
	<XapNet.Groups>XAP-9.7.0-ga-NET-2.0.50727-x64</XapNet.Groups>
	<XapNet.Locators></XapNet.Locators>
	<XapNet.Zones></XapNet.Zones>

	<!-- Security options -->
	<XapNet.Security.Enabled>false</XapNet.Security.Enabled>

	<!-- Service Grid settings -->
	<XapNet.GsTools.ConfigFile>$(XapNet.Config.Path)\GsTools.config</XapNet.GsTools.ConfigFile>
	<XapNet.ServiceGrid.ConfigFile>$(XapNet.Config.Path)\ServiceGrid.config</XapNet.ServiceGrid.ConfigFile>
	<XapNet.GsAgent.ConfigFile>$(XapNet.Config.Path)\gs-agent.config</XapNet.GsAgent.ConfigFile>
	<XapNet.Gsc.ConfigFile>$(XapNet.Config.Path)\gsc.config</XapNet.Gsc.ConfigFile>
	<XapNet.Gsc.Memory.Initial>16</XapNet.Gsc.Memory.Initial>
	<XapNet.Gsc.Memory.Maximum>512</XapNet.Gsc.Memory.Maximum>
	<XapNet.Gsm.ConfigFile>$(XapNet.Config.Path)\gsm.config</XapNet.Gsm.ConfigFile>
	<XapNet.Gsm.Memory.Initial>16</XapNet.Gsm.Memory.Initial>
	<XapNet.Gsm.Memory.Maximum>512</XapNet.Gsm.Memory.Maximum>
	<XapNet.Lus.ConfigFile>$(XapNet.Config.Path)\lus.config</XapNet.Lus.ConfigFile>
	<XapNet.Lus.Memory.Initial>16</XapNet.Lus.Memory.Initial>
	<XapNet.Lus.Memory.Maximum>512</XapNet.Lus.Memory.Maximum>
</Settings>

{%endhighlight%}
