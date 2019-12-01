# C# Nlog 配置使用

``` xml
<?xml version="1.0" encoding="utf-8" ?>
<nlog xmlns="http://www.nlog-project.org/schemas/NLog.xsd"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://www.nlog-project.org/schemas/NLog.xsd NLog.xsd"
      autoReload="true"
      throwExceptions="false"
      internalLogLevel="Off" internalLogFile="c:\temp\nlog-internal.log">

  <variable name="myvar" value="myvalue"/>

  <targets>
    <target xsi:type="File" name="DebugInfo" fileName="${basedir}/logs/Debug/${shortdate}.log"
            layout="${longdate} ${uppercase:${level}} ${message} ${exception:format=tostring}" />
    <!--<target xsi:type="File" name="ErrorInfo" fileName="${basedir}/logs/Error/${shortdate}.log"
            layout="${longdate} ${uppercase:${level}} ${message} ${exception:format=tostring}" />-->
    <target xsi:type="File" name="ErrorInfo"  fileName="${basedir}/logs/Error/${shortdate}.log"
            archiveFileName="${basedir}/logs/Error/${shortdate}-{####}.log" archiveNumbering="Sequence"
            archiveAboveSize="1024000"
            archiveEvery="Day"
            layout="${longdate} ${uppercase:${level}} ${message} ${exception:format=tostring}" />

    <target xsi:type="File" name="MsgInfo"  fileName="${basedir}/logs/Info/${shortdate}.log"
            archiveFileName="${basedir}/logs/Error/${shortdate}-{####}.log" archiveNumbering="Sequence"
            archiveAboveSize="1024000"
            archiveEvery="Day"
            layout="${longdate} ${uppercase:${level}} ${message} ${exception:format=tostring}" />

    <!--
    Write events to a file with the date in the filename.
    <target xsi:type="File" name="f" fileName="${basedir}/logs/${shortdate}.log"
            layout="${longdate} ${uppercase:${level}} ${message}" />
    -->
  </targets>

  <rules>
    <logger name="*" minlevel="Error" writeTo="ErrorInfo" />
    <logger name="*" level="Info" writeTo="MsgInfo" />
    <!--
    Write all events with minimal level of Debug (So Debug, Info, Warn, Error and Fatal, but not Trace)  to "f"
    <logger name="*" minlevel="Debug" writeTo="f" />
    -->
  </rules>
</nlog>
```
