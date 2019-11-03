# WebApi接口安全性 接口权限调用、参数防篡改防止恶意调用

# 背景介绍

最近使用WebApi开发一套对外接口，主要是数据的外送以及结果回传，接口没什么难度，采用WebApi+EF的架构简单创建一个模板工程，使用template生成一套WebApi接口，去掉put、delete等操作，修改一下就可以上线。这些都不在话下，反正网上一大堆教程，随便找那个step by step做下来就可以了。

然后发布上线后，接口是放在外网，面临两个问题：

1.  如何保证接口的调用的合法性
2.  **如何保证接口及数据的安全性**

其实这两个问题是相互结合的，先保证合法，然后在合法基础上保证请求的唯一性，避免参数被篡改。

鉴于接口上线期限紧迫，结合众多案例，先解决掉接口调用数据的安全性问题，这里采用了RSA报文加解密的方案，保证数据安全和防止接口被恶意调用以及参数篡改的问题。

本文参考博客园多篇博文，内容多有引用，文末附有参照博文的地址。

以下为正文！

# 正文

## 首先，接口面临的问题：

1.  ~请求来源(身份)是否合法(部分解决，后续在处理)~？
2.  请求参数被篡改？
3.  请求的唯一性(不可复制)，防止请求被恶意攻击

## 解决方案：

1.  参数加密： 客户端和服务端参数采用RSA加密后传递，原则上只有**持有私钥的服务端**才能解密**客户端公钥加密**的参数，避免了参数篡改的问题
2.  请求签名：采用一套签名算法，对请求进行签名验证，保证请求的唯一性

这里参照了[WebAPi使用公钥私钥加密介绍和使用](https://www.cnblogs.com/clly/p/7384008.html) 一文，进行公钥私钥加解密的处理

**先说服务端：**

### 扩展 MessageProcessingHandler

先看一下 MessageProcessingHandler的介绍：

``` csharp
#region 程序集 System.Net.Http, Version=4.2.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a
// C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.7.2\System.Net.Http.dll
#endregion

using System.Threading;
using System.Threading.Tasks;

namespace System.Net.Http
{
    //
    // 摘要:
    //     仅对请求和/或响应消息进行一些小型处理的处理程序的基类。
    public abstract class MessageProcessingHandler : DelegatingHandler
    {
        //
        // 摘要:
        //     创建的一个实例 System.Net.Http.MessageProcessingHandler 类。
        protected MessageProcessingHandler();
        //
        // 摘要:
        //     创建的一个实例 System.Net.Http.MessageProcessingHandler 具有特定的内部处理程序类。
        //
        // 参数:
        //   innerHandler:
        //     内部处理程序负责处理 HTTP 响应消息。
        protected MessageProcessingHandler(HttpMessageHandler innerHandler);

        //
        // 摘要:
        //     处理每个发送到服务器的请求。
        //
        // 参数:
        //   request:
        //     要处理的 HTTP 请求消息。
        //
        //   cancellationToken:
        //     可由其他对象或线程用以接收取消通知的取消标记。
        //
        // 返回结果:
        //     已处理的 HTTP 请求消息。
        protected abstract HttpRequestMessage ProcessRequest(HttpRequestMessage request, CancellationToken cancellationToken);
        //
        // 摘要:
        //     处理来自服务器的每个响应。
        //
        // 参数:
        //   response:
        //     要处理的 HTTP 响应消息。
        //
        //   cancellationToken:
        //     可由其他对象或线程用以接收取消通知的取消标记。
        //
        // 返回结果:
        //     已处理的 HTTP 响应消息。
        protected abstract HttpResponseMessage ProcessResponse(HttpResponseMessage response, CancellationToken cancellationToken);
        //
        // 摘要:
        //     异步发送 HTTP 请求到要发送到服务器的内部处理程序。
        //
        // 参数:
        //   request:
        //     要发送到服务器的 HTTP 请求消息。
        //
        //   cancellationToken:
        //     可由其他对象或线程用以接收取消通知的取消标记。
        //
        // 返回结果:
        //     表示异步操作的任务对象。
        //
        // 异常:
        //   T:System.ArgumentNullException:
        //     request 是 null。
        protected internal sealed override Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken);
    }
}
```
扩展这个类的目的是**解密参数**，其实也可以推迟到Action过滤器中做，但是还是觉得时机上在这里处理比较合适。具体的建议了解一下WebApi消息管道以及扩展过滤器的相关文章，本文不再延伸。

下面是扩展的实现代码：

``` csharp
/// <summary>
    /// 请求预处理,报文解密
    /// </summary>
    /// <seealso cref="System.Net.Http.MessageProcessingHandler"/>
    public class ArgDecryptMessageProcesssingHandler : MessageProcessingHandler
    {

        /// <summary>
        /// 处理每个发送到服务器的请求。
        /// </summary>
        /// <param name="request">          要处理的 HTTP 请求消息。</param>
        /// <param name="cancellationToken">可由其他对象或线程用以接收取消通知的取消标记。</param>
        /// <returns>已处理的 HTTP 请求消息。</returns>
        protected override HttpRequestMessage ProcessRequest(HttpRequestMessage request, CancellationToken cancellationToken)
        {
            var contentType = request.Content.Headers.ContentType;

            //swagger请求直接跳过不予处理
            if (request.RequestUri.AbsolutePath.Contains("/swagger"))
            {
                return request;
            }

            //获得平台私钥
            string privateKey = Common.GetRsaPrivateKey();

            //获取Get中的Query信息,解密后重置请求上下文
            if (request.Method == HttpMethod.Get)
            {
                string baseQuery = request.RequestUri.Query;
                if (!string.IsNullOrEmpty(baseQuery))
                {
                    baseQuery = baseQuery.Substring(1);
                    baseQuery = Regex.Match(baseQuery, "(sign=)*(?<sign>[\\S]+)").Groups[2].Value;
                    baseQuery = RsaHelper.RSADecrypt(privateKey, baseQuery);
                    var requestUrl = $"{request.RequestUri.AbsoluteUri.Split('?')[0]}?{baseQuery}";
                    request.RequestUri = new Uri(requestUrl);
                }

            }

            //获取Post请求中body中的报文信息,解密后重置请求上下文
            if (request.Method == HttpMethod.Post)
            {
                string baseContent = request.Content.ReadAsStringAsync().Result;
                baseContent = Regex.Match(baseContent, "(sign=)*(?<sign>[\\S]+)").Groups[2].Value;
                baseContent = RsaHelper.RSADecrypt(privateKey, baseContent);
                request.Content = new StringContent(baseContent);
                //此contentType必须最后设置 否则会变成默认值
                request.Content.Headers.ContentType = contentType;
            }

            return request;
        }

        /// <summary>
        /// 处理来自服务器的每个响应。
        /// </summary>
        /// <param name="response">         要处理的 HTTP 响应消息。</param>
        /// <param name="cancellationToken">可由其他对象或线程用以接收取消通知的取消标记。</param>
        /// <returns>已处理的 HTTP 响应消息。</returns>
        protected override HttpResponseMessage ProcessResponse(HttpResponseMessage response, CancellationToken cancellationToken)
        {
            return response;
        }
    }
```

获取平台私钥那里，实际上可以针对不同的接口调用方单独一个，另起一篇在介绍。

然后找到解决方案【App\_Start】目录下的 WebApiConfig类，在里面添加如下代码，启用消息处理扩展类：

``` csharp
public static void Register(HttpConfiguration config)
        {
           

            // Web API 路由
            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );
            config.MessageHandlers.Add(new ArgDecryptMessageProcesssingHandler());


        }
```

### 扩展 ActionFilterAttribute

> 注意！注意！注意！
>
> 原博文中是扩展的 AuthorizeAttribute，即认证和授权过滤器，代码实现上是没有多大差别的；在时机上**认证和授权过滤器**要比方法过滤器执行的要早，更适合做认证和授权的操作。而我们扩展这个过滤器的目的是对报文进行**签名验证**以及**超时验证**，所以使用**方法过滤器**更恰当些。

下面是扩展过滤器的代码：

``` csharp
/// <summary>
    /// 扩展方法过滤器,进入方法前验证签名
    /// </summary>
    public class ApiVerifyFilter : ActionFilterAttribute
    {

        public override void OnActionExecuting(HttpActionContext actionContext)
        {
            base.OnActionExecuting(actionContext);

            //获取平台私钥
            string privateKey = Common.GetRsaPrivateKey();

            //获取请求的超时时间,为了测试设置为100秒,即两次调用间隔不能超过100秒
            string expireyTime = ConfigurationManager.AppSettings["UrlExpireTime"];
            var request = actionContext.Request;

            //验证签名所需header内容
            if (!request.Headers.Contains("signature") || !request.Headers.Contains("timestamp") || !request.Headers.Contains("nonce"))
            {
                SetSpecialResponseMessage(actionContext, 40301);
                return;
            }
            var token = string.Empty;
            var signature = request.Headers.GetValues("signature").FirstOrDefault();
            var timeStamp = request.Headers.GetValues("timestamp").FirstOrDefault();
            var nonce = request.Headers.GetValues("nonce").FirstOrDefault();

            //验证签名
            if (!Common.SignValidate(privateKey, nonce, timeStamp, signature, token))
            {
                SetSpecialResponseMessage(actionContext, 40302);
                return;
            }
            //检查接口调用是否超时
            var ts = Common.DateTime2TimeStamp(DateTime.UtcNow) - Convert.ToDouble(timeStamp);
            if (ts > int.Parse(expireyTime) * 1000)
            {
                SetSpecialResponseMessage(actionContext, 40303);
                return;
            }
        }

        /// <summary>
        /// 设置签名验证异常返回状态
        /// </summary>
        /// <param name="actionContext">当前请求上下文</param>
        /// <param name="statusCode">异常状态码</param>
        private static void SetSpecialResponseMessage(HttpActionContext actionContext, int statusCode)
        {
            BizResponseModel model = new BizResponseModel
            {
                Status = statusCode,
                Date = DateTime.Now.ToString("yyyyMMddhhmmssfff"),
                Message = "服务端拒绝访问"
            };
            switch (statusCode)
            {
                case 40301:
                    model.Message = "没有设置签名、时间戳、随机字符串";
                    break;
                case 40302:
                    model.Message = "签名无效";
                    break;
                case 40303:
                    model.Message = "无效的请求";
                    break;
                default:
                    break;
            }
            actionContext.Response = new HttpResponseMessage
            {
                Content = new StringContent(JsonConvert.SerializeObject(model))
            };
        }


        public override void OnActionExecuted(HttpActionExecutedContext actionExecutedContext)
        {
            base.OnActionExecuted(actionExecutedContext);
        }
    }
	```

这里为了方便写了个ResponseModel，代码如下：

``` csharp
/// <summary>
    /// 特殊状态
    /// </summary>
    public class BizResponseModel
    {
        public int Status { get; set; }
        public string Message { get; set; }
        public string Date { get; set; }
    }
```

然后下面是用的公共方法：

``` csharp
/// <summary>
        /// 获取时间戳毫秒数
        /// </summary>
        /// <param name="dateTime"></param>
        /// <returns></returns>
        public static long DateTime2TimeStamp(DateTime dateTime)
        {
            TimeSpan ts = DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, 0);
            return Convert.ToInt64(ts.TotalMilliseconds);
        }


        public static bool SignValidate(string privateKey, string nonce, string timestamp, string signature, string token)
        {
            bool isValidate = false;
            var tempSign = RsaHelper.RSADecrypt(privateKey, signature);
            string[] arr = new[] { token, timestamp, nonce }.OrderBy(z => z).ToArray();
            string arrString = string.Join("", arr);
            var sha256Result = arrString.EncryptSha256();
            if (sha256Result == tempSign)
            {
                isValidate = true;
            }
            return isValidate;
        }
		```

签名验证的过程如下：

1.  获取到报文Header中的 nonce、timestamp、signature、token信息
2.  将token、timestamp、nonce 三者合并数组中，然后进行顺序排序（排序为了保证后续三个字符串拼接后一致）
3.  将数组拼接成字符串，然后进行sha256 哈希运算(这里随便什么运算都行，主要为了防止超长加密麻烦)
4.  将上一步的哈希结果与\[signature\] RSA解密结果进行比对，一致则签名验证通过，否则则签名不一致，请求为伪造

然后，现在需要启用刚添加的方法过滤器，因为是继承与属性，可以全局启用，或者单个Controller中启用、或者为某个Action启用。全局启用代码如下：

下的 WebApiConfig类添加如下代码：

``` csharp
config.Filters.Add(new ApiVerifyFilter());
```

OK，全部完成，最后附上两个前后的效果对比！

[![网盘](https://img2018.cnblogs.com/blog/171569/201910/171569-20191031190517059-82941230.jpg "网盘")](https://img2018.cnblogs.com/blog/171569/201910/171569-20191031190516572-270810520.jpg)

参考博文：

[WebApi安全性 使用TOKEN+签名验证](https://www.cnblogs.com/MR-YY/p/5972380.html)

[WebAPi接口安全之公钥私钥加密](https://www.cnblogs.com/clly/p/7384008.html)

[使用OAuth打造webapi认证服务供自己的客户端使用](https://www.cnblogs.com/richieyang/p/4918819.html)

[Asp.Net WebAPI中Filter过滤器的使用以及执行顺序](https://www.cnblogs.com/lijingran/p/6420397.html)

[微信 公众号开发文档](https://developers.weixin.qq.com/doc/offiaccount/Basic_Information/Access_Overview.html)

写博文太累了，回家吃螃蟹补补~
