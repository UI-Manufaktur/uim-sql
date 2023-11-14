
/**
 * CreateIndexTypeBuilder.php
 *
 * Builds index type part of a CREATE INDEX statement. */

module source.langs.sql.PHPSQLParser.builders.create.indexes.indextype;

import lang.sql;

@safe:
/**
 * This class : the builder for the index type of a CREATE INDEX
 * statement. 
 * You can overwrite all functions to achieve another handling. */
class CreateIndexTypeBuilder : IndexTypeBuilder {

    string build(array $parsed) {
        if (!isset($parsed["index-type"]) || $parsed["index-type"] == false) {
            return "";
        }
        return super.build($parsed["index-type"]);
    }
}
