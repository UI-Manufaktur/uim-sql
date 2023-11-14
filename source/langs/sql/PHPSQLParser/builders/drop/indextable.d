module source.langs.sql.PHPSQLParser.builders.drop.indextable;

import lang.sql;

@safe:

/**
 * This class : the builder for the table part of a DROP INDEX statement.
 * You can overwrite all functions to achieve another handling. */
class DropIndexTableBuilder : ISqlBuilder {

    string build(array $parsed) {
        if (!isset($parsed["on"]) || $parsed["on"] == false) {
            return "";
        }
        $table = $parsed["on"];
        if ($table["expr_type"] != ExpressionType::TABLE) {
            return "";
        }
        return 'ON ' . $table["name"];
    }

}
