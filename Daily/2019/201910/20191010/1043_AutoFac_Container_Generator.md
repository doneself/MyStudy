## AutoFac Container Generator

``` csharp
using System;
using System.Diagnostics;
using System.Reflection;
using Autofac;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace SomeTests
{
    public class TestBase 
    {
        private IContainer _autofacContainer;
        protected IContainer AutofacContainer
        {
            get
            {
                if (_autofacContainer == null)
                {
                    var builder = new ContainerBuilder();

                    // Repositories
                    builder.RegisterType<CompanyDataDb>().As<CompanyDataDb>().InstancePerLifetimeScope();

                    // Register the CompanyDataRepository for property injection not constructor allowing circular references
                    builder.RegisterType<CompanyDataRepository>().As<ICompanyDataRepository>()
                           .InstancePerLifetimeScope()
                           .PropertiesAutowired(PropertyWiringOptions.AllowCircularDependencies);

                    // Other wireups....

                    var container = builder.Build();

                    _autofacContainer = container;
                }

                return _autofacContainer;
            }
        }

        protected ICompanyDataRepository CompanyDataRepository
        {
            get
            {
                return AutofacContainer.Resolve<ICompanyDataRepository>();
            }
        }

        protected CompanyDataDb CompanyDataDb
        {
            get
            {
                return AutofacContainer.Resolve<CompanyDataDb>();
            }
        }
    }
}
```

