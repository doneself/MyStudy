--oracle 分页数据


SELECT * FROM (
    SELECT
      ord.*,
      row_number() over (ORDER BY ord.DJZQ) line_number
    FROM ZDJBXX_ZJD ord

  ) WHERE line_number BETWEEN 0 AND 5  ORDER BY line_number;


SELECT  *
FROM    ( SELECT    ROW_NUMBER() OVER ( ORDER BY DJZQ ) AS RowNum, *
          FROM      ZDJBXX_ZJD
        ) AS RowConstrainedResult
WHERE   RowNum >= 1
    AND RowNum < 20
ORDER BY RowNum
