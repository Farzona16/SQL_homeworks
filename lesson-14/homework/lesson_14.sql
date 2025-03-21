use homework;

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

EXEC sp_configure 'Database Mail XPs', 1;
RECONFIGURE;

declare @html nvarchar(max);

set @html = 
    N'<html>
    <head>
        <style>
            table { border-collapse: collapse; width: 100%; }
            th, td { border: 1px solid black; padding: 8px; text-align: left; }
            th { background-color: #f2f2f2; }
        </style>
    </head>
    <body>
        <h2>index metadata report</h2>
        <table>
            <tr>
                <th>table name</th>
                <th>index name</th>
                <th>index type</th>
                <th>column name</th>
            </tr>' + 
    (
        SELECT 
            '<tr><td>' + t.name + 
            '</td><td>' + isnull(i.name, 'N/A') + 
            '</td><td>' + i.type_desc + 
            '</td><td>' + c.name + '</td></tr>'
        from sys.indexes i
        join sys.index_columns ic on i.object_id = ic.object_id and i.index_id = ic.index_id
        join sys.columns c on ic.object_id = c.object_id and ic.column_id = c.column_id
        join sys.tables t on i.object_id = t.object_id
        where i.type > 0
        for xml path('')
    ) + 
    '</table>
    </body>
    </html>';

	EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'Notifications', --the name of Database Mail 
    @recipients = 'xusanboyevafarzonaxon@gmail.com',  -- recipients email
    @subject = 'SQL Server Index Metadata Report',
    @body = @html,
    @body_format = 'html';
