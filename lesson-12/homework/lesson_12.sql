use homework;


---task-1
declare @db_name nvarchar(128); --declare
declare @sql nvarchar(max);

declare db_cursor cursor for
select name
from sys.databases
where name not in('master','tempdb','model','msdb') ---not include this databases
and state_desc='online';

open db_cursor; --open
fetch next from db_cursor into @db_name; 

while @@fetch_status=0
begin 
	---set sql for given task 
	set @sql='
	select 
		'''+@db_name+''' as databasename,
		s.name as schema_name,
		t.name as table_name,
		c.name as column_name,
		cdt.name as column_datatype
	from ['+@db_name+'].sys.schemas as s
	join ['+@db_name+'].sys.tables as t
		on s.schema_id=t.schema_id
	join ['+@db_name+'].sys.columns as c
		on c.object_id=t.object_id
	join ['+@db_name+'].sys.types as cdt
		on cdt.user_type_id=c.user_type_id
	order by schema_name,table_name,column_name;';
	
	exec sp_executesql @sql; --execute
	fetch next from db_cursor into @db_name;
end

close db_cursor; --close cursor
deallocate db_cursor; --delete 
	
--task-2
drop procedure dbo.GetProceduresAndFunctions
create procedure dbo.GetProceduresAndFunctions
	 @Databasename nvarchar(128)=Null--create procedure
as
begin
	set nocount on;
	create table #results(
		databasename nvarchar(128),
		schemaname nvarchar(128),
		parameter nvarchar(128),
		datatype nvarchar(128),
		maxlength int
	);
	declare @dbname nvarchar(128);
	declare @sql nvarchar(max);

	declare db_cursor cursor for
	select name
	from sys.databases
	where state_desc='online' and
	name not in ('master','tempdb','model','msdb')
	and (@databasename is null or name=@databasename); ---get null or others

	open db_cursor;---open
	fetch next from db_cursor into @dbname;

	while @@fetch_status=0
	begin
		set @sql='
			use ['+@dbname+'];

			insert into #results (databasename,schemaname,parameter,datatype,maxlength)
			select
				'''+@dbname+''' as databasename,
				s.name as schemaname,
				p.name as parameter,
				t.name as datatype,
				p.max_length as maxlength
			from sys.objects o
			inner join sys.schemas s
				on s.schema_id=o.schema_id
			left join sys.parameters p
				on o.object_id=p.object_id
			left join sys.types t 
				on t.user_type_id=p.user_type_id
			where o.type in(''P'',''PC'',''FN'',''TF'',''IF'');';
			exec sp_executesql @sql;
			fetch next from db_cursor into @dbname; --get needed columns
	end

	close db_cursor;--close
	deallocate db_cursor;

	select*from #results 
	order by databasename,schemaname,parameter;

	drop table #results;
end;
exec dbo.GetProceduresAndFunctions ---see the result