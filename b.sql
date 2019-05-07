with cte as (
    select t.table_catalog as base,
    t.table_schema as schema,
    t.table_name as nom,
    (
        case
            when t.table_type = 'BASE TABLE' then 'TABLE'
            when t.table_type = 'VIEW' then 'VUE'
        end
    ) as type,
    (
        case
            when t.is_insertable_into = 'YES' then 'OUI'
            when t.is_insertable_into = 'NO' then 'NON'
        end
    ) peut_t_on_y_inserer_des_donnees,
    (
        select count(*) from information_schema.columns c where c.table_name = t.table_name group by table_name
    ) nb_colonnes,
    (
        select count(*) from information_schema.table_constraints ck where ck.table_name = t.table_name and ck.constraint_type = 'CHECK' group by table_name
    ) nb_contrainte_de_valeur,
    (
        select count(*) from information_schema.table_constraints fk where fk.table_name = t.table_name and fk.constraint_type = 'FOREIGN KEY' group by table_name
    ) nb_contrainte_cle_etrangere,
    (
        select count(*) from information_schema.table_constraints pk where pk.table_name = t.table_name and pk.constraint_type = 'PRIMARY KEY' group by table_name
    ) nb_contrainte_cle_primaire,
    (
        select count(*) from information_schema.table_constraints u where u.table_name = t.table_name and u.constraint_type = 'UNIQUE' group by table_name
    ) nb_contrainte_unicite
    from information_schema.tables t
    where t.table_schema != 'pg_catalog' and 
    t.table_schema != 'information_schema' and 
    t.table_schema != 'pg_toast' and 
    t.table_schema != 'pg_toast_temp_1' and 
    t.table_schema != 'pg_temp_1'
)
select * from cte;