// asp mvc 获取客户端IP

/// <summary>
    /// IP帮助类
    /// </summary>
    public class IPHelper
    {
        /// <summary>
        /// 获取客户端IP
        /// </summary>
        /// <param name="req"></param>
        /// <returns></returns>
        public string GetIP(RequestContext req)
        {
            string result = req.HttpContext.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (string.IsNullOrEmpty(result))
            {
                result = req.HttpContext.Request.ServerVariables["REMOTE_ADDR"];
            }
            if (string.IsNullOrEmpty(result))
            {
                result = req.HttpContext.Request.UserHostAddress;
            }
            if (string.IsNullOrEmpty(result))
            {
                result = "0.0.0.0";
            }
            return result;
        }
    }
