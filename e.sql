with cte as (
    select tp.table_catalog as base,
    tp.table_schema as schema,
    tp.table_name as nom,
    tp.privilege_type as type_de_privilege,
    tp.grantor as attributeur,
    tp.grantee as beneficiaire
    from information_schema.table_privileges tp
    where tp.table_schema != 'pg_catalog' and 
    tp.table_schema != 'information_schema' and 
    tp.table_schema != 'pg_toast' and 
    tp.table_schema != 'pg_toast_temp_1' and 
    tp.table_schema != 'pg_temp_1'
)
select * from cte order by base, schema, nom, type_de_privilege;