# autofac自动绑定IService

``` csharp
builder.RegisterAssemblyTypes(typeof(BaseService).Assembly).AssignableTo<IService>().AsImplementedInterfaces().InstancePerRequest();
```

