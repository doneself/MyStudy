using NPOI.XWPF.UserModel;
using SharpPrinterDAL;
using SharpPrinterDAL.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace SharpDbPrinter.TplToPrint
{
    public static class TplToPrintDocx
    {
        /// <summary>
        /// 替换docx文档中，包含dic.Key的文本,替换成dic[key]的值。
        /// 功能与函数DocxBaseRelace一致，在DocxBaseRelace的基础上，将dic[key]的文本将换行符转换docx格式换行格式
        /// </summary>
        /// <param name="doc"></param>
        /// <param name="dic">dic.Key为docx文档中的目标文本，如果文本包含key的值，则将其替换成dic[key]的值</param>
        /// <returns></returns>
        public static XWPFDocument DocxRepalceWithParaFormat(XWPFDocument doc, Dictionary<string, string> dic)
        {
            foreach (var para in doc.Paragraphs)
            {
                if (!string.IsNullOrWhiteSpace(para.ParagraphText))
                {
                    var runs = para.Runs;
                    foreach (var r in runs)
                    {
                        string text = r.GetText(0);
                        foreach (var item in dic)
                        {
                            if (text != null && text.Contains(item.Key))//搜索当前run是否包含dic.Key
                            {
                                if (!string.IsNullOrEmpty(item.Value))//判断要替换的item.Value的值是否为空，如果不为空则进行换行处理，如果为空则直接替换。
                                {
                                    string[] condition = { "\r\n" };
                                    string[] paragraphs = item.Value.Split(condition, StringSplitOptions.None);//根据换行符分割字符串

                                    if (paragraphs.Length < 2)//如果数组长度为1，则代表没有换行符，直接替换。
                                    {
                                        text = text.Replace(item.Key, item.Value);
                                        r.SetText(text, 0);
                                    }
                                    else
                                    {
                                        var removeEmptyParagraphs = paragraphs.Where(x => !string.IsNullOrEmpty(x)).ToList();//删除掉数组里面的空行
                                        r.SetText("", 0);
                                        int i = 0;
                                        foreach (var p in removeEmptyParagraphs)
                                        {
                                            if (i == removeEmptyParagraphs.Count - 1)//如果是最后一行，则不添加换行
                                            {
                                                r.AppendText(p);
                                            }
                                            else
                                            {
                                                r.AppendText(p);
                                                r.AddCarriageReturn();//添加换行符
                                                //r.AddCarriageReturn();
                                            }
                                            i++;
                                        }
                                    }
                                }
                                else
                                {
                                    text = text.Replace(item.Key, item.Value);
                                    r.SetText(text, 0);
                                }
                            }
                        }
                    }
                }
            }

            //遍历表格
            var tables = doc.Tables;
            foreach (var table in tables)
            {
                foreach (var row in table.Rows)
                {
                    foreach (var cell in row.GetTableCells())
                    {
                        foreach (var para in cell.Paragraphs)
                        {
                            //ReplaceKey(para, dict);
                            if (!string.IsNullOrWhiteSpace(para.ParagraphText))
                            {
                                var runs = para.Runs;
                                foreach (var r in runs)
                                {
                                    string text = r.GetText(0);
                                    foreach (var item in dic)
                                    {
                                        if (text != null && text.Contains(item.Key))//搜索当前run是否包含dic.Key
                                        {
                                            if (!string.IsNullOrEmpty(item.Value))//判断要替换的item.Value的值是否为空，如果不为空则进行换行处理，如果为空则直接替换。
                                            {
                                                string[] condition = { "\r\n" };
                                                string[] paragraphs = item.Value.Split(condition, StringSplitOptions.None);

                                                if (paragraphs.Length < 2)//如果数组长度为1，则代表没有换行符，直接替换。
                                                {
                                                    text = text.Replace(item.Key, item.Value);
                                                    r.SetText(text, 0);
                                                }
                                                else
                                                {
                                                    var removeEmptyParagraphs = paragraphs.Where(x => !string.IsNullOrEmpty(x)).ToList();//删除掉数组里面的空行
                                                    r.SetText("", 0);
                                                    int i = 0;
                                                    foreach (var p in removeEmptyParagraphs)
                                                    {
                                                        if (i == removeEmptyParagraphs.Count - 1)//如果是最后一行，则不添加换行
                                                        {
                                                            r.AppendText(p);
                                                        }
                                                        else
                                                        {
                                                            r.AppendText(p);
                                                            r.AddCarriageReturn();//添加换行符
                                                            //r.AddCarriageReturn();
                                                        }
                                                        i++;
                                                    }
                                                }
                                            }
                                            else
                                            {
                                                text = text.Replace(item.Key, item.Value);
                                                r.SetText(text, 0);
                                            }

                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            return doc;
        }

        /// <summary>
        /// 替换docx文档中，包含dic.Key的文本,替换成dic[key]的值。
        /// </summary>
        /// <param name="doc"></param>
        /// <param name="dic">dic.Key为docx文档中的目标文本，如果文本包含key的值，则将其替换成dic[key]的值</param>
        /// <returns></returns>
        public static XWPFDocument DocxBaseRelace(XWPFDocument doc, Dictionary<string, string> dic)
        {
            //遍历段落
            foreach (var para in doc.Paragraphs)
            {
                if (!string.IsNullOrWhiteSpace(para.ParagraphText))
                {
                    var runs = para.Runs;
                    foreach (var r in runs)
                    {
                        string text = r.GetText(0);
                        foreach (var item in dic)
                        {
                            if (text != null && text.Contains(item.Key))
                            {
                                text = text.Replace(item.Key, item.Value);
                                r.SetText(text, 0);
                            }
                        }
                    }
                }
            }

            //遍历表格
            var tables = doc.Tables;
            foreach (var table in tables)
            {
                foreach (var row in table.Rows)
                {
                    foreach (var cell in row.GetTableCells())
                    {
                        foreach (var para in cell.Paragraphs)
                        {
                            //ReplaceKey(para, dict);
                            if (!string.IsNullOrWhiteSpace(para.ParagraphText))
                            {
                                var runs = para.Runs;
                                foreach (var r in runs)
                                {
                                    string text = r.GetText(0);
                                    foreach (var item in dic)
                                    {
                                        if (text != null && text.Contains(item.Key))
                                        {
                                            text = text.Replace(item.Key, item.Value);
                                            r.SetText(text, 0);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            return doc;
        }

        // 收件回执
        public static void SJHZ(Dictionary<string, string> dic, string tplFilePath, string outputPrintFilePath)
        {
            using (FileStream tplFileStream = new FileStream(tplFilePath, FileMode.Open, FileAccess.Read))
            using (FileStream outputFileStream = File.Create(outputPrintFilePath))
            {
                XWPFDocument tplDoc = new XWPFDocument(tplFileStream);
                var printDoc = DocxBaseRelace(tplDoc, dic);
                printDoc.Write(outputFileStream);
            }
        }

        //(审批办)确认书.docx 
        public static void SPBQRS(Dictionary<string, string> dic, string tplFilePath, string outputPrintFilePath)
        {
            using (FileStream tplFileStream = new FileStream(tplFilePath, FileMode.Open, FileAccess.Read))
            using (FileStream outputFileStream = File.Create(outputPrintFilePath))
            {
                XWPFDocument tplDoc = new XWPFDocument(tplFileStream);
                var printDoc = DocxBaseRelace(tplDoc, dic);
                printDoc.Write(outputFileStream);
            }
        }

        //建设用地缴款通知书
        public static void JSYDJKTZS(Dictionary<string, string> dic, string tplFilePath, string outputPrintFilePath)
        {
            using (FileStream tplFileStream = new FileStream(tplFilePath, FileMode.Open, FileAccess.Read))
            using (FileStream outputFileStream = File.Create(outputPrintFilePath))
            {
                XWPFDocument tplDoc = new XWPFDocument(tplFileStream);
                var printDoc = DocxBaseRelace(tplDoc, dic);
                printDoc.Write(outputFileStream);
            }
        }

        //退件表
        public static void TJB(Dictionary<string, string> dic, string tplFilePath, string outputPrintFilePath)
        {
            using (FileStream tplFileStream = new FileStream(tplFilePath, FileMode.Open, FileAccess.Read))
            using (FileStream outputFileStream = File.Create(outputPrintFilePath))
            {
                XWPFDocument tplDoc = new XWPFDocument(tplFileStream);
                var printDoc = DocxBaseRelace(tplDoc, dic);
                printDoc.Write(outputFileStream);
            }
        }


        //确认书（房改房）
        public static void QRSFGF(Dictionary<string, string> dic, string tplFilePath, string outputPrintFilePath)
        {
            using (FileStream tplFileStream = new FileStream(tplFilePath, FileMode.Open, FileAccess.Read))
            using (FileStream outputFileStream = File.Create(outputPrintFilePath))
            {
                XWPFDocument tplDoc = new XWPFDocument(tplFileStream);
                var printDoc = DocxBaseRelace(tplDoc, dic);
                printDoc.Write(outputFileStream);
            }
        }

        //地政函档案封面及收件回执
        public static void DZHDAFMJSJHZ(Dictionary<string, string> dic, string tplFilePath, string outputPrintFilePath)
        {
            using (FileStream tplFileStream = new FileStream(tplFilePath, FileMode.Open, FileAccess.Read))
            using (FileStream outputFileStream = File.Create(outputPrintFilePath))
            {
                List<RespDZHSJHZ> list = new DbHelper().QueryRespDZHSJHZ(SharpDbPrinter.Program.globalYwid);
                XWPFDocument tplDoc = new XWPFDocument(tplFileStream);
                var printDoc = DocxBaseRelace(tplDoc, dic);
                var firstTable = printDoc.Tables[0];
                for (int i = 0; i < list.Count; i++)
                {
                    XWPFTableRow newRow = new XWPFTableRow(new NPOI.OpenXmlFormats.Wordprocessing.CT_Row(), firstTable);
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.MergeCells(0, 1);
                    if (list[i].MTR_NAME == null && list[i].OLD_NUM == null && list[i].DUPL_NUM == null)
                    {
                    }
                    else
                    {
                        newRow.GetCell(0).SetParagraph(SetCellText(printDoc, firstTable, list[i].MTR_NAME ?? "0"));
                        newRow.GetCell(1).SetParagraph(SetCellText(printDoc, firstTable, list[i].OLD_NUM ?? "0"));
                        newRow.GetCell(2).SetParagraph(SetCellText(printDoc, firstTable, list[i].DUPL_NUM ?? "0"));
                    }

                    firstTable.AddRow(newRow, 2 + i);
                }
                firstTable.RemoveRow(1);

                printDoc.Write(outputFileStream);
            }
        }

        public static XWPFParagraph SetCellText(XWPFDocument doc, XWPFTable table, string setText)
        {
            //table中的文字格式设置  
            NPOI.OpenXmlFormats.Wordprocessing.CT_P para = new NPOI.OpenXmlFormats.Wordprocessing.CT_P();
            XWPFParagraph pCell = new XWPFParagraph(para, table.Body);
            pCell.Alignment = ParagraphAlignment.CENTER;//字体居中  
            pCell.VerticalAlignment = TextAlignment.CENTER;//字体居中  

            XWPFRun r1c1 = pCell.CreateRun();
            r1c1.SetText(setText);
            r1c1.FontSize = 12;
            r1c1.FontFamily = "宋体";
            r1c1.SetTextPosition(16);//设置高度  
            return pCell;
        }


        //地政函审批表(改功能)
        /// <summary>
        /// 将模板文档的源关键字替换成目标文本
        /// </summary>
        /// <param name="dic">基础替换文本字典</param>
        /// <param name="formatParaDic">包含换行符的替换目标字典</param>
        /// <param name="tplFilePath">模板文件的路径</param>
        /// <param name="outputPrintFilePath">输出文件路径</param>
        public static void DZHSPBGGN(Dictionary<string, string> dic, Dictionary<string, string> formatParaDic, string tplFilePath, string outputPrintFilePath)
        {
            using (FileStream tplFileStream = new FileStream(tplFilePath, FileMode.Open, FileAccess.Read))
            using (FileStream outputFileStream = File.Create(outputPrintFilePath))
            {
                List<RespDZHSPBChild> list = new DbHelper().QueryDZHSPB1_Child(SharpDbPrinter.Program.globalYwid);
                XWPFDocument tplDoc = new XWPFDocument(tplFileStream);
                var printDoc = DocxRepalceWithParaFormat(tplDoc, formatParaDic);
                printDoc = DocxBaseRelace(printDoc, dic);
                int row1 = 9;
                var firstTable = printDoc.Tables[0];
                for (int i = 0; i < list.Count; i++)
                {
                    XWPFTableRow newRow = new XWPFTableRow(new NPOI.OpenXmlFormats.Wordprocessing.CT_Row(), firstTable);
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.MergeCells(5, 9);
                    newRow.MergeCells(0, 4);
                    newRow.GetCell(0).SetParagraph(SetCellText(printDoc, firstTable, list[i].th ?? ""));
                    newRow.GetCell(1).SetParagraph(SetCellText(printDoc, firstTable, list[i].YTDSYZH ?? ""));
                    newRow.GetCell(2).SetParagraph(SetCellText(printDoc, firstTable, list[i].PZMJ ?? ""));
                    firstTable.AddRow(newRow, row1 + 1 + i);
                }
                firstTable.RemoveRow(row1);

                printDoc.Write(outputFileStream);
            }
        }

        //地政函审批表
        /// <summary>
        /// 将模板文档的源关键字替换成目标文本
        /// </summary>
        /// <param name="dic">基础替换文本字典</param>
        /// <param name="formatParaDic">包含换行符的替换目标字典</param>
        /// <param name="tplFilePath">模板文件的路径</param>
        /// <param name="outputPrintFilePath">输出文件路径</param>
        public static void DZHSPB(Dictionary<string, string> dic, Dictionary<string, string> formatParaDic, string tplFilePath, string outputPrintFilePath)
        {
            using (FileStream tplFileStream = new FileStream(tplFilePath, FileMode.Open, FileAccess.Read))
            using (FileStream outputFileStream = File.Create(outputPrintFilePath))
            {
                List<RespDZHSPBChild> list = new DbHelper().QueryDZHSPB_Child(SharpDbPrinter.Program.globalYwid);
                XWPFDocument tplDoc = new XWPFDocument(tplFileStream);
                var printDoc = DocxRepalceWithParaFormat(tplDoc, formatParaDic);
                printDoc = DocxBaseRelace(printDoc, dic);
                int row1 = 9;
                var firstTable = printDoc.Tables[0];
                for (int i = 0; i < list.Count; i++)
                {
                    XWPFTableRow newRow = new XWPFTableRow(new NPOI.OpenXmlFormats.Wordprocessing.CT_Row(), firstTable);
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.CreateCell();
                    newRow.MergeCells(5, 9);
                    newRow.MergeCells(0, 4);
                    newRow.GetCell(0).SetParagraph(SetCellText(printDoc, firstTable, list[i].th ?? ""));
                    newRow.GetCell(1).SetParagraph(SetCellText(printDoc, firstTable, list[i].YTDSYZH ?? ""));
                    newRow.GetCell(2).SetParagraph(SetCellText(printDoc, firstTable, list[i].PZMJ ?? ""));
                    firstTable.AddRow(newRow, row1 + 1 + i);
                }
                firstTable.RemoveRow(row1);
                printDoc.Write(outputFileStream);
            }
        }



    }
}
