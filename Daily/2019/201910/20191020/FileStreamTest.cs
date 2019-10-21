
/// <summary>
/// FileStreamTest 类
/// </summary>
public class FileStreamTest
{
	/// <summary>
	/// 添加文件方法
	/// </summary>
	/// <param name="config"> 创建文件配置类</param>
	public void Create(IFileConfig config)
	{
		lock (_lockObject)
		{
			//得到创建文件配置类对象
			var createFileConfig = config as CreateFileConfig;
			//检查创建文件配置类是否为空
			if (this.CheckConfigIsError(config)) return;
			//假设创建完文件后写入一段话，实际项目中无需这么做，这里只是一个演示
			char[] insertContent = "HellowWorld".ToCharArray();
			//转化成 byte[]
			byte[] byteArrayContent = Encoding.Default.GetBytes(insertContent, 0, insertContent.Length);
			//根据传入的配置文件中来决定是否同步或异步实例化stream对象
			FileStream stream = createFileConfig.IsAsync ?
				new FileStream(createFileConfig.CreateUrl, FileMode.Create, FileAccess.ReadWrite, FileShare.None, 4096, true)
				: new FileStream(createFileConfig.CreateUrl, FileMode.Create);
			using (stream)
			{
				// 如果不注释下面代码会抛出异常，google上提示是WriteTimeout只支持网络流
				// stream.WriteTimeout = READ_OR_WRITE_TIMEOUT;
				//如果该流是同步流并且可写
				if (!stream.IsAsync && stream.CanWrite)
					stream.Write(byteArrayContent, 0, byteArrayContent.Length);
				else if (stream.CanWrite)//异步流并且可写
					stream.BeginWrite(byteArrayContent, 0, byteArrayContent.Length, this.End_CreateFileCallBack, stream);

				stream.Close();
			}
		}
	}
}
