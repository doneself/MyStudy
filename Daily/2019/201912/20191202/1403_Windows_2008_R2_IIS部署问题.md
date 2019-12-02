# Windows 2008 R2 IIS部署问题

If you are *not* able to apply the [QFE from kb 980368](http://support.microsoft.com/kb/980368), instead of using the *runAllManagedModulesForAllRequests* solution as suggested in the accepted [answer](https://stackoverflow.com/a/12653278/29491), you should use the modules configuration with *preCondition=""* shown below to avoid the negative impact on static content as described in the blog posts [How asp.NET MVC Routing Works and its Impact on the Performance of Static Requests](http://blogs.msdn.com/b/tmarq/archive/2010/04/01/asp-net-4-0-enables-routing-of-extensionless-urls-without-impacting-static-requests.aspx) and [Don't use runAllManagedModulesForAllRequests="true" when getting your MVC routing to work](http://www.britishdeveloper.co.uk/2010/06/dont-use-modules-runallmanagedmodulesfo.html) and some of the comments on the answers.

[Scott Hanselman's blog post about runAllManagedModulesForAllRequests](http://www.hanselman.com/blog/BackToBasicsDynamicImageGenerationASPNETControllersRoutingIHttpHandlersAndRunAllManagedModulesForAllRequests.aspx) should add some weight to this argument. [Rick Strahl's](http://www.west-wind.com/weblog/) post [Caveats with the runAllManagedModulesForAllRequests in IIS 7/8](http://www.west-wind.com/weblog/posts/2012/Oct/25/Caveats-with-the-runAllManagedModulesForAllRequests-in-IIS-78) is the best explanation of the interaction between the settings I have found. The IIS documentation on the [module preCondition attribute](http://www.iis.net/learn/get-started/introduction-to-iis/iis-modules-overview#Precondition) is also worth a read.

Remember this configuration change is not necessary if you have applied the QFE as this behaviour becomes the default.

```
<system.webServer>
  <modules>
    <remove name="UrlRoutingModule-4.0" />
    <add name="UrlRoutingModule-4.0" type="System.Web.Routing.UrlRoutingModule" preCondition="" />
  </modules>
</system.webServer>
```
