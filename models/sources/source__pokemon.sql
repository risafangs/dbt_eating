with
    base as (

        select * from {{ source('open_data', 'pokemon') }}

    )

    , renamed as (

        select
            pokedex_id
            , code as evolution_level
            , serial
            , lower(name) as name
            , lower(type1) as primary_type
            , lower(type2) as secondary_type
            , lower(color) as color
            , lower(ability1) as primary_ability
            , lower(ability2) as secondary_ability
            , lower(ability_hidden) as ability_hidden
            , generation
            , try_to_boolean(legendary::string) as is_legendary
            , try_to_boolean(mega_evolution::string) as has_mega_evolution
            , height as height_class
            , weight as weight_kg
            , hp
            , atk as attack
            , def as defense
            , sp_atk as special_attack
            , sp_def as special_defense
            , spd as speed
            , total

        from base

    )

    , reordered as (

        select
            /* primary key */
            serial

            /* foreign keys and ids */
            , pokedex_id

            /* attributes */
            , evolution_level
            , name
            , primary_type
            , secondary_type
            , color
            , primary_ability
            , secondary_ability
            , ability_hidden
            , generation
            , is_legendary
            , has_mega_evolution

            /* stats */
            , height_class
            , weight_kg
            , hp
            , attack
            , defense
            , special_attack
            , special_defense
            , speed
            , total
            
            /* metadata */
            , current_time() as loaded_at

     from renamed

    )

select * from reordered

