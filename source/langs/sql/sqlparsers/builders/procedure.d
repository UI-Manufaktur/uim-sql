
module langs.sql.sqlparsers.builders.procedure;

import lang.sql;

@safe:

/**
 * Builds the procedures within the SHOW statement. 
 * This class : the builder for a procedure within SHOW statement. 
 * You can overwrite all functions to achieve another handling. */
class ProcedureBuilder : ISqlBuilder {

    string build(Json parsedSQL) {
        if (!parsedSQL["expr_type"].isExpressionType("PROCEDURE")) {
            return "";
        }
        return parsedSQL["base_expr"];
    }
}
