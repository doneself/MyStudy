# Simple Injector 自动注册

缺点：继承的接口不能多从继承

``` csharp
var repositoryAssembly = typeof(SqlUserRepository).Assembly;

var registrations =
    from type in repositoryAssembly.GetExportedTypes()
    where type.Namespace.StartsWith("MyComp.MyProd.DAL")
    from service in type.GetInterfaces()
    select new { service, implementation = type };

foreach (var reg in registrations) {
    container.Register(reg.service, reg.implementation, Lifestyle.Transient);
}
```

