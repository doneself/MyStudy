//C# 数型格式化输出

namespace CsharpSiSheWuRu
{
    class Program
    {
        static void Main(string[] args)
        {
            decimal f = 54.1678m;
            Console.WriteLine(f.ToString());//54.1678
            Console.WriteLine(f.ToString("0.00000000"));//54.16780000
            Console.WriteLine(f.ToString("0.########"));//54.1678
            Console.WriteLine(f.ToString("0.000"));//54.168
            Console.WriteLine(f.ToString("0.###"));//54.168
            Console.WriteLine(f.ToString("0.#"));//54.1

            Console.WriteLine(string.Format("{0:0.0}", Math.Truncate(f * 10) / 10));//54.1
            Console.WriteLine(string.Format("{0:0.00}", Math.Truncate(f * 100) / 100));//54.16

            Console.WriteLine(String.Format("{0:0.00}", 123.456789));//123.46
            Console.WriteLine(String.Format("{0:0.00}", 12345.6));//12345.60
            Console.WriteLine(String.Format("{0:0.00}", 123456));//123456.00

            Console.ReadKey();
        }
    }
}

