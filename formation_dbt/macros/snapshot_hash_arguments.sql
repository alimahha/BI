{#
    Remplace la macro de dbt-mysql qui utilise md5(), fonction absente de ce serveur MySQL.
    Elle calcule dbt_scd_id, l'identifiant unique de chaque version d'une ligne dans un snapshot.
    On utilise sha2(..., 256) à la place.
#}
{% macro mysql__snapshot_hash_arguments(args) -%}
    sha2(concat_ws('|', {%- for arg in args -%}
        coalesce(cast({{ arg }} as char), '')
        {% if not loop.last %}, {% endif %}
    {%- endfor -%}), 256)
{%- endmacro %}
