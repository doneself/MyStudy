# Nhibernate map主键配置

For databases which support identity columns (DB2, MySQL, Sybase, MS SQL), you may use identity key generation. For databases that support sequences (DB2, Oracle, PostgreSQL, Interbase, McKoi, SAP DB) you may use sequence style key generation. Both these strategies require two SQL queries to insert a new object.

``` xml
<id name="Id" type="Int64" column="uid">
    <generator class="sequence">
        <param name="sequence">uid\_sequence</param>
    </generator>
</id>

<id name="Id" type="Int64" column="uid">
    <generator class="identity"/>
</id>
```

For cross-platform development, the native strategy will choose from the identity, sequence and hilo strategies, dependent upon the capabilities of the underlying database.
