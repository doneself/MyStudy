//C# 创建jpg图片文件

using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CreateImage
{
    public class ImageHelper
    {
        public static void CreateJpg()
        {
            string fileName = DateTime.Now.ToString("yyyyMMddmmss") + ".jpg";
            string dir = @"C:\TempFiles\";
            string fullName = System.IO.Path.Combine(dir, fileName);
            using (var bmp = new System.Drawing.Bitmap(600, 400))
            {
                using(Graphics g = Graphics.FromImage(bmp))
                {
                    g.Clear(Color.White);
                    using (Font arialFont = new Font("Arial", 20))
                    {
                        g.DrawString(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss:fff"), arialFont, Brushes.Black, 10f, 10f);
                    }
                }
                bmp.Save(fullName, System.Drawing.Imaging.ImageFormat.Jpeg);
            }
            System.Diagnostics.Process.Start(fullName);
        }
    }
}

