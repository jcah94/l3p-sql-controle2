with cte as (
    select c.table_catalog as base,
    c.table_schema as schema,
    c.table_name as nom,
    c.ordinal_position as position_colonne,
    c.data_type as type_colonne,
    c.is_nullable as peut_etre_null,
    c.is_updatable as peut_etre_modifie,
    c.character_maximum_length as chaine_longueur_max
    from information_schema.columns c
    where c.table_schema != 'pg_catalog' and 
    c.table_schema != 'information_schema' and 
    c.table_schema != 'pg_toast' and 
    c.table_schema != 'pg_toast_temp_1' and 
    c.table_schema != 'pg_temp_1'
)
select * from cte;