
/**
 * CreateIndexTypeBuilder.php
 *
 * Builds index type part of a CREATE INDEX statement.
 * 
 */

module lang.sql.parsers.builders;

/**
 * This class : the builder for the index type of a CREATE INDEX
 * statement. 
 * You can overwrite all functions to achieve another handling.
 *
 
 
 *  
 */
class CreateIndexTypeBuilder : IndexTypeBuilder {

    auto build(array $parsed) {
        if (!isset($parsed["index-type"]) || $parsed["index-type"] == false) {
            return '';
        }
        return parent::build($parsed["index-type"]);
    }
}
