-- DELETE potential conflict entry from previous install, just to be safe.
delete from TABLE_ACCESS where c_table_cd = 'SHRINE';

-- Create a new entry in table access allowing this Ontology to be used for project SHRINE
INSERT into TABLE_ACCESS
( c_table_cd,
  c_table_name,
  c_protected_access,
  c_hlevel,
  c_name,
  c_fullname,
  c_synonym_cd,
  c_visualattributes,
  c_tooltip,
  c_facttablecolumn,
  c_dimtablename,
  c_columnname,
  c_columndatatype,
  c_dimcode,
  c_operator)
values
( 'SHRINE',
  'SHRINE',
  'N',
   0,
   'SHRINE Ontology',
   '\SHRINE\',
   'N',
   'CA',
   'SHRINE Ontology',
   'concept_cd',
   'concept_dimension',
   'concept_path',
   'T',
   '\SHRINE\',
   'LIKE')
;

