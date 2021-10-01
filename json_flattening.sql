/* JSON flattening examples */ 
select one_level.value as one_level,
children.value:firstName as children_value
from WILL_DB.RAW.JSON_TABLE,
table(flatten(content)) as one_level,
table(flatten(one_level.value:employee)) as children;

select one_level.key as one_level
,children.value as children_value
,grandchild.value as grandchild_value
from WILL_DB.RAW.JSON_TABLE,
table(flatten(content)) as one_level,
table(flatten(one_level.value:employee)) as children,
table(flatten(children.value)) as grandchild;

select one_level.VALUE as one_level,
children.VALUE:firstName as children_value
from WILL_DB.RAW.JSON_TABLE,
table(FLATTEN(content)) as one_level,
table(FLATTEN(one_level.value:employee)) as children
where one_level.key = $$Will's Company$$;

/* get all the values in JSON_TABLE contents */
SELECT level_one.key as COMPANY_NAME
,level_one.value:Location::STRING as LOCATION --applying STRING removes the double quotes from the results
,level_two.value:firstName::STRING as FIRST_NAME
,level_two.value:lastName::STRING as LAST_NAME
,level_two.value:id::INT as ID
FROM WILL_DB.RAW.JSON_TABLE
,TABLE(FLATTEN(content)) AS level_one
,TABLE(FLATTEN(level_one.value:employee)) as level_two
