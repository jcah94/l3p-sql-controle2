with cte as (
    select tc.constraint_catalog as base,
    tc.constraint_schema as schema,
    tc.constraint_name as nom,
    (
        case
            when tc.constraint_type = 'CHECK' then 'Contrainte de valeur'
            when tc.constraint_type = 'UNIQUE' then 'Contrainte d''unicité'
            when tc.constraint_type = 'FOREIGN KEY' then 'Contrainte de clé étrangère'
            when tc.constraint_type = 'PRIMARY KEY' then 'Contrainte de clé primaire'
        end
    ) type_de_contrainte,
    (
        select concat(tt.constraint_catalog,'.',tt.constraint_schema,'.',tt.table_name)
        from information_schema.table_constraints tt
        where tt.constraint_name = tc.constraint_name
    ) ratache_la_table
    from information_schema.table_constraints tc
    where tc.table_schema != 'pg_catalog' and 
    tc.table_schema != 'information_schema' and 
    tc.table_schema != 'pg_toast' and 
    tc.table_schema != 'pg_toast_temp_1' and 
    tc.table_schema != 'pg_temp_1'
)
select * from cte order by base, schema, nom;